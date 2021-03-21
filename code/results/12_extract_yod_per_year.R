library(terra)

base_ras <- terra::rast("~/doutorado/testes/loss/finais/yod/loss_masked85_maskedGain_bin_yod.tif")

for (i in 1985:2018) {
  r_tmp <- base_ras
  r_tmp[r_tmp != i] <- NA
  terra::writeRaster(r_tmp, paste0("~/doutorado/testes/loss/finais/yod/per_year/", i, ".tif"),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
}
