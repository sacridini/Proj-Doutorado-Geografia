library(terra)

loss <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_loss_greatest_2018_seg6/mosaics/mosaic_clip_magnitude.tif")

# Create loss_masked85 ----------------------------------------------------
loss_mb85 <- mb_85_NA * loss
terra::writeRaster(loss_mb85, "~/doutorado/testes/loss/loss_masked85.tif",  wopt=list(gdal=c("COMPRESS=DEFLATE")))

# Create loss_masked85_dur_eq1 --------------------------------------------
dur_eq1 <- terra::rast("~/doutorado/testes/loss/loss_dur_eq1.tif")
loss_mb85_dur_eq1 <- loss_mb85 * dur_eq1
terra::writeRaster(loss_mb85_dur_eq1, "~/doutorado/testes/loss/loss_masked85_dur_eq1.tif", wopt=list(gdal=c("COMPRESS=DEFLATE")))

# Create loss_masked85_dur_neq1 -------------------------------------------
dur_neq1 <- terra::rast("~/doutorado/testes/loss/loss_dur_neq1.tif")
loss_mb85_dur_neq1 <- loss_mb85 * dur_neq1
terra::writeRaster(loss_mb85_dur_neq1, "~/doutorado/testes/loss/loss_masked85_dur_neq1.tif", wopt=list(gdal=c("COMPRESS=DEFLATE")))