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
im.plotRGB(m1992, r=2, g=1, b=3) # NIR su verde (g=1), tutto ciò che era infrarosso diventa verde, quindi vedo la foresta verde

im.plotRGB(m1992, r=2, g=3, b=1) # NIR su blu (b=1), quindi vedo la foresta blu

# firma spettrale dell'acqua: acqua assorbe infrarosso; è nera (qui in realtà no, perché ci sono detriti quindi è come il suolo nudo
