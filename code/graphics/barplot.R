library(terra)
library(data.table)
library(ggplot2)

v <- terra::vect("/dados/pessoal/eduardo/doutorado/results/loss_yod_eq1.gpkg")
v_t <- table(v@ptr@.xData$df$values())
vt_dt <- as.data.table(v_t)
names(vt_dt) <- c("ano", "count")
anos <- c("1986","1987","1988","1989","1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999",
          "2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010",
          "2011","2012","2013","2014","2015","2016","2017","2018")
barplot(vt_dt$count, names.arg = anos,
        xlab = "Year", ylab = "Number of Pixels", main = "Year of detection of all losses with duration equal to 1", border = "blue")
dev.off()

# barplot(vt_dt$count[vt_dt$ano > 1986], names.arg = anos,
#         xlab = "Year", ylab = "Count")
# dev.off()
