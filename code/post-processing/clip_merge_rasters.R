# Setup -------------------------------------------------------------------
library(raster)
library(gdalUtils)

ltr_analysis_folder <- "ltgee_loss_greatest"
raster_folder <- "/media/eduardo/data/Doutorado/raster/"

# Clip Raster -------------------------------------------------------------
print("Clipping the rasters using the voronoi vectors")
ltr_rasters <- list.files(paste0(raster_folder, ltr_analysis_folder), pattern = "*.tif", full.names = TRUE)
voronoi_vectors <- list.files("/media/eduardo/data/Doutorado/vector/voronoi_splits", pattern = "*.shp", full.names = TRUE)
vector_names <- list.files("/media/eduardo/data/Doutorado/vector/voronoi_splits", pattern = "*.shp")

for(i in 1:length(ltr_rasters))
{
  output_name <- paste0(gsub(pattern = "\\.shp$", "", vector_names[[i]]), "_clip.tif")
  system(paste0("gdalwarp -cutline ",
                voronoi_vectors[[i]],
                " -crop_to_cutline ",
                ltr_rasters[[i]],
                raster_folder, ltr_analysis_folder, "/clip/", output_name ,
                " -co BIGTIFF=YES -wm 2000 -co COMPRESS=DEFLATE -multi -wo NUM_THREADS=ALL_CPUS"))
}


# Zero to NA --------------------------------------------------------------
print("Reclassify: 0 to NA")
clip_path <- list.files(raster_folder, ltr_analysis_folder, "/clip", pattern = "*.tif", full.names = TRUE)

for(i in 1:length(clip_path))
{
  output_name <- paste0(gsub(pattern = "\\.tif$", "", clip_path[[i]]), "_na.tif")
  gdalUtils::gdal_translate(src_dataset = clip_path[[i]],
                            a_nodata = 0,
                            co = "COMPRESS=DEFLATE",
                            ot = "UInt16",
                            dst_dataset = output_name)
  cat(paste0(output_name, " ----- CREATED.", "\n"))
}


# Create VRT --------------------------------------------------------------
print("Creating VRT")
system(paste0("gdalbuildvrt ", raster_folder, ltr_analysis_folder, "/clip/mosaic.vrt *na.tif -a_srs \"EPSG:4326\""))

# Create Mosaic -----------------------------------------------------------
print("Creating Mosaic")
system(paste0("gdal_translate -of GTiff -ot UInt16 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 -co BIGTIFF=YES -a_srs epsg:4326 ",
              raster_folder, ltr_analysis_folder, "/clip/mosaic.vrt ",
              raster_folder, ltr_analysis_folder, "/clip/mosaic.tif"))
    

# Clip by MA Shapefile ----------------------------------------------------
print("Clipping the mosaic using the MA Shapefile")
system(paste0("gdalwarp -cutline ",
              "/media/eduardo/data/Doutorado/vector/mata_atlantica_limite.shp",
              " -crop_to_cutline ",
              raster_folder, ltr_analysis_folder, "/clip/mosaic.tif ",
              raster_folder, ltr_analysis_folder, "/clip/mosaic_clip.tif",
              " -co BIGTIFF=YES -wm 2000 -co COMPRESS=DEFLATE -multi -wo NUM_THREADS=ALL_CPUS ",
              " --config GDALWARP_IGNORE_BAD_CUTLINE YES"))
