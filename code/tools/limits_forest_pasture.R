library(raster)

vecs <- list.files("~/doutorado/limites_past_vs_for", pattern = "*.shp", full.names = TRUE)
bin_forest_mapbiomas <- "~/doutorado/raster/mapbiomas41/bin_forest/bin_forest_sum_reclass.tif"
bin_pasture_mapbiomas <- "~/doutorado/raster/mapbiomas41/bin_pasture/bin_pasture_sum_reclass.tif"


# Crop and set NA values --------------------------------------------------

# Forest
for(i in 1:length(vecs)) {
  raster_out_filename <- paste0(gsub(pattern = "\\.shp$", "", vecs[i]), "_clip_forest.tif")
  system(paste0("gdalwarp -cutline ", vecs[i], " -crop_to_cutline ", bin_forest_mapbiomas, " ", raster_out_filename, " -co COMPRESS=DEFLATE"))
  raster_out_filename_na <- paste0(gsub(pattern = "\\.tif$", "", raster_out_filename), "_na.tif")
  system(paste0("gdal_translate -a_nodata 0 ", raster_out_filename, " ", raster_out_filename_na, " -co COMPRESS=DEFLATE"))
}

# Pasture
for(i in 1:length(vecs)) {
  raster_out_filename <- paste0(gsub(pattern = "\\.shp$", "", vecs[i]), "_clip_pasture.tif")
  system(paste0("gdalwarp -cutline ", vecs[i], " -crop_to_cutline ", bin_pasture_mapbiomas, " ", raster_out_filename, " -co COMPRESS=DEFLATE"))
  raster_out_filename_na <- paste0(gsub(pattern = "\\.tif$", "", raster_out_filename), "_na.tif")
  system(paste0("gdal_translate -a_nodata 0 ", raster_out_filename, " ", raster_out_filename_na, " -co COMPRESS=DEFLATE"))
}


# Product of NDVI * BIN layer ---------------------------------------------

# Forest
for(i in 1:length(vecs)) {
  ndvi <- raster::raster(paste0(gsub(pattern = "\\.shp$", "", vecs[i]), ".tif"))
  only_forest <- raster::raster(paste0(gsub(pattern = "\\.shp$", "", vecs[i]), "_clip_forest_na.tif"))
  output_filename <- paste0(gsub(pattern = "\\.shp$", "", vecs[i]), "_forest_final.tif")
  harmonized_ndvi <- raster::crop(ndvi, only_forest)
  only_forest_ndvi <- harmonized_ndvi * only_forest
  raster::writeRaster(only_forest_ndvi, output_filename, options = "COMPRESS=DEFLATE")
}

# Pasture
for(i in 1:length(vecs)) {
  ndvi <- raster::raster(paste0(gsub(pattern = "\\.shp$", "", vecs[i]), ".tif"))
  only_pasture <- raster::raster(paste0(gsub(pattern = "\\.shp$", "", vecs[i]), "_clip_pasture_na.tif"))
  output_filename <- paste0(gsub(pattern = "\\.shp$", "", vecs[i]), "_pasture_final.tif")
  harmonized_ndvi <- raster::crop(ndvi, only_pasture)
  only_pasture_ndvi <- harmonized_ndvi * only_pasture
  raster::writeRaster(only_pasture_ndvi, output_filename, options = "COMPRESS=DEFLATE")
}


# Get Raster Statistics ---------------------------------------------------

df_stats <- data.frame(matrix(ncol = 6, nrow = 0))
colnames(df_stats) <- c("id", "mean", "median", "max", "min", "sd")

forest_rasters <- list.files("~/doutorado/limites_past_vs_for", pattern = "*forest_final.tif$", full.names = TRUE)
pasture_rasters <- list.files("~/doutorado/limites_past_vs_for", pattern = "*pasture_final.tif$", full.names = TRUE)

# Forest
df_stats_forest <- data.frame()
for(i in 1:length(forest_rasters)) {
  r <- raster::raster(forest_rasters[i])
  cell_stats <- data.frame("id" = i,
                         "mean" = raster::cellStats(r, base::mean),
                         "median" = raster::cellStats(r, stats::median),
                         "max" = raster::cellStats(r, base::max),
                         "min" = raster::cellStats(r, base::min),
                         "sd" = raster::cellStats(r, stats::sd))
  df_stats_forest <- rbind(df_stats_forest, cell_stats)
}

# Pasture
df_stats_pasture <- data.frame()
for(i in 1:length(pasture_rasters)) {
  r <- raster::raster(pasture_rasters[i])
  cell_stats <- data.frame("id" = i,
                           "mean" = raster::cellStats(r, base::mean),
                           "median" = raster::cellStats(r, stats::median),
                           "max" = raster::cellStats(r, base::max),
                           "min" = raster::cellStats(r, base::min),
                           "sd" = raster::cellStats(r, stats::sd))
  df_stats_pasture <- rbind(df_stats_pasture, cell_stats)
}
