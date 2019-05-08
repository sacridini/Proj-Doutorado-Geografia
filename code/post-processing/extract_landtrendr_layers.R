rm(list=ls())
graphics.off()
options(warn=0)

library(raster)

path <- paste0("/media/eduardo/data/Doutorado/ltgee_loss_ndvi_mata_atlantica/")
raster_files = list.files(path, pattern = "*.tif")
setwd(path)

for (img in raster_files) {
  
  ltgee_result <- stack(img)
  name_without_ext <- gsub(pattern = "\\.tif$", "", img) # tira o ".tif" do nome
  
  for (i in 1:dim(ltgee_result)[3]) {
    ltgee_layer <- stack(ltgee_result[[i]])
    if (i == 1) {
      layer_type = "yod"
      print(paste0("Extraindo Layer : ", name_without_ext, "_", layer_type))
      writeRaster(ltgee_layer, paste0(name_without_ext, "_", layer_type,".tif"), format = "GTiff", dataType="INT2S", options="COMPRESS=LZW", overwrite=TRUE)
    } else if (i == 2) {
      layer_type = "magnitude"
      print(paste0("Extraindo Layer : ", name_without_ext, "_", layer_type))
      writeRaster(ltgee_layer, paste0(name_without_ext, "_", layer_type,".tif"), format = "GTiff", dataType="INT2S", options="COMPRESS=LZW", overwrite=TRUE)
    } else if (i == 3) {
      layer_type = "duration"
      print(paste0("Extraindo Layer : ", name_without_ext, "_", layer_type))
      writeRaster(ltgee_layer, paste0(name_without_ext, "_", layer_type,".tif"), format = "GTiff", dataType="INT2S", options="COMPRESS=LZW", overwrite=TRUE)
    } else if (i == 4) {
      layer_type = "preval"
      print(paste0("Extraindo Layer : ", name_without_ext, "_", layer_type))
      writeRaster(ltgee_layer, paste0(name_without_ext, "_", layer_type,".tif"), format = "GTiff", dataType="INT2S", options="COMPRESS=LZW", overwrite=TRUE)
    } else if (i == 5) {
      layer_type = "rate"
      print(paste0("Extraindo Layer : ", name_without_ext, "_", layer_type))
      writeRaster(ltgee_layer, paste0(name_without_ext, "_", layer_type,".tif"), format = "GTiff", dataType="INT2S", options="COMPRESS=LZW", overwrite=TRUE)
    } else {
      layer_type = "dsnr"
      print(paste0("Extraindo Layer : ", name_without_ext, "_", layer_type))
      writeRaster(ltgee_layer, paste0(name_without_ext, "_", layer_type,".tif"), format = "GTiff", dataType="INT2S", options="COMPRESS=LZW", overwrite=TRUE)
    }
  }
}




