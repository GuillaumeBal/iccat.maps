rm(list = ls())

wd <- "C:/Users/gbal/Desktop/2017.stockbook/maps.areas/2.guillaume/"
setwd(wd)

#install.packages(c('rgdal', 'rgeos', 'raster'))

require(rgdal)
require(raster)
require(rgeos)
require(maptools)

# global coast layer
coast <- readOGR(paste0(wd, 'iccat.coast.map/iccat.coast'), layer = 'iccat.coast')

# create eastern bluefin map 
source('1.bluefin.r')

#create north ablbacore map
source('2.albacore.r')