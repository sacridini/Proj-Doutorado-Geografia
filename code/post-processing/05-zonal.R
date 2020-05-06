library(raster)
mask <- raster("~/doutorado/raster/ma_mapbiomas_mask.tif")
ltr_mag <- raster("~/doutorado/raster/ltgee_gain_greatest_2018_seg6/mosaics/mosaic_clip_magnitude.tif")
z_mag_gain <- raster::zonal(ltr_mag, mask, "mean")
message(z_mag_gain)

ltr_dur <- raster("~/doutorado/raster/ltgee_gain_greatest_2018_seg6/mosaics/mosaic_clip_duration.tif")
z_dur_gain <- raster::zonal(ltr_dur, mask, "mean")
message(z_dur_gain)

ltr_yod <- raster("~/doutorado/raster/ltgee_gain_greatest_2018_seg6/mosaics/mosaic_clip_yod.tif")
z_yod_gain <- raster::zonal(ltr_yod, mask, "mean")
message(z_yod_gain)