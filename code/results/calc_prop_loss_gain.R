library(sf)
library(units)

calc_area <- function(path, format) {
  files_path <- list.files(path, pattern = format, full.names = TRUE)
  files <- lapply(files_path, sf::read_sf)
  for (i in 1:length(files)) {
    files[[i]]$area_m2 <- sf::st_area(f)
    files[[i]]$area_km2 <- units::set_units(files[[i]]$area_m2, km^2)
    files[[i]]$prop_area <- (files[[i]]$X_count * 900)/files[[i]]$area_m2
    sf::write_sf(files[[i]], files_path[i])
  }
}

calc_area("~/doutorado/testes/loss/finais/albers/zonal_stats/", "*.gpkg")
# plot(loss_masked85_maskedGain["prop_loss"])