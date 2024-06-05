# Range di valori di riflettanza da 0 a 100. Se ho una pianta, essa avrà 90 di riflettanza in NIR e 10 di riflettanza in rosso. 90 - 10
# Albero che sta morendo? Faccio lo stesso calcolo MA mesofillo fogliare è collassato, cellule morenti e ammassate l’una sull’altra
# NIR non viene più riflesso in quel modo: è riflesso debolmente perché la struttura della pianta è cambiata. Riflettanza nel NIR diventa 60.
# Invece la riflettanza nel rosso aumenta, perché l’assorbimento è meno efficiente es. 30. Fotosintesi non è operata a dovere. DVI = 60 – 30 = 30.
# ->	Calcolo della biomassa presente in certa area grazie all'indice. 
# Firma spettrale = impronta digitale della luce nelle varie lungh d’onda. 


library(terra)
library(imageRy)
im.list()
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# Landsat image:
# band 1 = NIR
# band 2 = red
# band 3 = green

# plotting the data
im.plotRGB(m1992, r=1, g=2, b=3) # tutto ciò che era infrarosso diventa rosso, infatti rosso = banda 1, che è il NIR (vedi sopra)
# NIR è riflesso dalla vegetazione!
im.plotRGB(m1992, r=2, g=1, b=3) # NIR su verde (g=1), tutto ciò che era infrarosso diventa verde, quindi vedo la foresta verde. Si vede bene dove l'uomo ha avuto impatto, in particolare i campi
# tuttavia, la maggior parte della foresta era intatta nel 1992
im.plotRGB(m1992, r=2, g=3, b=1) # NIR su blu (b=1), quindi vedo la foresta blu e la componente del suolo diventa gialla quindi si vede meglio
# firma spettrale dell'acqua: acqua assorbe infrarosso; è nera (qui in realtà no, perché ci sono detriti quindi è come il suolo nudo

# stessa cosa ma con immagine del 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

# NIR su green
im.plotRGB(m2006, r=2, g=1, b=3)

im.plotRGB(m2006, 2, 3, 1)

par(mfrow=c(2, 3))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=1, g=2, b=3)
im.plotRGB(m2006, r=2, g=1, b=3)
im.plotRGB(m2006, 2, 3, 1)

# risoluzione spaziale = dimensione di pixel
# Risoluzione radiometrica: quanti valori stiamo usando (8 bit, 16 bit, ecc)
# 1 bit = 2 info (o 0 o 1)
# 2 bit = 4 info (00 01 10 11)
# 3 bit (000 001 011 010 100 101 110 111)
# 4 bit - 16 info

# gran parte delle immagini di Landsat sono a 8 bit -> 256 -> la scala varia da 0 a 255. 
# la riflettanza va da 0 a 255; si approssimano i valori di pixel a degli interi
dvi_1992=  m1992[[1]] - m1992[[2]] #primo e secondo elemento dell'immagine satellitare 
dvi_1992= matogrosso~2219_lrg_1 - matogrosso~2219_lrg_2  # alternative way: cercare precisamente nomi delle bande tra le info dell'immagine
dvi_1992 # from -246 to 255

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi_1992, col=cl) 

dvi_2006 = m2006[[1]] - m2006[[2]]  #from -197 to 255
plot(dvi_2006, col=cl)
# valori di DVI molto più bassi nel 2006, biomassa prelevata

par(mfrow=c(1,2))
plot(dvi_1992, col=cl)
plot(dvi_2006, col=cl)

# 255 – 0/ 255 + 0 = 1 (Massimo NIR, minimo RED)
# 0 – 255/ 0 + 255 = -1 (minimo NIR, massimo RED)
# Confrontabile con:
# 15 – 0/ 15 + 0= 1
# 0-15/0+15= -1
# Se ho un’immagine a 8 bit (da -255 a 255) e una a 4 bit (da -15 a 15), esse non sono confrontabili; bisogna fare una normalizzazione 
# normalized dvi
ndvi_1992 <- dvi_1992/ (m1992[[1]] + m1992[[2]])
ndvi_2006 <- dvi_2006/ (m2006[[1]] + m2006[[2]])

par(mfrow=c(1,2))
plot(ndvi_1992, col=cl)
plot(ndvi_2006, col=cl)

# come possiamo fare per "insegnare" al sistema varie classi? ex. ghiacciaio, pianure, bosco, centro urbano 
# grafico a 3 dimensioni (per 3 bande) - come sono distribuiti i pixel di una certa immagine nello spazio spettrale? es. riflettanza bassa nel verde, bassa nel  blu, alta nel NIR
# individuiamo gruppi = cluster (es, suolo nudo e vegetazione saranno 2 cluster diversi) = training sites per far capire all'algoritmo (machine learning) cosa intendiamo per classi 
# e se un pixel si posizionasse tra i due cluster? si calcola distanza del pixel incognito dai due cluster: a quale  è più vicino? 
# algoritmo k-means classifica ogni pixel sulla base dei training sites 
# ora possiamo vodere come varia nel tempo il numeero di pixel dei diversi cluster



