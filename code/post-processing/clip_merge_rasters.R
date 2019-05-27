# Setup -------------------------------------------------------------------
library(raster)
library(gdalUtils)

# Clip Raster -------------------------------------------------------------
ltr_rasters <- list.files("/media/eduardo/data/Doutorado/raster/ltgee_loss_greatest", pattern = "*.tif", full.names = TRUE)
voronoi_vectors <- list.files("/media/eduardo/data/Doutorado/vector/voronoi_splits", pattern = "*.shp", full.names = TRUE)
vector_names <- list.files("/media/eduardo/data/Doutorado/vector/voronoi_splits", pattern = "*.shp")

for(i in 1:length(ltr_rasters))
{
  output_name <- paste0(gsub(pattern = "\\.shp$", "", vector_names[[i]]), "_clip.tif")
  system(paste0("gdalwarp -cutline ",
                voronoi_vectors[[i]],
                " -crop_to_cutline ",
                ltr_rasters[[i]],
                " /media/eduardo/data/Doutorado/raster/ltgee_loss_greatest/clip/", output_name ,
                " -co BIGTIFF=YES -wm 2000 -co COMPRESS=DEFLATE -multi -wo NUM_THREADS=ALL_CPUS"))
}


# Zero to NA --------------------------------------------------------------
clip_path <- list.files("/media/eduardo/data/Doutorado/raster/ltgee_loss_greatest/clip", pattern = "*.tif", full.names = TRUE)

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
system(paste0("gdalbuildvrt /media/eduardo/data/Doutorado/raster/ltgee_loss_greatest/clip/mosaic.vrt *na.tif -a_srs \"EPSG:4326\""))

# Create Mosaic -----------------------------------------------------------
system(paste0("gdal_translate -of GTiff -ot UInt16 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 -co BIGTIFF=YES -a_srs epsg:4326 ",
              "/media/eduardo/data/Doutorado/raster/ltgee_loss_greatest/clip/mosaic.vrt ",
              "/media/eduardo/data/Doutorado/raster/ltgee_loss_greatest/clip/mosaic.tif"))
