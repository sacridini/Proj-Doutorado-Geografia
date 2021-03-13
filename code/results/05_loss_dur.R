library(terra)

dur <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_loss_greatest_2018_seg6/mosaics/mosaic_clip_duration.tif")
bin_rasters_paths <- list.files("~/doutorado/testes/loss/finais/bin/", pattern = "*.tif", full.names = TRUE)
bin_rasters <- terra::rast(bin_rasters_paths) # raster check
names(bin_rasters) <- tools::file_path_sans_ext(basename(bin_rasters_paths))
bin_rasters_subset <- names(bin_rasters)[grepl("neq1", names(bin_rasters))]
bin_rasters_subset <- append(bin_rasters_subset, names(bin_rasters)[!grepl("eq1", names(bin_rasters))])

for (r in bin_rasters_subset) {
  message(paste0("Processing: ", names(bin_rasters[[r]])))
  result <- bin_rasters[[r]] * dur
  terra::writeRaster(result, paste0("~/doutorado/testes/loss/finais/dur/", names(bin_rasters[[r]]), "_dur.tif"), wopt=list(gdal=c("COMPRESS=DEFLATE")))
}