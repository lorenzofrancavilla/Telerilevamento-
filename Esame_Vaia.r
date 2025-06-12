# scaricato immagini da GEE
# ho usato Sentinel con bande (B2-blu, B3-green, B4-red, B8-NIR)
#scaricato da google earth engine due immagini che fanno la mediana
# la prima immagine corrisponde al periodo di tempo che va da luglio ad ottobre del 2018, la seconda da luglio ad ottobre del 2019

setwd("Desktop/Vaia")

#carico pacchetti
library(imageRy)
library(terra)
library(viridis)
library(ggplot2)
library(patchwork)


#importo immagini e do nome (le immagini se plottate sono divise in tre bande(RGB) devo unirle)
vaia18 = rast("Vaia18Bande.tif")
vaia19 = rast("Vaia19Bande.tif")

# visualizzo  RGB per mettere insieme le bande e creare l'immagine satellitare 
plotRGB(vaia18, r = 1, g = 2, b = 3, stretch = "lin", main = "sentinel (median)")
plotRGB(vaia19, r = 1, g = 2, b = 3, stretch = "lin", main = "sentinel (median)")

# ora calcolo gli indici spettrali per singola immagine (ndvi) per vedere riflettanza bosco prima e dopo 

im.plotRGB(vaia18, r=4, g=2, b=3) # falso colore metto la banda NIR sul rosso per vedere la vegetazione nel 2018

im.plotRGB(vaia18, r=2, g=3, b=4) # il suolo nudo è giallo 

# visualizziamo con il 2019

im.plotRGB(vaia19, r=4, g=2, b=3)
im.plotRGB(vaia19, r=2, g=3, b=4) # in grigio e giallo si vedono le parti senza bosco 

#facciamo multiframe con falsi colori


im.multiframe(1,2)
im.plotRGB(vaia18, r=2, g=3, b=4)
im.plotRGB(vaia19, r=2, g=3, b=4)

im.multiframe(1,2)
im.plotRGB(vaia18, r=4, g=2, b=3)
im.plotRGB(vaia19, r=4, g=2, b=3)

# ora calcolo l'ndvi del 2018 (B8-B1)/(B8+B1) (B8-NIR, B4-Red)

ndvi18 = (vaia18[[4]] - vaia18[[1]]) / (vaia18[[4]] + vaia18[[1]])
plot(ndvi18)

# calcoliamo ndvi 2019

ndvi19 = (vaia19[[4]] - vaia19[[1]]) / (vaia19[[4]] + vaia19[[1]])
plot(ndvi19)

# confrontiamo 

im.multiframe(1,2)
plot(ndvi18)
plot(ndvi19)



im.multiframe(1,2)
plot(ndvi18, col=inferno(100))
plot(ndvi19, col=inferno(100))

# classificazione in 2 parti tra bosco e montagna/urbanizzazione 

bosco18c = im.classify(ndvi18, num_clusters = 2)

bosco19c = im.classify(ndvi19, num_clusters = 2)
# codice per invertire le classi di bosco19c, per risolvere problema inversione colori grafico 
bosco19c = classify(bosco19c, rcl = matrix(c(1, 2, 2, 1), ncol = 2, byrow = TRUE))

#multiframe con colori specifici senno si invertono

im.multiframe(1,2)
plot(bosco18c)
plot(bosco19c)



# calcolo percentuale bosco nel 2018 

# calcolo i pixel nell'immagine 2018 e la percentuale bosco 18 e 19 
# Questa funzione fornisce un data frame con colonne value (1 o 2) e count (numero di pixel)
f18 <- freq(bosco18c)  # classi e conteggi per il 2018
f19 <- freq(bosco19c)  # classi e conteggi per il 2019



# Totale pixel validi, calcolo il totale dei pixel validi all'interno della calssificazione
tot18 = ncell(bosco18c) 
tot19 = ncell(bosco18c)

# calcolo la percentuale con 
perc18 = freq(bosco18c)$count * 100 / ncell(bosco18c)
perc19 = freq(bosco19c)$count * 100 / ncell(bosco19c)

# le due percentuali rappresentanole aree urbanizzate+bosco perso , prendo solo la percentuale bosco 

#83,94 nel 2018
#79,92 nel 2019

# ora faccio la differenza delle percentuali e vedo la percentuale di bosco perso 

boscoperso= perc18-perc19
# = 4,03%

# adesso faccio ggplot

class = c("Percentuale boschi agordino")
y2018 = c(84)
y2019 = c(80)
tabout = data.frame(class, y2018, y2019)

p1 = ggplot(tabout, aes(x=class, y=y2018, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))

p2 = ggplot(tabout, aes(x=class, y=y2019, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))


p0 = im.ggplot(ndvi18)
p00 = im.ggplot(ndvi19)
  
p0 + p00 + p1 + p2







