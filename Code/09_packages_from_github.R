# R code for installing packages from github



library(devtools) # or remotes

# from GitHub, domanda esame --- se muoio rimane il mio pacchetto nel github nel CRAN sparisce se muoio 
install_github("ducciorocchini/cblindplot")
library(cblindplot)

install_github("clauswilke/colorblindr")
library(colorblindr)

# from CRAN 

install.packages("colorblindcheck")
library(colorblindcheck)
