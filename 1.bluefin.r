par(oma = c(2, .25, .25, .25))
par(mar = c(.05, .05, .05, .05))
plot(coast)

# bluefin easter area base line to be completead with locator -------------------------------

east.bluefin.base.points <- cbind(x <- c(25, -45 , -45, -35, -35, -30, -30, -25, -25, 20, 20),
                                  y <- c(70, 70, 10, 10, 5, 5, 0, 0, -60, -60, -30))
east.bluefin.base.line <- Line(east.bluefin.base.points)
east.bluefin.base.line <- Lines(list(east.bluefin.base.line), 1)
east.bluefin.base.line <- SpatialLines(list(east.bluefin.base.line))
plot(east.bluefin.base.line , add = TRUE, col = 'red')

# get points from map to complete polygone ---------------------------------------------------

east.bluefin.end.points <- locator(type = 'l')
east.bluefin.end.points <- do.call(what = cbind, east.bluefin.end.points)

east.bluefin.polygon <- Polygon(rbind(east.bluefin.base.points, east.bluefin.end.points))
east.bluefin.polygon <- Polygons(list(east.bluefin.polygon), 1)
east.bluefin.polygon <- SpatialPolygons(list(east.bluefin.polygon))

# blue final map -----------------------------------------------------------------------

bluefin.map.extent <- c(max(east.bluefin.polygon@bbox['x', 'min'] - 5, coast@bbox['x', 'min']),
                        min(east.bluefin.polygon@bbox['x', 'max'] + 5, coast@bbox['x', 'max']),
                        max(east.bluefin.polygon@bbox['y', 'min'] - 5, coast@bbox['y', 'min']),
                        min(east.bluefin.polygon@bbox['y', 'max'] + 5, coast@bbox['y', 'max']))

pdf('bluefin.map.pdf')

plot.new()

plot.window(xlim =  bluefin.map.extent[1:2], ylim =  bluefin.map.extent[3:4], asp = 1)

plot(east.bluefin.polygon, add = TRUE,
     col = 'lightpink',
     border = 'red', lwd = 1.5)

x.lines <- seq(bluefin.map.extent[1], bluefin.map.extent[2], 5)
y.lines <- seq(bluefin.map.extent[3], bluefin.map.extent[4], 5)

for(a in 1:length(x.lines)) lines(rep(x.lines[a], 2), c(bluefin.map.extent[3], bluefin.map.extent[4]), col = 'grey')
for(a in 1:length(y.lines)) lines(c(bluefin.map.extent[1], bluefin.map.extent[2]), rep(y.lines[a], 2), col = 'grey')

#abline(v = , col = 'grey')
#abline(h = , col = 'grey')

plot(east.bluefin.polygon, add = TRUE,
     col = 'blue',
     density = 15, lwd = 1.5,
     border = 'red')

bluefin.coast <- crop(coast, extent(bluefin.map.extent))

plot(bluefin.coast, add = TRUE,
     col = 'darkgreen',
     border = 'darkgreen')

rect(xleft = bluefin.map.extent[1],
     xright = bluefin.map.extent[2],
     ybottom = bluefin.map.extent[3],
     ytop = bluefin.map.extent[4])

par(xpd = TRUE)

legend(x = (par("usr")[1] + par("usr")[2]) / 2, 
       y = par("usr")[3] + 8,
       xjust = .5,
       legend = c('Management area', 'Assessment area'),
       fill = c('lightpink', 'blue'),
       density = c(NA, 15), # density make fill lines, if color + lines need to superpose legends
       border = c('red', 'blue'),
       bty = 'n', 
       cex = 1.2)

dev.off()