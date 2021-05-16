library(terra)

magnitude <- terra::rast("~/doutorado/testes/gain/finais/albers/gain_seg6_masked18_dur_gt4_inv_for_albers.tif")

m <- c(0, 200, 1,
       200, 300, 2,
       300, 400, 3,
       400, 600, 4,
       600, 800, 5,
       800, 2000, 6)
reclass_table <- matrix(m, ncol = 3, byrow = TRUE)
reclass <- terra::classify(magnitude, reclass_table, include.lowest = TRUE)

terra::writeRaster(reclass, "~/doutorado/testes/gain/finais/albers/analysis_by_class/gain_seg6_masked18_dur_gt4_inv_for_albers_reclass.tif",
                   wopt=list(gdal=c("COMPRESS=DEFLATE")))

f <- freq(reclass)
f_df <- as.data.frame(f)
f_df$class <- c("0-200", "200-300", "300-400", "400-600", "600-800", "800-")
write.csv(f_df, "~/doutorado/testes/gain/finais/albers/analysis_by_class/gain_seg6_masked18_dur_gt4_inv_for_albers.csv",
          sep = ",", row.names = FALSE)
