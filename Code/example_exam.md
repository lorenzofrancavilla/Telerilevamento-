# Titolo presentazione

## Data Gathering

Dati raccolti dal sito [Earth Observatory Site](https://earthobservatory.nasa.gov/images/154225/wildfire-maps-help-firefighters-in-real-time)

``` r
library(terra)
library(imageRy)
library(viridis)

```

setting the working directory and importing the data:

``` r
setwd("~/Desktop/")

fire = rast("fire.jpg")
plot(fire)
fire = flip(fire)
plot(fires)

```

l'immagine: 

![fire](https://github.com/user-attachments/assets/e1b0796d-6117-43bd-bceb-cb2e89f13388)


## Data analysis

Based on the data gathered from the site we can calculate an index, using the first two bands:

``` r
fireindex = fire[[1]] - fire[[2]]
plot(fireindex)
```
In order to export the index, we can use the png() function like:

``` r
png("fireindex.png")
plot(fireindex)
dev.off()
```

The index looks like:

![fireindex](https://github.com/user-attachments/assets/ee903406-041c-4580-acde-928cbbfd67a9)


## Index visualisation by viridis

In order to visualize the index with another viridis palette we made use of the following code:

``` r
plot(fireindex, col=inferno(100))
```

viridis image: 

![fireindex](https://github.com/user-attachments/assets/227aca6d-d1b7-4d0d-a0dc-002c8b40233c)
