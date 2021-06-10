library(terra)


# GAIN --------------------------------------------------------------------
# gain_seg6_masked18_dur_gt4_inv_for_albers -------------------------------
gain_seg6_masked18_dur_gt4_inv_for_albers <-
  terra::vect("~/doutorado/testes/gain/finais/albers/zonal_stats/gain_seg6_masked18_dur_gt4_inv_for_albers.gpkg")
summary(gain_seg6_masked18_dur_gt4_inv_for_albers$mean)
summary(gain_seg6_masked18_dur_gt4_inv_for_albers$median)

# gain_seg6_masked18_dur_gt4_inv_for_yod_albers ---------------------------
gain_seg6_masked18_dur_gt4_inv_for_yod_albers <-
  terra::vect("~/doutorado/testes/gain/finais/albers/zonal_stats/gain_seg6_masked18_dur_gt4_inv_for_yod_albers.gpkg")
summary(gain_seg6_masked18_dur_gt4_inv_for_yod_albers$mean)
summary(gain_seg6_masked18_dur_gt4_inv_for_yod_albers$median)

