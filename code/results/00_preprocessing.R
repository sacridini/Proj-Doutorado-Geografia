library(terra)

mb_85 <- terra::rast("~/doutorado/testes/loss/resample_mb_85_for_bin.tif")
mb_18 <- terra::rast("~/doutorado/testes/gain/resample_mb_18_for_bin.tif")
loss <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_loss_greatest_2018_seg6/mosaics/mosaic_clip_magnitude.tif")


# Gain test (dur <= 3) ----------------------------------------------------
gain_dur <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_gain_greatest_2018_seg6/mosaics/mosaic_clip_duration.tif")
gain_dur[gain_dur > 3] <- NA
terra::writeRaster(gain_dur, "~/doutorado/testes/gain/gain_dur_gt3.tif",  wopt=list(gdal=c("COMPRESS=DEFLATE")))


# Resample of gain_seg_6_masked18_zeros (preprocessing) -------------------
gain_seg_6_original <- terra::rast("~/doutorado/testes/loss/gain_seg6_masked18_zeros.tif")
gain_seg_6_resampled <- terra::resample(gain_seg_6_original, loss, method = 'near',
                                        filename = "~/doutorado/testes/loss/gain_seg6_masked18_zeros_resampled.tif",
                                        wopt=list(gdal=c("COMPRESS=DEFLATE")))

# Resample of gain_seg_6_dur_gt4 (preprocessing) -------------------
gain_seg_6_dur_gt4 <- terra::rast("~/doutorado/testes/gain/gain_seg6_masked18_dur_gt4.tif")
gain_seg_6_resampled <- terra::resample(gain_seg_6_original, loss, method = 'near',
                                        filename = "~/doutorado/testes/gain/gain_seg6_masked18_dur_gt4_resampled.tif",
                                        wopt=list(gdal=c("COMPRESS=DEFLATE")))


# Resample of invariant_forests_mapbiomas_inverse (preprocessing) ---------
invariant_forests_mapbiomas_inverse <- terra::rast("/media/elacerda/backup/doutorado_backup/resultados_fevereiro/gain/invariant_forests_mapbiomas_inverse.tif")
invariant_forests_mapbiomas_inverse_resampled <- terra::resample(invariant_forests_mapbiomas_inverse, loss, method = 'near',
                                                                 filename = "~/doutorado/testes/gain/invariant_forests_mapbiomas_inverse_resampled.tif",
                                                                 wopt=list(gdal=c("COMPRESS=DEFLATE")))

# Convert 0 to NA (preprocessing) -----------------------------------------
rcl <- cbind(0, NA)

mb_18_NA <- terra::classify(mb_18, rcl)
terra::writeRaster(mb_18_NA, "~/doutorado/testes/gain/resample_mb_18_for_bin_reclass.tif", wopt=list(gdal=c("COMPRESS=DEFLATE")))

mb_85_NA <- terra::classify(mb_85, rcl)
terra::writeRaster(mb_85_NA, "~/doutorado/testes/loss/resample_mb_85_for_bin_reclass.tif", wopt=list(gdal=c("COMPRESS=DEFLATE")))