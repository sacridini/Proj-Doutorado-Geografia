library(raster)
r <- raster("~/doutorado/raster/ltgee_loss_greatest_2018_seg6/analysis/gt200/loss_seg6_mag_gt200_bin.tif")
v <- shapefile("~/doutorado/vector/points/random_points/ma_mapbiomas_100000_random_points.shp")
x <- raster::extract(r, v) 
x_sub <- which(x %in% v$id)
v_sub <- v[x_sub, ]
v_sub$long <- v_sub@coords[,1]
v_sub$lat <- v_sub@coords[,2]