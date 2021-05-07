# Elevation Analysis

library(terra)

# srtm 30m
dem <- terra::rast("~/doutorado/testes/elevation_analysis/srtm_mata_atlantica_NA.tif")

# loss
loss_masked85_maskedGain_bin <- terra::rast("~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_bin.tif")
loss_masked85_maskedGain_eq1_bin <- terra::rast("~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_dur_eq1_bin.tif")
loss_masked85_maskedGain_neq1_bin <- terra::rast("~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_dur_neq1_bin.tif")

loss_masked85_maskedGain_bin_dem <- dem * loss_masked85_maskedGain_eq1_bin
terra::writeRaster(loss_masked85_maskedGain_bin, "~/doutorado/testes/elevation_analysis/loss_masked85_maskedGain_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

loss_masked85_maskedGain_eq1_bin_dem <- dem * loss_masked85_maskedGain_eq1_bin
terra::writeRaster(loss_masked85_maskedGain_eq1_bin_dem, "~/doutorado/testes/elevation_analysis/loss_masked85_maskedGain_eq1_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

loss_masked85_maskedGain_neq1_bin_dem <- dem * loss_masked85_maskedGain_neq1_bin
terra::writeRaster(loss_masked85_maskedGain_neq1_bin_dem, "~/doutorado/testes/elevation_analysis/loss_masked85_maskedGain_neq1_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))