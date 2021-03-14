library(terra)

yod <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_gain_greatest_2018_seg6/mosaics/mosaic_clip_yod.tif")
bin_rasters_paths <- list.files("~/doutorado/testes/gain/finais/bin/", pattern = "*.tif", full.names = TRUE)
bin_rasters <- terra::rast(bin_rasters_paths) # raster check
names(bin_rasters) <- tools::file_path_sans_ext(basename(bin_rasters_paths))

for (r in names(bin_rasters)) {
  message(paste0("Processing: ", names(bin_rasters[[r]])))
  result <- bin_rasters[[r]] * yod
  terra::writeRaster(result, paste0("~/doutorado/testes/gain/finais/yod/", names(bin_rasters[[r]]), "_yod.tif"),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
}