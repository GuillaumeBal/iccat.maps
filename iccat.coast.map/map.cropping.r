rm(list = ls())

wd <- "C:/Users/gbal/Desktop/2017.stockbook/maps.areas/2.guillaume/iccat.coast.map"
setwd(wd)

#install.packages(c('rgdal', 'rgeos', 'raster'))

require(rgdal)
require(raster)
require(rgeos)
require(maptools)

#bluefin <- readOGR(paste0(wd,'/bluefin_tuna_2009_efh'), layer = "HMS_EFH_2009Bluefin_Tuna")
#coast <- readOGR(paste0(wd,'/i'), layer = 'GSHHS_i_L1')#, self intersection issue
coast <- readOGR(paste0(wd,'/l'), layer = 'GSHHS_l_L1')

# plot and look --------------------------------------------------
plot(coast)
points(0, 0, col = 'blue')
#locator()

# correct some self-intersection issue ---------------------------

# simplify the polgons a tad (tweak 0.00001 to your liking)
coast.simp <- gSimplify(coast, tol = 0.00001)

# this is a well known R / GEOS hack (usually combined with the above) to 
# deal with "bad" polygons
#coast.simp <- gBuffer(coast.simp, byid = TRUE, width = 0)

# crop and save ---------------------------------------------------------------------

iccat.coast <- crop(coast.simp, extent(-100, 45, -70, 75))

coast@bbox
iccat.coast@bbox

plot(iccat.coast, col = 'darkgreen')

iccat.coast.spdf <- as(iccat.coast, 'SpatialPolygonsDataFrame') # require spatial polygons object to be reformatted
writeOGR(iccat.coast.spdf, 
         dsn = "iccat.coast",
         layer = 'iccat.coast',
         driver = "ESRI Shapefile")