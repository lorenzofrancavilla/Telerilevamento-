# scaricato immagini da GEE
# ho usato Sentinel con bande (B2-blu, B3-green, B4-red, B8-NIR)
#scaricato da google earth engine due immagini che fanno la mediana
# la prima immagine corrisponde al periodo di tempo che va da luglio ad ottobre del 2018, la seconda da luglio ad ottobre del 2019

setwd("Desktop/Vaia")

#carico pacchetti
library(imageRy)
library(terra)
library(viridis)

#importo immagini e do nome (le immagini se plottate sono divise in tre bande(RGB) devo unirle)
vaia18 = rast("Vaia18Bande.tif")
vaia19 = rast("Vaia19Bande.tif")

# visualizzo  RGB per mettere insieme le bande e creare l'immagine satellitare 
plotRGB(vaia18, r = 1, g = 2, b = 3, stretch = "lin", main = "sentinel (median)")
plotRGB(vaia19, r = 1, g = 2, b = 3, stretch = "lin", main = "sentinel (median)")

# ora calcolo gli indici spettrali per singola immagine (ndvi) per vedere riflettanza bosco prima e dopo 

im.plotRGB(vaia18, r=4, g=2, b=3) # falso colore metto la banda NIR sul rosso per vedere la vegetazione nel 2018

im.plotRGB(vaia18, r=2, g=3, b=4) # il suolo nudo è giallo 

# visualizziamo con il 2019

im.plotRGB(vaia19, r=4, g=2, b=3)
im.plotRGB(vaia19, r=2, g=3, b=4) # in grigio e giallo si vedono le parti senza bosco 

#facciamo multiframe 

im.multiframe(1,2)
im.plotRGB(vaia18, r=2, g=3, b=4)
im.plotRGB(vaia19, r=2, g=3, b=4)

# ora calcolo l'ndvi del 2018 (B8-B1)/(B8+B1) (B8-NIR, B4-Red)

ndvi18 = (vaia18[[4]] - vaia18[[1]]) / (vaia18[[4]] + vaia18[[1]])
plot(ndvi18)

# calcoliamo ndvi 2019

ndvi19 = (vaia19[[4]] - vaia19[[1]]) / (vaia19[[4]] + vaia19[[1]])
plot(ndvi19)

# confrontiamo 

im.multiframe(1,2)
plot(ndvi18)
plot(ndvi19)

