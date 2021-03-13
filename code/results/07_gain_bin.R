library(terra)

# gain_seg6_masked18_dur_gt4.tif to bin -------------------------------------
gain_seg6_masked18_dur_gt4 <- rast("~/doutorado/testes/gain/finais/gain_seg6_masked18_dur_gt4.tif")
gain_seg6_masked18_dur_gt4[gain_seg6_masked18_dur_gt4 != 0] <- 1
plot(gain_seg6_masked18_dur_gt4)
terra::writeRaster(gain_seg6_masked18_dur_gt4, "~/doutorado/testes/gain/finais/bin/gain_seg6_masked18_dur_gt4_bin.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))


# gain_seg6_masked18_dur_gt4_inv_for.tif to bin -------------------------------------
gain_seg6_masked18_dur_gt4_inv_for <- rast("~/doutorado/testes/gain/finais/gain_seg6_masked18_dur_gt4_inv_for.tif")
gain_seg6_masked18_dur_gt4_inv_for[gain_seg6_masked18_dur_gt4_inv_for != 0] <- 1
plot(gain_seg6_masked18_dur_gt4_inv_for)
terra::writeRaster(gain_seg6_masked18_dur_gt4_inv_for, "~/doutorado/testes/gain/finais/bin/gain_seg6_masked18_dur_gt4_inv_for_bin.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))
