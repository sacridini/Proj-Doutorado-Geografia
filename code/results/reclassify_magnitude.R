library(terra)

file_name <- "gain_seg6_masked18_dur_gt4_albers.tif"

magnitude <- terra::rast(paste0("~/doutorado/testes/gain/finais/albers/", file_name))

m <- c(0, 200, 1,
       200, 300, 2,
       300, 400, 3,
       400, 600, 4,
       600, 800, 5,
       800, 2000, 6)
reclass_table <- matrix(m, ncol = 3, byrow = TRUE)
reclass <- terra::classify(magnitude, reclass_table, include.lowest = TRUE)

terra::writeRaster(reclass,
                   paste0("~/doutorado/testes/gain/finais/albers/analysis_by_class/", tools::file_path_sans_ext(file_name), "_reclass.tif"),
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

f <- freq(reclass)
f_df <- as.data.frame(f)
f_df$class <- c("0-200", "200-300", "300-400", "400-600", "600-800", "800-")
write.csv(f_df,
          paste0("~/doutorado/testes/gain/finais/albers/analysis_by_class/", tools::file_path_sans_ext(file_name), ".csv"),
          sep = ",", row.names = FALSE)
