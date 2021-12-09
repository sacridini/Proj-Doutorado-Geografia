library(raster)
library(dplyr)

area_name <- "bhrsj"
base_path <- "//192.168.0.134/doutorado/validation/"

# raster inicial com as 3 classes (loss, gain e pseudo-invariante)
# 0 - pseudo-invariante
# 1 - loss
# 5 - gain
in_ras <- raster::raster(paste0(base_path, area_name,  "/", area_name, "_loss_gain_inv.tif")) # load
strat_samples <- raster::sampleStratified(x = in_ras, size = 10000) # stratified sample

ras_strat_sample <- in_ras - in_ras
ras_strat_sample[strat_samples[,1]] <- in_ras[strat_samples[,1]] # subset
ras_strat_sample_pnts <- raster::rasterToPoints(ras_strat_sample) # as vector
ras_strat_sample_df <- as.data.frame(ras_strat_sample_pnts)
rr_df_inv_samples <- dplyr::sample_n(ras_strat_sample_df[ras_strat_sample_df$layer %in% 0,], 100) # subset random 100 of one class
rr_df_loss_samples <- dplyr::sample_n(ras_strat_sample_df[ras_strat_sample_df$layer %in% 1,], 100) # subset random 100 of one class
rr_df_gain_samples <- dplyr::sample_n(ras_strat_sample_df[ras_strat_sample_df$layer %in% 5,], 100) # subset random 100 of one class
rr_df_inv_samples$id <- seq(1:100)
rr_df_loss_samples$id <- seq(1:100)
rr_df_gain_samples$id <- seq(1:100)
write.csv(rr_df_inv_samples, paste0(base_path, area_name,  "/", area_name, "_sample_inv.csv"), row.names = F)
write.csv(rr_df_loss_samples, paste0(base_path, area_name,  "/", area_name, "_sample_loss.csv"), row.names = F)
write.csv(rr_df_gain_samples, paste0(base_path, area_name,  "/", area_name, "_sample_gain.csv"), row.names = F)