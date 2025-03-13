
# code to calculate spectral images from satellite images

library(imageRy) # beloved package developed at unibo
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
