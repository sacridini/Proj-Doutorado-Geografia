library(raster)

file_path <- "bin_forest"
output_name <- "bin_forest_prod.tif"

files <- list.files(paste0("~/doutorado/raster/mapbiomas41/", file_path), full.names = TRUE)
rs <- stack(files)
rs_sum <- calc(rs, prod)
writeRaster(rs_sum, paste0("~/doutorado/raster/mapbiomas41/bin_forest/bin_forest_bin_prod.tif", output_name), options="COMPRESS=DEFLATE")

