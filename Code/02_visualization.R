# R CODE FOR VISUALIZING SATELLITE IMAGE 

# install.packages(devtools) library(devtools) install_github(

library(terra) 
library(imageRy)

# Listing data inside imageRy
im.list()

#from now we use "=" instead of <-

b2 = im.import("sentinel.dolomites.b2.tif")

# for deciding colors

cl = colorRampPalette(c("black", "dark grey", "light grey")) (100)
plot(b2, col=cl)

#exercise: make your own color ramp - search for R colors - https://sites.stat.columbia.edu/tzheng/files/Rcolor.pdf 

cl = colorRampPalette(c("orchid", "palegreen", "royalblue")) (100)
plot(b2, col=cl)
