# scaricato immagini da GEE

setwd("Desktop/Vaia")

#carico pacchetti
library(imageRy)
library(terra)
library(viridis)

#importo immagini e do nome 
pre18 = rast("prevaia2018.tif")
post18 = rast("postvaia2019.tif")

# visualize RGB (check the order of the bands)
plotRGB(pre18, r = 1, g = 2, b = 3, stretch = "lin", main = "sentinel (median)")
plotRGB(post18, r = 1, g = 2, b = 3, stretch = "lin", main = "sentinel (median)")


