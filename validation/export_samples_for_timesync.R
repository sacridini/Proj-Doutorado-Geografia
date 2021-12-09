library(raster)
library(dplyr)

base_path <- "C:\\Users/eduardo/Desktop/validação_doutorado/bhrsj/"

# Raster binário com com todos os pixels de mudança igual a 1 e nã --------
ras_bin <- raster::raster(paste0(base_path, "bhrsj_bin.tif"))

# Selecionar apenas pixels que entraram para o resultado final (ma --------
ras_mag <- raster::raster(paste0(base_path, "loss_masked85_maskedGain_bhrsj_yod.tif"))
ras_mag[is.na(ras_mag)] <- 0
ras_bin[ras_bin == 0] <- 2 # tudo que é 0 (invariante/não mudança) vira 2
ras_bin[ras_bin == 1] <- 0
ras <- ras_mag + ras_bin
ras[ras == 0] <- NA
raster::writeRaster(ras, paste0(base_path, "bhrsj_final.tif"), options = "COMPRESS=DEFLATE")
# Ou seja:
# Tudo que é 2 é pixel invariante.
# Tudo que tem valor diferente de 0, 2 e NA, é mudança.
# Parte dos pixels que ficaram como NA são pixels de mudança ... 
# ... que não foram selecionados pelo processo de limpeza do masked85_maskedGain.

ras_temp_strat_sample <- ras
# passa todos os valores de magnitude para 1 porque a função sampleStratified precisa e apenas 2 valores (duas classes...)
ras_temp_strat_sample[ras_temp_strat_sample > 2] <- 1 # agora, tudo que é 2 é invariante e tudo que é 1 é mudança
str_samples <- raster::sampleStratified(x = ras_temp_strat_sample, size = 10000) # strat sample

ras_strat_sample <- ras - ras
ras_strat_sample[str_samples[,1]] <- ras[str_samples[,1]] # subset
ras_strat_sample[ras_strat_sample == 0] <- NA # tira os 0 para transformar em poligono somente o que tem valor
ras_strat_sample_pnts <- raster::rasterToPoints(ras_strat_sample) # as vector
ras_strat_sample_df <- as.data.frame(ras_strat_sample_pnts)
rr_df_loss_samples <- dplyr::sample_n(ras_strat_sample_df[ras_strat_sample_df$layer > 2,], 100) # subset random 100 for loss
rr_df_loss_samples$id <- seq(1:100)
rr_df_inv_samples <- dplyr::sample_n(ras_strat_sample_df[ras_strat_sample_df$layer %in% 2,], 100) # subset random 100 for invariant
rr_df_inv_samples$id <- seq(1:100)
write.csv(rr_df_loss_samples, paste0(base_path, "sample_loss.csv"), row.names = F)
write.csv(rr_df_inv_samples, paste0(base_path, "sample_inv.csv"), row.names = F)
