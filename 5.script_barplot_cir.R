library(ggplot2)

list.files()

dat <- read.csv('medianas_circular_barplot.csv', sep = ";")

dat$Banco <- as.factor(dat$Banco)
dat$Atributos <- as.factor(dat$Atributos)


tiff('barplot.tif', width = 3500, height = 1800, res = 300)
ggplot(dat, aes(x = Atributos, y = Mediana, fill = Banco)) +
  geom_col(position = "dodge") + theme_bw() + 
  coord_polar()
 
dev.off()
