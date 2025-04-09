# spacial variability in R


library(terra)
library(imageRy)
library(viridis)
library(patchwork)

install.packages("RStoolbox")
library(RStoolbox)

# teoria

# standard deviation 
# 24 26 25 (età)

# https://www.andreaminini.org/statistica/scarto-quadratico-medio 

media = (24+26+25) / 3
media

# scarti quadratici
num = (24-media)^2 + (26-media)^2 + (25-media)^2
num
den = 3

varianza = num/den

# standard deviation 
stdev = sqrt(varianza)
stdev  #  stdev = 0.8164966

#oppure

sd(c(24,26,25)) # sd = 1

# aggiungo età prof

sd(c(24,26,25,49)) # sd =  12.02775 (piu altro la curva si stretcha)

# misurare deviazione standard 


#----

im.list()

sent = im.import("sentinel.png")
sent = flip(sent)
# band 1 = NIR
# band 2 = red
# band 3 = green

# plot image in rgb with the NIR band on top the red component 

im.plotRGB(sent, r=1, g=2, b=3)

# ceate 3 plots with nir ontop of each component 

im.multiframe(1, 3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=3, g=2, b=1)

# select nir 

nir = sent[[1]]

# make a plot the nir inferno color ramp palette 

plot(nir, col=inferno(100))

# focal, Calculate focal ("moving window") values for each cell. (moving window, vedi paper prof)

?focal

sd3 = focal(nir, w=c(3,3), fun=sd)

# si vedono le zone dove ci sono state variazioni nell'infrarosso vicino 

im.multiframe(1,2)
im.plotRGB(sent, r=1, g=2, b=3)
plot(sd3)

sd5 = focal(nir, w=c(5,5), fun=sd)
plot(sd5)

#variabilità maggiore con 5 pixel

im.multiframe(1,2)
plot(sd3)
plot(sd5)

# ggplot 
im.ggplot(sd3)

# Exercise: plot the two sd maps (3 and 5) one beside the other with ggplot
p1 = im.ggplot(sd3)
p2 = im.ggplot(sd5)
p1 + p2

# plot the original nir and the stdev

p3 = im.ggplot(nir)
p1 = im.ggplot(sd3)
p3 + p1
