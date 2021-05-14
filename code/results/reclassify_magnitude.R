library(terra)

magnitude <- terra::rast("~/doutorado/testes/loss/finais/albers/loss_masked85_maskedGain_albers.tif")

magnitude[magnitude > 800] <- NA
f800 <- freq(magnitude)

magnitude[magnitude > 600] <- NA
f600 <- freq(magnitude)

magnitude[magnitude > 400] <- NA
f400 <- freq(magnitude)

magnitude[magnitude > 300] <- NA
f300 <- freq(magnitude)

magnitude[magnitude > 200] <- NA
f200 <- freq(magnitude)

results_df <- data.frame(f800 = sum(f800[,3]),
                         f600 = sum(f600[,3]),
                         f400 = sum(f400[,3]),
                         f300 = sum(f300[,3]),
                         f200 = sum(f200[,3]))

write.csv(results_df, "~/doutorado/testes/loss/finais/loss_masked85_maskedGain_albers_magnitude_classes.csv", sep = ",", row.names = FALSE)
