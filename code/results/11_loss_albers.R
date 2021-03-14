library(terra)

loss_folder <- "~/doutorado/testes/loss/"


# Create base folder ------------------------------------------------------
if (!dir.exists(paste0(loss_folder, "finais_albers"))) {
  message("Creating directory 'finais_albers'")
  dir.create(paste0(loss_folder, "finais_albers/"))
} else {
  message("Directory 'finais_albers' already exists.")
}


# Create yod subfolder ----------------------------------------------------
if (!dir.exists(paste0(loss_folder, "finais_albers/yod"))) {
  message("Creating directory 'yod'")
  dir.create(paste0(loss_folder, "finais_albers/yod"))
} else {
  message("Directory 'yod' already exists.")
}


# Create preval subfolder -------------------------------------------------
if (!dir.exists(paste0(loss_folder, "finais_albers/preval"))) {
  message("Creating directory 'preval'")
  dir.create(paste0(loss_folder, "finais_albers/preval"))
} else {
  message("Directory 'preval' already exists.")
}


# Create dur subfolder ----------------------------------------------------
if (!dir.exists(paste0(loss_folder, "finais_albers/dur"))) {
  message("Creating directory 'dur'")
  dir.create(paste0(loss_folder, "finais_albers/dur"))
} else {
  message("Directory 'dur' already exists.")
}


# Specify base rasters with albers projection -----------------------------
albers_base <- terra::rast("~/doutorado/testes/loss/loss_masked85_albers.tif")


# Resample finais ---------------------------------------------------------
finais_path <- list.files(paste0(loss_folder, "finais"), pattern = "*.tif", full.names = TRUE)
finais_rasters <- terra::rast(finais_path) # raster check
names(finais_rasters) <- tools::file_path_sans_ext(basename(finais_path))

for (r in names(finais_rasters)) {
  message(paste0("Processing: ", names(finais_rasters[[r]])))
  result <- terra::resample(finais_rasters[[r]], albers_base, method = "ngb")
  terra::writeRaster(result, paste0(loss_folder, "finais_albers/", names(finais_rasters[[r]]), "_albers.tif"),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
}


# Resample yod ------------------------------------------------------------
yod_path <- list.files(paste0(loss_folder, "finais"), pattern = "*.tif", full.names = TRUE)
yod_rasters <- terra::rast(yod_path) # raster check
names(yod_rasters) <- tools::file_path_sans_ext(basename(yod_path))

for (r in names(yod_rasters)) {
  message(paste0("Processing: ", names(yod_rasters[[r]])))
  result <- terra::resample(yod_rasters[[r]], albers_base, method = "ngb")
  terra::writeRaster(result, paste0(loss_folder, "finais_albers/yod/", names(yod_rasters[[r]]), "_albers.tif"),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
}


# Resample preval ---------------------------------------------------------
preval_path <- list.files(paste0(loss_folder, "finais"), pattern = "*.tif", full.names = TRUE)
preval_rasters <- terra::rast(preval_path) # raster check
names(preval_rasters) <- tools::file_path_sans_ext(basename(preval_path))

for (r in names(preval_rasters)) {
  message(paste0("Processing: ", names(preval_rasters[[r]])))
  result <- terra::resample(preval_rasters[[r]], albers_base, method = "ngb")
  terra::writeRaster(result, paste0(loss_folder, "finais_albers/preval/", names(preval_rasters[[r]]), "_albers.tif"),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
}


# Resample dur ------------------------------------------------------------
dur_path <- list.files(paste0(loss_folder, "finais"), pattern = "*.tif", full.names = TRUE)
dur_rasters <- terra::rast(dur_path) # raster check
names(dur_rasters) <- tools::file_path_sans_ext(basename(dur_path))

for (r in names(dur_rasters)) {
  message(paste0("Processing: ", names(dur_rasters[[r]])))
  result <- terra::resample(dur_rasters[[r]], albers_base, method = "ngb")
  terra::writeRaster(result, paste0(loss_folder, "finais_albers/dur/", names(dur_rasters[[r]]), "_albers.tif"),
                     wopt=list(gdal=c("COMPRESS=DEFLATE")))
} 