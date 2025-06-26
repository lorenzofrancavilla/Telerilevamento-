# scaricato immagini da GEE
# ho usato Sentinel con bande (B2-blu, B3-green, B4-red, B8-NIR)
#scaricato da google earth engine due immagini che fanno la mediana
# Le immagini scaricate dal satellite Sentinel 2 hanno una risoluzione di 10m per pixel.
# la prima immagine corrisponde al periodo di tempo che va da luglio ad ottobre del 2018, la seconda da luglio ad ottobre del 2019 e l'ultima scaricata corrisponde allo stesso periodo nel 2025 
# setto la working directory sulla cartella con le immagini 
setwd("Desktop/Vaia")

# per esportare immagini 

png("mappa_rgb_hd.png", width = 3000, height = 3000, res = 300) # modifico la risoluzione larghezza e altezza per avere file non troppo pesanti e che si vedano bene
plotRGB(img, r=4, g=3, b=2, stretch="lin")  # o il tuo raster RGB
dev.off()

png("Vaia18false.png", width = 2000, height = 2000, res = 150)
im.plotRGB(vaia18, r=4, g=2, b=3) 
dev.off()

png("Vaia19false.png", width = 2000, height = 2000, res = 150) 
im.plotRGB(vaia19, r=4, g=2, b=3) 
dev.off()


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

#facciamo multiframe con falsi colori, dal multiframe si nota nel confronto tra le due immagini con falsi colori un aumento di sezioni di bosco di colore grigio, le guali indicano un area di vegetazione morta/ danneggiata dopo il 2018



im.multiframe(1,2)
im.plotRGB(vaia18, r=2, g=3, b=4)
im.plotRGB(vaia19, r=2, g=3, b=4)

im.multiframe(1,2)
im.plotRGB(vaia18, r=4, g=2, b=3)
im.plotRGB(vaia19, r=4, g=2, b=3)

# ora calcolo l'ndvi del 2018 (B8-B1)/(B8+B1) (B8-NIR, B4-Red).

# L'Ndvi è L’NDVI (Normalized Difference Vegetation Index) è un indice spettrale usato 
# in telerilevamento per misurare la salute e densità della vegetazione. 
# Viene calcolato usando le bande NIR (infrarosso vicino) e Red (rosso) di immagini satellitari (come quelle del Sentinel-2).

# inserisco formula in .md
# NIR (Near Infrared): Banda sensibile alla riflettanza della vegetazione sana.
# Red: Banda in cui la vegetazione assorbe luce per la fotosintesi.

# valori dell'NDVI          
# < 0        Acqua, neve                          
# 0 - 0.1    Suolo nudo, roccia, aree urbanizzate 
# 0.2 - 0.5  Vegetazione scarsa o stressata       
# > 0.5     |Vegetazione densa e sana             


# ndvi 2018
# per calcolare l'ndvi faccio la differenza tra banda NIR[4] e banda red[1] fratto la somma 

ndvi18 = (vaia18[[4]] - vaia18[[1]]) / (vaia18[[4]] + vaia18[[1]])
plot(ndvi18)

# si puo vedere nel plot che i valori superiori a 5 si identificano con colori accessi verso verde e giallo indivando la vegetazione sana 

# calcoliamo ndvi 2019

ndvi19 = (vaia19[[4]] - vaia19[[1]]) / (vaia19[[4]] + vaia19[[1]])
plot(ndvi19)

# invece nel 2019 appaiono macchie blu che cospargono i boschiu in seguito all'incendio(nella parte di bosco rivolta verso sud delle pale di san lucano) e alla tempesta vaia in tutta l'area interessata 

# confrontiamo 

im.multiframe(1,2)
plot(ndvi18)
plot(ndvi19)


# plottiamo con la palette di viridis
im.multiframe(1,2)
plot(ndvi18, col=inferno(100))
plot(ndvi19, col=inferno(100))

# classificazione in 2 parti tra bosco e roccia/urbanizzazione/suolo nudo con la funzione im.classify mettendo due categorie di classificazione

