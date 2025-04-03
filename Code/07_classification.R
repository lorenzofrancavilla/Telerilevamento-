# R code for classifing images 

# install.packages("patchwork")

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)
plot(mato1992)

mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
plot(mato2006)

# how much forest do we have. create a cluster.i have created 2 clusters 

mato1992c = im.classify(mato1992, num_clusters=2)
# class1 = human
# class2 = forest

mato2006c = im.classify(mato2006, num_clusters=2)
# class1 = human
# class2 = forest

# frequency

f1992 = freq(mato1992c)

# calculate the percentage of 1992
tot1992 = ncell(mato1992c)
prop1992 = f1992 / tot1992 # ho la proporzione, divido i due , f1992 e tot1992
perc1992 = prop1992 * 100

# percentage 
# forest = 83%
# human = 16%

perc1992 = freq(mato1992c) * 100 / ncell(mato1992c)

# percentage of 2006
perc2006 = freq(mato2006c) * 100 / ncell(mato2006c)

# human = 55%
# forest = 45%

class = c("Forest","Human")
y1992 = c(83,16)
y2006 = c(45,55)
tabout = data.frame (class, y1992, y2006)
tabout

#creare grafico con ggplot, grafici per barre (istogrammi) ma con ggplot ci sono molti grafici
ggplot(tabout, aes(x=class, y=y1992, color=class)) +
geom_bar(stat="identity", fill="white")

ggplot(tabout, aes(x=class, y=y2006, color=class)) +
geom_bar(stat="identity", fill="white")

# metto i grafici uno di fianco all'altro

p1 = ggplot(tabout, aes(x=class, y=y1992, color=class)) +
geom_bar(stat="identity", fill="white") +
ylim(c(0,100)) +
coord_flip()

p2 = ggplot(tabout, aes(x=class, y=y2006, color=class)) +
geom_bar(stat="identity", fill="white") +
ylim(c(0,100)) +
coord_flip()

p1 + p2

p1 / p2

# solar orbiter--- satellite that observes the sun 

solar = im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# classify the image in 3 classes with im.classify

solarc = im.classify(solar, num_clusters=3)

# plot original image beside classified image 

im.multiframe(1, 2)
plot(solar)
plot(solarc)

# 3 = low
# 1 = medium
# 2 = high

subst # function for sostituire i quadratini della classificazione)

solarcs = subst(solarc, c(3, 1, 2), c("c1_low","c2_medium","c3_high"))
plot(solarcs)

# exercise calculate the percentages of the Sun energy classes with one line of code 

percsolarcs = freq(solarcs)$count * 100 / ncell(solarcs)

# percentage = 38, 41, 21

class = c("c1_low", "c2_high", "c3_high)
perc = c(38, 41, 21)
tabsol = data.frame(class, perc)

ggplot(tabsol, aes(x=class, y=perc, color=class)) +
geom_bar(stat="identity", fill="white")
