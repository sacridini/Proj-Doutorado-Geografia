library(terra)

loss <- terra::rast("/media/elacerda/backup/doutorado_backup/raster/ltgee_loss_greatest_2018_seg6/mosaics/mosaic_clip_magnitude.tif")

# Create loss_masked85 ----------------------------------------------------
loss_mb85 <- mb_85_NA * loss
terra::writeRaster(loss_mb85, "~/doutorado/testes/loss/loss_masked85.tif",  wopt=list(gdal=c("COMPRESS=DEFLATE")))