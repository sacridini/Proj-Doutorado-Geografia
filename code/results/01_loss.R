library(terra)


# loss_masked85_maskedGain.tif to bin -------------------------------------
loss_masked85_gain <- rast("~/doutorado/testes/loss/finais/loss_masked85_maskedGain.tif")
loss_masked85_gain[loss_masked85_gain != 0] <- 1
plot(loss_masked85_gain)
terra::writeRaster(loss_masked85_gain, "~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_bin.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))


# loss_masked85_maskedGain_dur_eq1 to bin ---------------------------------
loss_masked85_maskedGain_dur_eq1 <- rast("~/doutorado/testes/loss/finais/loss_masked85_maskedGain_dur_eq1.tif")
loss_masked85_maskedGain_dur_eq1[loss_masked85_maskedGain_dur_eq1 != 0] <- 1
plot(loss_masked85_maskedGain_dur_eq1)
terra::writeRaster(loss_masked85_maskedGain_dur_eq1, "~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_dur_eq1_bin.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

# loss_masked85_maskedGain_dur_nneq1 to bin ---------------------------------
loss_masked85_maskedGain_dur_neq1 <- rast("~/doutorado/testes/loss/finais/loss_masked85_maskedGain_dur_neq1.tif")
loss_masked85_maskedGain_dur_neq1[loss_masked85_maskedGain_dur_neq1 != 0] <- 1
plot(loss_masked85_maskedGain_dur_neq1)
terra::writeRaster(loss_masked85_maskedGain_dur_neq1, "~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_dur_neq1_bin.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))