bosco18c = im.classify(ndvi18, num_clusters = 2)

bosco19c = im.classify(ndvi19, num_clusters = 2)
# codice per invertire le classi di bosco19c, per risolvere problema inversione colori grafico 
bosco19c = classify(bosco19c, rcl = matrix(c(1, 2, 2, 1), ncol = 2, byrow = TRUE))

#multiframe con nomi  senno si invertono

im.multiframe(1,2)
plot(bosco18c)
plot(bosco19c)

# 1 = bosco
# 2 = roccia, suolo nudo, umano

# risulta che nel 2019 la quantità di vegetazione 

# ora che abbiamo la classificazione in due classi sulle due immagini possiamo calcolare i pixel di entrambe le immagini e ricavare la percentuale di bosco e di area urbanizzata/suolo nudo. 
# risulterà 

# calcolo percentuale bosco nel 2018, 2019 

# calcolo i pixel nell'immagine 2018, 2019 e la percentuale bosco 18 e 19 
# Questa funzione fornisce un data frame con colonne value (1 o 2) e count (numero di pixel)
f18 = freq(bosco18c)  # classi e conteggi per il 2018
f19 = freq(bosco19c)  # classi e conteggi per il 2019



# Totale pixel validi, calcolo il totale dei pixel validi all'interno della calssificazione
tot18 = ncell(bosco18c) 
tot19 = ncell(bosco19c)

# calcolo la percentuale con 
perc18 = freq(bosco18c)$count * 100 / ncell(bosco18c)
perc19 = freq(bosco19c)$count * 100 / ncell(bosco19c)

# le due percentuali rappresentanole aree urbanizzate+bosco perso , prendo solo la percentuale bosco 

#83,94 nel 2018
#79,92 nel 2019

# ora faccio la differenza delle percentuali e vedo la percentuale di bosco perso 

boscoperso= perc18-perc19
# = 4,03%

# considerando che la tempesta è avvenuta in un'unica notte e in concomitanza ad un incendio boschivo, la percentuale di bosco perso è significativa (4%)

# calcolo pixel persi da 2018 a 2018

# adesso faccio ggplot

class = c("Percentuale boschi agordino") # stabilisco cosa voglio indicare
y2018 = c(84) # indico anno e percentuale di bosco 
y2019 = c(80)
perdite = y2018 - y2019 
tabout = data.frame(class, y2018, y2019, perdite )

p1 = ggplot(tabout, aes(x=class, y=y2018, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))

p2 = ggplot(tabout, aes(x=class, y=y2019, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))

p3 = ggplot(tabout, aes(x=class, y=perdite, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))



p0 = im.ggplot(ndvi18)
p00 = im.ggplot(ndvi19)
  
(p1 + p2 + p3)/(p0 + p00)

# differenza NDVI
diff_ndvi = ndvi18 - ndvi19

#  si sottrae  il valore di NDVI prima (2018) dal valore dopo (2019).
#  evidenziando le variazioni nella vegetazione in giallo

# plotto differenza ndvi e vedo qual'è la soglia di perdita del bosco in questo caso -0.3/-0.5


# plot differenza NDVI
plot(diff_ndvi, main = "Differenza NDVI 2019 - 2018", col = viridis(100))

# evidenzia solo le aree di perdita significativa in rosso su mappa trasparente 
plot(diff_ndvi, col = c("transparent", "red"))

im.multiframe(1,3)
plot(ndvi18, main = "NDVI 2018", col = viridis(100))
plot(ndvi19, main = "NDVI 2019", col = viridis(100))
plot(diff_ndvi, main = "bosco perso", col = c("transparent", "red"))


# vaia 24
vaia24=rast("Vaia24.tif")
plot(vaia24)

plotRGB(vaia24, r = 1, g = 2, b = 3, stretch = "lin", main = "sentinel (median)")

ndvi24 = (vaia24[[4]] - vaia24[[1]]) / (vaia24[[4]] + vaia24[[1]])
plot(ndvi24)

im.multiframe(1,3)
plot(ndvi18)
plot(ndvi19)
plot(ndvi24)


