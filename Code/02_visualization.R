# R CODE FOR VISUALIZING SATELLITE IMAGE 


# install.packages ("imageRy")
# install.packages ("terra")
# install.packages("devtools") 
# install.packages("viridis")

library(devtools) 
library(terra) 
library(imageRy)
library(viridis)

# Listing data inside imageRy
im.list()

# from now we use "=" instead of <-

# import band from the list.  "band" (b1, b2, b3...) spectrum of colours
# https://gisgeography.com/sentinel-2-bands-combinations/

b2 = im.import("sentinel.dolomites.b2.tif")

# for deciding colors , il 100 sono le gradazioni

cl = colorRampPalette(c("black", "dark grey", "light grey")) (100)
plot(b2, col=cl)

# exercise: make your own color ramp - search for R colors (https://sites.stat.columbia.edu/tzheng/files/Rcolor.pdf)  
# remeber  with "plot" you create/visualize the satelite image/graph
# RGB (red,green,blue) it is not good for colorblind

cl = colorRampPalette(c("orchid", "palegreen", "royalblue")) (100)
plot(b2, col=cl)

# band 3 


b3 = im.import("sentinel.dolomites.b3.tif")
b4 = im.import("sentinel.dolomites.b4.tif")
b8 = im.import("sentinel.dolomites.b8.tif")

# band 8 (band near infrared - infrarosso vicino al visibile )

# how to import multiple bands- multiframe (mfrow) 


par(mfrow=c(1,4))
plot(b2)
plot(b3)
plot(b4)
plot(b8)

dev.off() #per problemi grafici faccio questo 

# multiframe facilita il processo tra parentesi (righe, colonne)

im.multiframe(1,4)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# exercise: plot the bands using im.multiframe() one on top of the other invece di 4,1 (4righe una colonna, metto 1 riga 4colonne)

im.multiframe(4,1)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# nuova palette con nero e grigio e ci sono 100 gradazioni!

cl = colorRampPalette(c("black","light grey"))(100)
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# buildinga stack -- for creating a satellite image - 

sent = c(b2, b3, b4, b8)
plot(sent, col=cl) #build the image

# how to change name in the plot
names(sent) = c("b2-blue", "b3-green", "b4-red", "b8-NIR")
plot(sent, col=cl)
plot(sent)

# come si estrae una banda singola dal plot
# prendo il quarto elemento di sent e lo metto tra le due [[]] parentesi quadre 

plot(sent [[4]])  

# importing several bands altoghether to simplify

sentdol = im.import("sentinel.dolomites")

# import several sets Correlazione fra bande Quanto sono correlate fra loro le bande  


pairs(sentdol)

# colorblind friendly maps (pacchetto vridis) how to install viridis (see on top) i pacchetti vanno tutti all'inizio 

# viridis colours : (https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html)

# test viridis 
plot(sentdol, col=viridis(100))
plot(sentdol, col=mako(100))

#layers 
# 1 = blue (b2)
# 2 = green (b3)
# 3 = red (b4)
# 4 = NIR (near infrared) (b8)

# rgb - red green blue , sovrapposte creano tutti i colori possibili. with rgb we create the satellite image 

# natural colours , colori che vede l'occhio umano 
#R= colore corrispondente alla banda , G= banda verde, B= banda verde

im.plotRGB(sentdol, r=3, g=2, b=1)

#con questa linea di rgb vedo poco, l'occhio umano non riconosce lo spettro 

# usiamo l'infrarosso vicino, immagine a falsi colori - false colours , i sacrifice the blue color , scalo di uno i colori RGB

# in the red band we have put the NIR, NIR- le piante riflettono moltissimo - le piante verranno fuori di colore rosso 

# NIR band 832 nanometers (human vision 600 nm)

im.plotRGB(sentdol, r=4, g=3, b=2)

# exercise plot image using the NIR on top of green component of the RGB scheme

# put the 4 on the green scheme - riflettanza in infrarosso 

im.plotRGB(sentdol, r=3, g=4, b=2)

im.multiframe(1, 2)
im.plotRGB(sentdol, r=4, g=2, b=2)
im.plotRGB(sentdol, r=3, g=4, b=2)

im.plotRGB(sentdol, r=3, g=2, b=4)
