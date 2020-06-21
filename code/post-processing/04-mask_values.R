library(raster)

ltr_layer <- "~/doutorado/raster/gain_mag_gt200_dur_gt4_preval_gt400_2018/mosaics/mosaic_yod.tif"
r1 <- raster(ltr_layer)
files <- list.files("~/doutorado/raster/mapbiomas41/bin_masks", full.names = TRUE)

for (i in 1:length(files)) {
  r2 <- raster(files[i])
  message(paste0("Start to process file", files[i]))
  r2 <- raster::setExtent(r2, raster::extent(r1))
  r1 <- raster::mask(r1, r2)
}

writeRaster(r1, "~/doutorado/raster/gain_mag_gt200_dur_gt4_preval_gt400_2018/mosaics/mosaic_yod_masked.tif",
            options = "COMPRESS=DEFLATE", overwrite = TRUE)