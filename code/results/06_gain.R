library(terra)

gain_seg6_masked18_dur_gt4 <- terra::rast("~/doutorado/testes/gain/finais/gain_seg6_masked18_dur_gt4.tif")
invariant_forest <- terra::rast("~/doutorado/testes/gain/invariant_forests_mapbiomas_inverse.tif")
gain_seg6_masked18_dur_gt4_inv_for <- gain_seg6_masked18_dur_gt4 * invariant_forest
terra::writeRaster(gain_seg6_masked18_dur_gt4_inv_for, "~/doutorado/testes/gain/finais/gain_seg6_masked18_dur_gt4_inv_for.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))