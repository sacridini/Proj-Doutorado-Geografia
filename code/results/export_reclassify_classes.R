library(terra)

# 1,1,33991146,"0-200"
# 1,2,15167438,"200-300"
# 1,3,7299394,"300-400"
# 1,4,4230212,"400-600"
# 1,5,435984,"600-800"
# 1,6,60665,"800-"

input_path <- "~/doutorado/testes/gain/finais/albers/analysis_by_class/gain_seg6_masked18_dur_gt4_inv_for_albers_reclass.tif"

for(i in 1:6) {
  base_ras <- terra::rast(input_path)
  base_ras[base_ras != i] <- NA
  new_name <- paste0(tools::file_path_sans_ext(basename(input_path)), "_class_", i, ".tif")
  terra::writeRaster(base_ras, paste0("~/doutorado/testes/gain/finais/albers/analysis_by_class/", new_name),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
}
