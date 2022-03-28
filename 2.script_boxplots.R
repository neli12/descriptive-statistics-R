## Load libraries
library(reshape)
require(ggplot2)

## Set working directory , list files and load dataset
setwd("C:/Users/FREY/Documents")
list.files()

dados  <- read.csv("dataset.csv", sep = ";")[,-1:-2]

## Or load dataset from github
githubURL <- "https://github.com/neli12/descriptive-statistics-R/raw/main/dataset.RData"
load(url(githubURL))

dados <- dataset[,-1:-2]

## Rename and reshape datasets
colnames(dados) <- c("Clay", "OM")

# Select randomly 30% of the dataset, split in training and validation, and reshape
val_rows <- sample(nrow(dados), 116)

dat_train <- dados[-val_rows,]
dat_train$name <- "Train"
dat_train_reshape <- melt(dat_train)


dat_test <- dados[val_rows,]
dat_test$name <- "Test"
dat_test_reshape <- melt(dat_test)

## Put it all together again
properties <- rbind(dat_train_reshape, dat_test_reshape)


## Boxplots
## Note: You can change the width and height of your plot to fit into a nice figure.
## The res argument was set to 300 dpi, as this is the minimum resolution required by
## scientific journals.

## Boxplot 1: Plot both variables together
tiff("Box1.tif", width = 1800, height = 1200, res = 300)
ggplot(properties, aes(x = reorder(variable, X=value, FUN = median), y=value)) + 
  geom_boxplot(color="black", fill="dark grey", show.legend = FALSE) +  
  theme_bw() + ylab(expression(paste("Content (g ", " ", kg^-1, ")"))) + 
  xlab("") + theme(axis.text.x = element_text(size = 8, color = "black")) + 
  theme(axis.text.y = element_text(size = 12, color = "black")) + theme(text = element_text(size=12, color = "black"))
dev.off()

## Boxplot 2: Making a facet
tiff("Box1.tif", width = 1800, height = 1200, res = 300)
ggplot(properties, aes(x = name, y=value, fill = name)) + 
  geom_boxplot(show.legend = FALSE) +
  scale_fill_brewer(palette="BuPu") +   ## You can change the palette here to customize the colors of your boxplots
  theme_bw() + ylab(expression(paste("Content (g ", " ", kg^-1, ")"))) + xlab("") + 
  theme(axis.text.x = element_text(size = 8, color = "black")) + 
  theme(axis.text.y = element_text(size = 12, color = "black")) + 
  theme(text = element_text(size=12, color = "black")) + 
  facet_wrap(~variable, scales = 'free')
dev.off()
