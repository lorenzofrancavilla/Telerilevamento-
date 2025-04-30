
# Code to solve colorblindness problems

## the Packages used in this script are

``` r
library(terra)
library(imageRy)
library(cblindplot)
```
setting the working directory, in this case desktop 

``` r
setwd("~/Desktop/")
```
## importing data 

``` r
vinicunca = rast("vinicunca.jpg")
plot(vinicunca)
vinicunca = flip(vinicunca)
plot(vinicunca)
```
## code to simulate colorblindess :

``` r
im.plotRGB(vinicunca, r=1, g=2, b=3, title= "standard vision")

im.plotRGB(vinicunca, r=2, g=1, b=3, title= "Pronatopia")
```

## Multiframe of the two images

```r
im.multiframe(2,1)
im.plotRGB(vinicunca, r=1, g=2, b=3, title= "standard vision")
im.plotRGB(vinicunca, r=2, g=1, b=3, title= "Pronatopia")
```

## solving colorblindess with cblindplot code

```r
rainbow = rast("rainbow.jpg")
plot(rainbow)
rainbow = flip(rainbow)
plot(rainbow) # people with daltonism find difficult to see the bottom image where yrllow and red

cblind.plot(rainbow, cvd="protanopia")


png("protanopia.png")
cblind.plot(rainbow, cvd="protanopia")
dev.off()
```
As an example a person affected with pronatopia can see this plot like this: 

![protanopia](https://github.com/user-attachments/assets/5546822c-b492-44da-9434-b92720961a75)

