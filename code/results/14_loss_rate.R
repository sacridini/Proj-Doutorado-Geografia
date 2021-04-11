library(terra)

preval <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_loss_greatest_2018_seg6/mosaics/mosaic_clip_rate.tif")
bin_rasters_paths <- list.files("~/doutorado/testes/loss/finais/bin/", pattern = "*.tif", full.names = TRUE)
bin_rasters <- terra::rast(bin_rasters_paths) # raster check
names(bin_rasters) <- tools::file_path_sans_ext(basename(bin_rasters_paths))

for (r in names(bin_rasters)) {
  message(paste0("Processing: ", names(bin_rasters[[r]])))
  result <- bin_rasters[[r]] * preval
  terra::writeRaster(result, paste0("~/doutorado/testes/loss/finais/rate/", names(bin_rasters[[r]]), "_rate.tif"),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
}