# R code for performing multitemporal analysis



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

