library(raster)
r <- raster::raster("~/doutorado/raster/ltgee_loss_greatest_2018_seg6/analysis/gt200/loss_seg6_mag_gt200_bin.tif")
v <- raster::shapefile("~/doutorado/vector/points/random_points/ma_mapbiomas_100000_random_points.shp")
x <- raster::extract(r, v) # extract values (a lot of NA's probably)
x_sub <- which(x %in% v$id) # subset
v_sub <- v[x_sub, ] # subset and create a new shapefile with just valid points
v_sub$long <- v_sub@coords[,1] # add longitude to final shapefile
v_sub$lat <- v_sub@coords[,2] # add latitude to final shapefile
raster::shapefile(v_sub, "~/doutorado/vector/points/ltgee_loss_greatest_2018_seg6/v_sub_loss_seg6.shp")