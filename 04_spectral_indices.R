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

# perché la riflettanza va da 0 a 255; si approssimano i valori di pixel a degli interi
