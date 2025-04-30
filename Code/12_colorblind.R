# Code to solve colorblindness problems

# Packages
library(terra)
library(imageRy)
library(cblindplot)

#setting the working directory, in this case desktop 

setwd("~/Desktop/")

# import data 

vinicunca = rast("vinicunca.jpg")
plot(vinicunca)
vinicunca = flip(vinicunca)
plot(vinicunca)

im.plotRGB(vinicunca, r=1, g=2, b=3, title= "standard vision")

im.plotRGB(vinicunca, r=2, g=1, b=3, title= "Pronatopia")

im.multiframe(2,1)
im.plotRGB(vinicunca, r=1, g=2, b=3, title= "standard vision")
im.plotRGB(vinicunca, r=2, g=1, b=3, title= "Pronatopia")

# solving the daltonism problem with cblindplot

rainbow = rast("rainbow.jpg")
plot(rainbow)
rainbow = flip(rainbow)
plot(rainbow) # people with daltonism find difficult to see the bottom image where yrllow and red

# cvd = color visual deficency
cblind.plot(rainbow, cvd="protanopia")


