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

sd3 = focal(nira, w=c(3,3), fun=sd)

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


# come fare con immagini huge 
# resampling 

sent 

ncell(sent) * nlyr(sent) # numero di pixel per ogni livello (nlyr)- number of layers 

# la risoluzione in pixel originale è di 794 * 798
# 2534448

senta = aggregate(sent, fact=2) # la risoluzione passa da 1 a 1  a 2 a 2 (aumento di fattore) il pixel iniziale era 1/4 di quello di uscita. aumento grandezza pixel e diminuisco risoluzione 
ncell(senta) * nlyr(senta)

# ora la risoluzione dei pixel è di 397*399
# 633612

senta5 = aggregate(sent, fact=5)
ncell(senta5) * nlyr(senta5)
#  ora la risoluzione dei pixel è di 159*160
# 101760

# calculating standard deviation

nira = senta[[1]]
sd3a = focal(nira, w=c(3,3), fun="sd")

# make multiframe and plot rgb
im.multiframe (1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(senta, r=1, g=2, b=3)
im.plotRGB(senta5, r=1, g=2, b=3)

# calare di risoluzione è utile se devo agire su dati generali esempio : bordo foresta roccia , invece con piu risoluzione riesco ad avere piu dettagli come alberi ed elementi singoli 

# calculate standard deviation with senta5
nira5 = senta5[[1]]

sd3a5 = focal(nira, w=c(3,3), fun="sd")


# moving window with 5
sd5a5 = focal(nira, w=c(5,5), fun="sd")

im.multiframe(2,2)
plot(sd3,col=mako(100))
plot(sd3a,col=mako(100))
plot(sd3a5,col=mako(100))
plot(sd5a5,col=mako(100))

# plot with ggplot

p1 = im.ggplot(sd3)
p2 = im.ggplot(sd3a)
p3 = im.ggplot(sd3a5)
p4 = im.ggplot(sd5a5)
p1 + p2 + p3 + p4




# calcolo della varianza al posto della deviazione standard
# varianza = deviazione standard elevata al quadrato (popolazione e singoli)

# Variance
# nir

var3 = sd3^2
plot(var3)

im.multiframe(1, 2)
plot(sd3)
plot(var3)

sd5 = focal(nira, w=c(5,5), fun="sd")
var5 = sd5^2
plot(var5)
plot(sd5)
