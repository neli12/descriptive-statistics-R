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


## Calculate the mean and sd
mean(dados$Clay)
sd(dados$Clay)

mean(dados$OM)
sd(dados$OM)

## Plot histograms and normal distributions
tiff("histograms.tif", width=2800, height=1800, res=300)
par(mfrow=c(1,2), mar=c(5,5,2,1))
plotNormalHistogram(dados$Clay, xlim = c(0,800), xlab = expression(paste("OM (g ", kg^-1, ")")), 
                    cex.axis = 1.2, cex.lab = 1.4)
text(600, 60, "Mean = 267.84", cex=1)
text(590, 57, "SD = 161.25", cex=1)

plotNormalHistogram(dados$OM, xlim = c(0,50), xlab = expression(paste("OM (g ", kg^-1, ")")), 
                    cex.axis = 1.2, cex.lab = 1.4)
text(40, 98, "Mean = 18.60", cex=1)
text(40, 93, "SD = 6.36",cex=1)

dev.off()

