library(terra)
library(data.table)

file_list <- list.files("~/Desktop/ma_estados_vector", pattern = "*.gpkg", full.names = TRUE)
v_base <- terra::vect("~/Desktop/gain_yod_albers.gpkg")

for (i in 1:length(file_list)) {
  message("Processing: ", file_list[[i]])
  v_state <- terra::vect(file_list[[i]])
  v_base_state <- terra::crop(v_base, v_state)
  v_state_name <- v_state$nome
  v_t <- table(v_base_state@ptr@.xData$df$values())
  vt_dt <- as.data.table(v_t)
  vt_dt$N <- vt_dt$N * 900
  names(vt_dt) <- c("ano", "count")
  anos <- c("1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996",
            "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007",
            "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018")
  png(paste0("~/Desktop/ma_estados_vector/", v_state_name, "_gain.png"), width = 862, height = 364)
  barplot(vt_dt$count, names.arg = anos,
          xlab = "Year", ylab = "Area in Square Meters",
          main = paste0(v_state_name, " - Year of detection of the gain"),
          border = "blue")

  dev.off()
  rm(v_state)
  rm(v_base_state)
  rm(v_t)
  rm(vt_dt)
  gc()
}