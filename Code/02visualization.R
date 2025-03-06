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
#remeber  with "plot" you create/visualize the satelite image/graph
# RGB (red,green,blue) it is not good for colorblind

cl = colorRampPalette(c("orchid", "palegreen", "royalblue")) (100)
plot(b2, col=cl)

cl = colorRampPalette(c("orchid", "darkmagenta", "palegreen", "forestgreen", "royalblue")) (150)
plot(b2, col=cl)
