# R code for classifing images 

library(terra)
library(imageRy)

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
