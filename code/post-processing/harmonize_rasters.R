library(foreach)
library(doParallel)

files_path <- "~/doutorado/raster/mapbiomas41/bin_inverses/"
setwd(files_path)
files_to_process = list.files(files_path)
base_vector_path <- "~/doutorado/vector/mata_atlantica/ma_mapbiomas_shape_fx.shp"

cl = makeCluster(3, outfile = "")
registerDoParallel(cl)

foreach (f = files_to_process[1:length(files_to_process)]) %dopar% {
  f_out_name <- paste0(gsub(".tif$", "", fs::path_file(f)), "_clip.tif")
  system(paste0("gdalwarp -cutline ", base_vector_path, 
                " -tr 0.0002694981 0.0002694975 -crop_to_cutline ", 
                f, " ", f_out_name,
                " -co COMPRESS=DEFLATE"))
}

stopCluster(cl)

# 0.0002694981469934048753 0.0002694981469934048753