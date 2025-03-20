# R code for performing multitemporal analysis


install.packages("ggridges") #needed to create ridgeline plots
library(imageRy)
library(terra)
library(viridis)

im.list()

# file EN (azoto dioxide in EU) (https://www.copernicus.eu/en/media/image-day-gallery/no2-concentration-northern-italy)

EN_01 = im.import("EN_01.png")
EN_01 = flip(EN_01)
plot(EN_01) # january

EN_13 = im.import("EN_13.png")
EN_13 = flip(EN_13)
plot(EN_13) # march

im.multiframe(1,2)
plot(EN_01)
plot(EN_13)

ENdif = EN_01[[1]] - EN_13[[1]]
plot(ENdif)

plot(ENdif, col=inferno(100))

# Greenland ice melt 

gr = im.import("greenland")

# differenza fra immagini 

grdif = gr[[1]] - gr[[4]] # 2000 - 2015
grdif = gr[[4]] - gr[[1]] # 2015 - 2000
plot(grdif)

# le temperature piu basse aumentano

#install ggridges
# ridgeline plot - (https://en.wikipedia.org/wiki/Ridgeline_plot)
# distribuzione delle frequenze nel tempo 
# sfondo grigio è ggplot


# ridgeline plots 

im.ridgeline(gr, scale=1)
im.ridgeline(gr, scale=2)
im.ridgeline(gr, scale=2, palette="plasma")
im.ridgeline(gr, scale=3, palette="plasma")

# importing ndvi sentinel images

sent = im.import("Sentinel2")

im.ridgeline(sent, scale=2)

# changing names
# sources :     Sentinel2_NDVI_2020-02-21.tif  
              # Sentinel2_NDVI_2020-05-21.tif  
              # Sentinel2_NDVI_2020-08-01.tif  
              # Sentinel2_NDVI_2020-11-27.tif 

names(sent) = c("02_Feb", "05_May", "08_Aug", "11_Nov")

im.ridgeline(sent, scale=2, palette="mako")

pairs(sent)

plot(sent[[1]], sent[[2]])
# y = x May=y, Feb=x 
# y = a + bx (intercetta = dove linea tocca asse y)
# a=0, b=1
#  y = a + bx = 0 + 1x = x 

abline(0, 1, col="red") # come vengono distribuiti i dati 

plot(sent[[1]], sent[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3,0.9))
abline(0, 1, col="red")

im.multiframe(1,3)
plot(sent[[1]])
plot(sent[[2]])
plot(sent[[1]], sent[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3,0.9))
abline(0, 1, col="red") 
