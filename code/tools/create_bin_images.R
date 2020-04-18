library(fs)

app_path <- "/home/iis_backup/development/cpp/cpp_random_utils/"
base_dir_path <- "/home/iis_backup/doutorado/raster/mapbiomas41/"
raw_ma_path <- list.files(base_dir_path,
                          pattern = "*.tif", full.names = TRUE)

for (f in raw_ma_path) {
  f_out_name <- paste0(gsub(".tif$", "", fs::path_file(f)), "_bin_past_agr.tif")
  cmd <- paste0(app_path, "./gdal_simple_reclassify ", f,  " ", base_dir_path, "/", f_out_name)
  print(cmd)
  system(cmd)
}