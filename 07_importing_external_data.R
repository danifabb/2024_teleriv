# how to import external data in R

library(terra)
#path to image
setwd("C:\Users\Utente\Downloads") #devi eliminare backslash e sostituirlo con slash semplice

eclissi <- rast("eclissi.png") #corrispondente di im.import in imageRy 
# unknown extent = non c'è georeferenziazione
eclissi # 3 bande (eclissi_1, eclissi_2, eclissi_3
#plot
plotRGB(eclissi, 1, 2, 3) # bande in ordine: immagine come l'abbiamo scaricata
plotRGB(eclissi, 2, 1, 3)

library(imageRy)

#different methods of plotting
par(mfrow=c(1,2))
plotRGB(eclissi, 2, 1, 3) # bande in ordine: immagine come l'abbiamo scaricata
im.plotRGB(eclissi, 2, 1, 3)

# differenza tra bande
dif = eclissi[[1]] - eclissi[[2]] # non ha nessun senso, è solo per vedere

# altro esercizio
postumia <- rast("download.jpeg") # importo un'immagine a caso
plotRGB(postumia, 1, 2, 3) #verde sul rosso
plotRGB(postumia, 3, 2, 1) #blu sul rosso

install.packages("ncdf4") # per immagini Copernicus (file CN)
library(ncdf4)

install.packages("RNetCDF")
library(RNetCDF)

#importing data
soil <- rast("c_gls_SSM1km_202404160000_CEURO_S1CSAR_V1.2.1.nc")
soil
plot(soil) # due immagini
plot(soil[[1]]) #solo prima immagine

# cropping image
ext <- c(25, 35, 58, 62) # longtudine e latitudine
soilcrop <- crop(soil, ext)
plot(soilcrop[[1]])

