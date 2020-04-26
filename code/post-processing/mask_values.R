library(raster)
library(foreach)
library(doParallel)

ltr_layer <- "~/doutorado/raster/ltgee_gain_greatest_2018_seg6/mosaics/mosaic_clip_yod.tif"
r1 <- raster(ltr_layer)
files <- list.files("~/doutorado/raster/mapbiomas41/bin_masks/", full.names = TRUE)

# cl = parallel::makeCluster(2, outfile = "")
# doParallel::registerDoParallel(cl)

for (i in 1:length(files)) {
  
  # mask_name <- gsub("bin_", "", fs::path_file(files[i]))
  # mask_name <- gsub("_clip.tif", "", fs::path_file(mask_name))
  # out_filename <- paste0(gsub(".tif", "", ltr_layer), "_", mask_name,"_.tif")
  
  r2 <- raster(files[i])
  r2 <- raster::setExtent(r2, raster::extent(r1))
  r1 <- raster::mask(r1, r2)
}

writeRaster(r1, "~/doutorado/raster/ltgee_gain_greatest_2018_seg6/mosaics/mosaic_yod_final.tif", options = "COMPRESS=DEFLATE")
# parallel::stopCluster(cl)
