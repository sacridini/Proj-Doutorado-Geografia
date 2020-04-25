library(raster)

file_path <- "bin_planted_forest"
output_name <- "bin_planted_forest_sum.tif"

files <- list.files(paste0("~/doutorado/raster/mapbiomas41/", file_path), full.names = TRUE)
rs <- stack(files)
rs_sum <- calc(rs, sum)
writeRaster(rs_sum, paste0("~/doutorado/raster/mapbiomas41/bin_planted_forest/", output_name), options="COMPRESS=DEFLATE")

