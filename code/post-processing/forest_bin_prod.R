library(terra)

raster_paths <- list.files("~/doutorado/raster/mapbiomas41/bin_forest/", pattern = "*.tif", full.names = TRUE)
raster_stack <- terra::rast(raster_paths)
raster_prod <- terra::app(raster_stack, base::prod)
terra::writeRaster(raster_prod, "~/doutorado/raster/mapbiomas41/bin_forest/bin_forest_prod.tif", wopt=list(gdal=c("COMPRESS=DEFLATE")))