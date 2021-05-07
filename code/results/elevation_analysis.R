# Elevation Analysis

library(terra)

# srtm 30m
dem <- terra::rast("~/doutorado/testes/elevation_analysis/srtm_mata_atlantica_NA.tif")

# loss
loss_masked85_maskedGain_bin <- terra::rast("~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_bin.tif")
loss_masked85_maskedGain_eq1_bin <- terra::rast("~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_dur_eq1_bin.tif")
loss_masked85_maskedGain_neq1_bin <- terra::rast("~/doutorado/testes/loss/finais/bin/loss_masked85_maskedGain_dur_neq1_bin.tif")

loss_masked85_maskedGain_bin_dem <- dem * loss_masked85_maskedGain_bin
terra::writeRaster(loss_masked85_maskedGain_bin_dem, "~/doutorado/testes/elevation_analysis/loss_masked85_maskedGain_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

loss_masked85_maskedGain_eq1_bin_dem <- dem * loss_masked85_maskedGain_eq1_bin
terra::writeRaster(loss_masked85_maskedGain_eq1_bin_dem, "~/doutorado/testes/elevation_analysis/loss_masked85_maskedGain_eq1_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

loss_masked85_maskedGain_neq1_bin_dem <- dem * loss_masked85_maskedGain_neq1_bin
terra::writeRaster(loss_masked85_maskedGain_neq1_bin_dem, "~/doutorado/testes/elevation_analysis/loss_masked85_maskedGain_neq1_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

# gain

gain_seg6_masked18_dur_gt4_bin <- terra::rast("~/doutorado/testes/gain/finais/bin/gain_seg6_masked18_dur_gt4_bin.tif")
gain_seg6_masked18_dur_gt4_inv_for_bin <- terra::rast("~/doutorado/testes/gain/finais/bin/gain_seg6_masked18_dur_gt4_inv_for_bin.tif")

gain_seg6_masked18_dur_gt4_bin_dem <- dem * gain_seg6_masked18_dur_gt4_bin
terra::writeRaster(gain_seg6_masked18_dur_gt4_bin_dem, "~/doutorado/testes/elevation_analysis/gain_seg6_masked18_dur_gt4_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

gain_seg6_masked18_dur_gt4_inv_for_bin_dem <- dem * gain_seg6_masked18_dur_gt4_inv_for_bin
terra::writeRaster(gain_seg6_masked18_dur_gt4_inv_for_bin_dem, "~/doutorado/testes/elevation_analysis/gain_seg6_masked18_dur_gt4_inv_for_bin_dem.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))