library(raster)
library(foreach)
library(doParallel)

ltr_layer <- "~/doutorado/raster/ltgee_loss_greatest_2018_seg12/mosaics/mosaic_clip_magnitude.tif"
r1 <- raster(ltr_layer)
files <- list.files("~/doutorado/raster/mapbiomas41/bin_masks/", full.names = TRUE)

cl = parallel::makeCluster(2, outfile = "")
doParallel::registerDoParallel(cl)

foreach (i = 1:length(files), .export = "raster") %dopar% {
  out_filename <- paste0(gsub(".tif", "", ltr_layer), "_masked.tif")
  r2 <- raster(files[i])
  r2 <- raster::setExtent(r2, raster::extent(r1))
  r1_masked <- raster::mask(r1, r2)
  writeRaster(r1_masked, out_filename, options = "COMPRESS=DEFLATE")
}

parallel::stopCluster(cl)
