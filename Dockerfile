FROM rocker/rstudio

LABEL maintainer="Eduardo Ribeiro Lacerda"

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y build-essential git htop vim tmux libssl-dev\
 						libudunits2-dev libgdal-dev gdal-bin

RUN R -e "install.packages(c('raster', 'sf', 'terra'))"