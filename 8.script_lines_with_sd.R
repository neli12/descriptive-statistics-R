## Load libraries
library(ggplot2)
library(ggpubr)


## Load data
dat1 <- read.csv("cluster_1.csv", sep = ";")

## Plot graph
tiff("lines_with_sd.tif", width = 2900, height = 2200, res = 300)
ggplot(data=dat1, aes(x=wavelenght, 
                      y=reflectancia, 
                      ymin=(reflectancia - sd),
                      ymax=(reflectancia + sd), 
                      group=nome, 
                      linetype=nome)) +
  geom_line(aes(color = nome), size = 0.8) +
  geom_ribbon(fill = 'gray', alpha=0.5) + 
  theme_bw()

dev.off()
