library(terra)

v <- vect("~/doutorado/validation/estacional_semidecidual/estacional_semidecidual.gpkg")
r_loss <- rast("~/doutorado/validation/estacional_semidecidual/estacional_semidecidual_loss_mag.tif")
r_gain <- rast("~/doutorado/validation/estacional_semidecidual/estacional_semidecidual_gain_mag.tif")
# o vetor é necessário para ajustar o extent
v_rast <- r_loss - r_loss
v_rast <- terra::rasterize(v, v_rast)
# reclass da perda
r_loss[r_loss > 0] <- 1
r_loss[is.na(r_loss)] <- 0
# reclass do ganho
r_gain[r_gain > 0] <- 5
r_gain[is.na(r_gain)] <- 0
r_final <- (r_loss + r_gain) * v_rast
r_final[r_final == 6] <- 0 # retira sobreposições
terra::writeRaster(r_final, "~/doutorado/validation/estacional_semidecidual/estacional_semidecidual_loss_gain_inv.tif")
