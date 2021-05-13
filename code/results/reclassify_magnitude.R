library(terra)

magnitude <- terra::rast("~/doutorado/testes/loss/finais/albers/loss_masked85_maskedGain_albers.tif")

magnitude[magnitude > 800] <- NA
f800 <- freq(magnitude)
sum(f800[,3])

magnitude[magnitude > 600] <- NA
f600 <- freq(magnitude)
sum(f600[,3])

magnitude[magnitude > 400] <- NA
f400 <- freq(magnitude)
sum(f400[,3])

magnitude[magnitude > 300] <- NA
f300 <- freq(magnitude)
sum(f300[,3])

magnitude[magnitude > 200] <- NA
f200 <- freq(magnitude)
sum(f200[,3])

results_df <- data.frame(f800 = f800,
                         f600 = f600,
                         f400 = f400,
                         f300 = f300,
                         f200 = f200)

write.csv(results_df, "~/doutorado/testes/loss/finais/loss_masked85_maskedGain_albers_magnitude_classes.csv", sep = ",", row.names = FALSE)