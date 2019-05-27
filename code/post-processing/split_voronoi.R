etup -------------------------------------------------------------------
library(sf)

# Load Data ---------------------------------------------------------------
vor <- read_sf("./data/voronoi_mata_atlantica.shp")


# Main Loop ---------------------------------------------------------------
for(i in 1:nrow(vor)) 
{
  v_temp <- vor[i, ]
    write_sf(v_temp, paste0("./data/voronoi_splits/",
                       as.character(v_temp[['PATH']]), "_",
                       as.character(v_temp[['ROW']]), ".shp"))
}

