# this code helps exporting graphs from R

# export data

#----- setto cartella di lavoro 
# /Users/lorenzofrancavilla/Desktop/telerilevamento in R
setwd("Desktop/telerilevamento in R/IMMAGINI R/")

# getwd (per vedere dove sono)

pdf("output.pdf")
plot(grdif)
dev.off()

jpeg("output.jpeg")
plot(grdif)
dev.off()




