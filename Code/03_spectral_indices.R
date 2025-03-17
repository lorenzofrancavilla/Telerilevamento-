
# code to calculate spectral images from satellite images

library(imageRy)
library(terra)
library(viridis)

im.list()

# https://www.usgs.gov/landsat-missions/landsat-5

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)

# 1 = NIR
# 2 = red
# 3 = green

im.plotRGB(mato1992, r=1, g=2, b=3) # verde è foresta
im.plotRGB(mato1992, r=2, g=1, b=3)
im.plotRGB(mato1992, r=2, g=3, b=1) # suolo nudo è giallo

# import 2006 image 

im.import("matogrosso_ast_2006209_lrg.jpg")

mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")

# mettere a confronto due immagini - si vede come la deforestazione è catastrofica

im.multiframe(1,2)
im.plotRGB(mato1992, r=2, g=3, b=1)
im.plotRGB(mato2006, r=2, g=3, b=1)

# plot a single band 
# immagini a 8 bit 

plot(mato1992[[1]], col=inferno(100))
plot(mato2006[[1]], col=inferno(100))

# DVI (difference vegetation index)

# tree: NIR=255 (massima riflettanza), red=0, DVI=NIR-red=255
# stressed tree: NIR=100, red=20, DVI = NIR-red = 100-20 = 80
#le cellule collassano  


#calculating DVI

im.multiframe(1,2)
plot(mato1992)
plot(mato2006)

# bands, for calculating DVI = NIR, red

# 1 = NIR
# 2 = red
# 3 = green

dvi1992 = mato1992[[1]] - mato1992[[2]]

# range DVI
# maximum: NIR - red = 255-0 =255
# minimum: NIR - red = 0 - 255 = -255

plot(dvi1992, col=magma(100))

# DVI 2006

dvi2006 = mato2006[[1]] - mato2006[[2]]


im.multiframe(1,2)
plot(dvi1992)
plot(dvi2006)

# immagini diverse, different radiometric resolutions (immagini con diversi bit)

# DVI 8 bit: range (0-255)

# NIR 
# maximum = 255
# minimum = -255

# DVI 4 bit (0-15) (for example image from the 90's)
# maximum: NIR - red = 15-0 =15
# minimum: NIR - red = 0 - 15 = -15

# NDVI - standardizzazione (qualsiasi risoluzione , qualsiasi bit il range con NDVI sarà da 1 a -1)

# NDVI 8 bit : range (0-155)
# max = (NIR-red)/(NIR+red)= (255-0)/(0+255)= 1
# min = (NIR-red)/(NIR+red)= (0-255)/(0+255)= -1

ndvi1992 = (mato1992[[1]] - mato1992[[2]]) / (mato1992[[1]] + mato1992[[2]])
plot(ndvi1992)

ndvi2006 = (mato2006[[1]] - mato2006[[2]]) / (mato2006[[1]] + mato2006[[2]])
plot(ndvi2006)



# function for imageRy (per evitare striscia di codice lunga) 

im.dvi # fa la differenza tra nir e red (1, 2) -- sono le due bande - NIR e red- la x è l'immagine

dvi1992auto = im.dvi(mato1992, 1, 2) 

im.ndvi # auto NDVI 

ndvi1992auto = im.ndvi(mato1992, 1, 2)
ndvi2006auto = im.ndvi(mato2006, 1, 2)
