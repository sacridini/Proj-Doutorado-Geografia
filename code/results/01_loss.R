library(terra)

mb_85 <- terra::rast("~/doutorado/testes/loss/resample_mb_85_for_bin.tif")
loss <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_loss_greatest_2018_seg6/mosaics/mosaic_clip_magnitude.tif")

# Resample of gain_seg_6_masked18_zeros (preprocessing) -------------------
gain_seg_6_original <- terra::rast("~/doutorado/testes/loss/gain_seg6_masked18_zeros.tif")
gain_seg_6_resampled <- terra::resample(gain_seg_6_original, loss, method = 'near',
                                        filename = "~/doutorado/testes/loss/gain_seg6_masked18_zeros_resampled.tif",
                                        wopt=list(gdal=c("COMPRESS=DEFLATE")))

# Convert 0 to NA (preprocessing) -----------------------------------------
rcl <- cbind(0, NA)
mb_85_NA <- terra::classify(mb_85, rcl)
terra::writeRaster(mb_85_NA, "~/doutorado/testes/loss/resample_mb_85_for_bin_reclass.tif")

# Create loss_masked85 ----------------------------------------------------
loss_mb85 <- mb_85_NA * loss
terra::writeRaster(loss_mb85, "~/doutorado/testes/loss/loss_masked85.tif",  wopt=list(gdal=c("COMPRESS=DEFLATE")))

