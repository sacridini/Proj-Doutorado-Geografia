# Setup -------------------------------------------------------------------
library(raster)
library(gdalUtils)

# Clip Raster -------------------------------------------------------------
ltr_rasters <- list.files("/media/eduardo/data/Doutorado/raster/ltgee_loss_greatest/", pattern = "*.tif", full.names = TRUE)
voronoi_vectors <- list.files("/media/eduardo/data/Doutorado/vector/voronoi_splits/", pattern = "*.shp", full.names = TRUE)
vector_names <- list.files("/media/eduardo/data/Doutorado/vector/voronoi_splits/", pattern = "*.shp")

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
