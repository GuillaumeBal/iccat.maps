par(oma = c(2, .25, .25, .25))
par(mar = c(.05, .05, .05, .05))
plot(coast)

# albacore easter area base line to be completead with locator -------------------------------

north.albacore.base.points.n <- cbind(x <- c(20, -93),
                                  y <- c(70, 70))
north.albacore.base.line.n <- Line(north.albacore.base.points.n)
north.albacore.base.line.n <- Lines(list(north.albacore.base.line.n), 1)
north.albacore.base.line.n <- SpatialLines(list(north.albacore.base.line.n))
plot(north.albacore.base.line.n , add = TRUE, col = 'red')

north.albacore.base.points.s <- cbind(x <- c(-60, -8),
                                     y <- c(5, 5))
north.albacore.base.line.s <- Line(north.albacore.base.points.s)
north.albacore.base.line.s <- Lines(list(north.albacore.base.line.s), 1)
north.albacore.base.line.s <- SpatialLines(list(north.albacore.base.line.s))
plot(north.albacore.base.line.s , add = TRUE, col = 'red')

# get points from map to complete polygone ---------------------------------------------------

north.albacore.end.points.w <- locator(type = 'l')
north.albacore.end.points.w <- do.call(what = cbind, north.albacore.end.points.w)

north.albacore.end.points.e <- locator(type = 'l')
north.albacore.end.points.e <- do.call(what = cbind, north.albacore.end.points.e)

north.albacore.polygon <- Polygon(rbind(north.albacore.base.points.n, 
                                        north.albacore.end.points.w,
                                        north.albacore.base.points.s,
                                        north.albacore.end.points.e
                                        ))

north.albacore.polygon <- Polygons(list(north.albacore.polygon), 1)
north.albacore.polygon <- SpatialPolygons(list(north.albacore.polygon))

# blue final map -----------------------------------------------------------------------

albacore.map.extent <- c(max(north.albacore.polygon@bbox['x', 'min'] - 5, coast@bbox['x', 'min']),
                        min(north.albacore.polygon@bbox['x', 'max'] + 5, coast@bbox['x', 'max']),
                        max(north.albacore.polygon@bbox['y', 'min'] - 5, coast@bbox['y', 'min']),
                        min(north.albacore.polygon@bbox['y', 'max'] + 5, coast@bbox['y', 'max']))

pdf('albacore.map.pdf')

plot.new()

plot.window(xlim =  albacore.map.extent[1:2], ylim =  albacore.map.extent[3:4], asp = 1)

plot(north.albacore.polygon, add = TRUE,
     col = 'lightpink',
     border = 'red', lwd = 1.5)

x.lines <- seq(albacore.map.extent[1], albacore.map.extent[2], 5)
y.lines <- seq(albacore.map.extent[3], albacore.map.extent[4], 5)

for(a in 1:length(x.lines)) lines(rep(x.lines[a], 2), c(albacore.map.extent[3], albacore.map.extent[4]), col = 'grey')
for(a in 1:length(y.lines)) lines(c(albacore.map.extent[1], albacore.map.extent[2]), rep(y.lines[a], 2), col = 'grey')

#abline(v = , col = 'grey')
#abline(h = , col = 'grey')

plot(north.albacore.polygon, add = TRUE,
     col = 'blue',
     density = 15, lwd = 1.5,
     border = 'red')

albacore.coast <- crop(coast, extent(albacore.map.extent))

plot(albacore.coast, add = TRUE,
     col = 'darkgreen',
     border = 'darkgreen')

rect(xleft = albacore.map.extent[1],
     xright = albacore.map.extent[2],
     ybottom = albacore.map.extent[3],
     ytop = albacore.map.extent[4])

par(xpd = TRUE)

legend(x = (par("usr")[1] + par("usr")[2]) / 2, 
       y = par("usr")[3] + 30,
       xjust = .5,
       legend = c('Management area', 'Assessment area'),
       fill = c('lightpink', 'blue'),
       density = c(NA, 15), # density make fill lines, if color + lines need to superpose legends
       border = c('red', 'blue'),
       bty = 'n',
       cex = 1.2)

dev.off()