# Setup -------------------------------------------------------------------
library(raster)
library(gdalUtils)


ltr_analysis_folder <- "gain_mag_gt200_dur_gt4_preval_gt400_2018"
raster_folder <- "/home/iis_backup/doutorado/raster/"
polygon_folter <- "/home/iis_backup/doutorado/vector/"

# Clip Raster -------------------------------------------------------------
print("Clipping the rasters using the voronoi vectors")
ltr_rasters <- list.files(paste0(raster_folder, ltr_analysis_folder), pattern = "*.tif", full.names = TRUE)
voronoi_vectors <- list.files(paste0(polygon_folter, "voronoi_splits/"), pattern = "*.shp", full.names = TRUE)
vector_names <- list.files(paste0(polygon_folter, "voronoi_splits/"), pattern = "*.shp")

if (!dir.exists(paste0(raster_folder, ltr_analysis_folder, "/clip"))) {
  dir.create(paste0(raster_folder, ltr_analysis_folder, "/clip"))
}

for (i in 1:length(ltr_rasters)) {
  output_name <- paste0(gsub(pattern = "\\.shp$", "", vector_names[[i]]), "_clip.tif")
  system(paste0("gdalwarp -cutline ",
                voronoi_vectors[[i]],
                " -crop_to_cutline ",
                ltr_rasters[[i]], " ",
                raster_folder, ltr_analysis_folder, "/clip/", output_name ,
                " -co BIGTIFF=YES -wm 2000 -co COMPRESS=DEFLATE -multi -wo NUM_THREADS=ALL_CPUS"))
}


# Zero to NA --------------------------------------------------------------
print("Reclassify: 0 to NA")
clip_path <- list.files(paste0(raster_folder, ltr_analysis_folder, "/clip"), pattern = "*.tif", full.names = TRUE)

for(i in 1:length(clip_path)) {
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
setwd(paste0(raster_folder, ltr_analysis_folder, "/clip"))
system(paste0("gdalbuildvrt -overwrite ", raster_folder, ltr_analysis_folder, "/clip/mosaic.vrt *na.tif "))

# Create Mosaic -----------------------------------------------------------
print("Creating Mosaic")
system(paste0("gdal_translate -of GTiff -ot UInt16 -co COMPRESS=DEFLATE -co BIGTIFF=YES ",
              raster_folder, ltr_analysis_folder, "/clip/mosaic.vrt ",
              raster_folder, ltr_analysis_folder, "/clip/mosaic.tif"))


# Clip by MA Shapefile ----------------------------------------------------
print("Clipping the mosaic using the MA Shapefile")
system(paste0("gdalwarp -cutline ",
              polygon_folter, "mata_atlantica/ma_mapbiomas_shape.shp",
              " -crop_to_cutline ",
              raster_folder, ltr_analysis_folder, "/mosaics/mosaic.tif ",
              raster_folder, ltr_analysis_folder, "/mosaics/mosaic_clip.tif",
              " -co BIGTIFF=YES -wm 2000 -co COMPRESS=DEFLATE -multi -wo NUM_THREADS=ALL_CPUS ",
              " --config GDALWARP_IGNORE_BAD_CUTLINE YES"))
