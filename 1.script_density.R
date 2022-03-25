## Load libraries
library(reshape)
require(ggplot2)
require(ggpubr)

## Set working directory , list files and load dataset
setwd("C:/Users/FREY/Documents")
list.files()

dados  <- read.csv("dataset.csv", sep = ";")[,-1:-2]


# Select randomly 30% of the dataset and split in training and validation
val_rows <- sample(nrow(dados), 116)

dat_train <- dados[-val_rows,]
dat_test <- dados[val_rows,]


## Separate clay 
clay.train <- as.data.frame(dat_train$Clay.gkg)
clay.test <- as.data.frame(dat_test$Clay.gkg)

clay.train$name <- "Train"
colnames(clay.train) <- c("Clay", "dataset")

clay.test$name <- "Test"
colnames(clay.test) <- c("Clay", "dataset")

clays <- rbind(clay.train, clay.test)

## Separate OM
OM.train <- as.data.frame(dat_train$OM.gkg)
OM.test <- as.data.frame(dat_test$OM.gkg)

OM.train$name <- "Train"
colnames(OM.train) <- c("OM", "dataset")

OM.test$name <- "Test"
colnames(OM.test) <- c("OM", "dataset")

OMs <- rbind(OM.train, OM.test)


p1 <- ggplot(clays, aes(Clay, fill = dataset)) + geom_density(alpha = 0.2) + 
  xlab(expression(paste("Clay content (g ", kg^-1, ")"))) + ylab("") + theme_classic()

p2 <- ggplot(OMs, aes(OM, fill = dataset)) + geom_density(alpha = 0.2) + 
  xlab(expression(paste("OM content (g ", kg^-1, ")"))) + ylab("") + theme_classic()


## Arrange the graph in a 1*2 scheme (column * row) and save
tiff("density_plot.tif", width = 4400, height = 2500, res = 300)
ggarrange(p1, p2, ncol=1, nrow=2, common.legend = TRUE)
dev.off()
