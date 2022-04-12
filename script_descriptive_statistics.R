##Descriptive statistics##
#Load or install packages

library(rgdal)
library(e1071)
library(dgof)
library(ggpubr)
library(EnvStats)
library(rcompanion)
library(tmap)
library(sf)
library(leaflet) 
library(reshape)
library(ggridges)
library(tidyverse)
library(leaflet)
library(stringr)
library(sf)
library(here)
library(widgetframe)

#If you do not have some of the packages listed above, you can install them using the code below
install.packages()  ##inside the brackets put the name of the package that you want to install

#Set working directory##
setwd("D:/GitHub_scripts/R_scripts/descriptive_statisctics")

#Load the data
#The dataset loaded corresponds to soil samples collected in Brazil. There are 12 variables
dat1 <- read.csv("dados.csv", h=TRUE, sep=";") #the "sep" argument could be different in your computer ";" or ","
summary(dat1) ##summary of the data. This could help you to see if there is NA values in your dataset

#Exlude NA´s if you have it in your dataset
dat2 <- dat1[complete.cases(dat1),]

##Separate data from spectra##
dat3 <- dat2[,1:20]
spectra <- dat2[c(1:5, 21:2171)]

##to see where your data falls##
glimpse(dat3)
leaflet(data = dat3) %>%
  addTiles() %>%
  addMarkers(lng = ~X, lat=~Y) %>%
  frameWidget()

#The first step when working with data is to see the structure and distributions. We can do it by plotting
#histograms or boxplots and checking the normality by using some tests available for that
#Let's try only with one variable: Clay content. The $ is used to select a specific variable from your data

dat3 <- as.numeric(dat3[,5:20])
hist(dat3$Clay.gkg)  ##Is the simplest way to see the histogram of a variable
boxplot(dat3$Clay.gkg)  ##Is the simplest way to see a boxplot

##Both the histogram and boxplot represent the distribution of your data. The main difference among them is 
##that the histogram shows the frequency of values and the boxplot shows other parameters such as the 25th, 50th (median) and 75th 
##quantiles and the possible outliers present in the data. Here, with the histogram and boxplot we can see that most of the 
##data are concentrated in low values (0-300 g kg). Clearly, we do not have a normal distribution and our data has a positive skewness.
##We can check the normality, skewness and kurtosis using the following functions:
shapiro.test(dat3$Clay.gkg)  #The shapiro.test() only works wih dataset smaller than 5000 samples
skewness(dat3$Clay.gkg)
kurtosis(dat3$Clay.gkg)

#Another way to check the normality is to do the qqplot. There are two ways
qqnorm(dat3$Clay.gkg);qqline(dat3$Clay.gkg,col='red')
ggqqplot(dat3$Clay.gkg)    ###

#Data transformation
#If your data do not follow a normal distribution, you can transform it (depending on your objective)
#We can perform it by taking the log of the data
dat3@data$Clay.log <- log(dat3$Clay.gkg)  #We have created a new column in our dataset named Clay.log
hist(dat3@data$Clay.log)
boxplot(dat3@data$Clay.log)
skewness(dat3@data$Clay.log)
kurtosis(dat3@data$Clay.log)

ggqqplot(dat3@data$Clay.log)

#As our data has approximate
##Plotting and saving distribution's graphs
##Let's plot only silt, sand and clay
dados <- as.data.frame(dat3)
texture <- dados[,6:8] #The numbers inside the brackets represent the number of the columns where are the data that we want to select
colnames(texture) <- c("Clay", "Silt", "Sand")  #rename column names
texture.melt <- melt(texture)  #reshape your data
head(texture.melt)   #to show the first six lines of your data

#Boxplots
tiff("boxplotplot_texture.tif", width = 2200, height = 1500, res = 300)   #setting parameters to save the graphic 
ggplot(texture.melt, aes(x = variable, y = value)) + 
  geom_boxplot(aes(fill = variable, alpha = 0.8)) + theme_bw() + 
  xlab("") + ylab(expression(paste("Content (g ", kg^-1, ")"))) +
  theme(legend.position = "none")
dev.off()  #to save the graph


##ggridges##
tiff("boxplotplot_texture.tif", width = 2200, height = 1500, res = 300)
#to adjust the graph, you can change the width and height arguments#
ggplot(texture.melt, aes(x = value, y = variable, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = expand_scale(mult = c(0.01, 0.25))) +
  scale_fill_viridis_c(name = expression(paste("Content (g ",kg^-1, ")", sep="")), option = "C") +
  labs(title = 'Particle size distributions') +
  theme_ridges(font_size = 13, grid = TRUE) + 
  theme(axis.title.y = element_blank())
dev.off()  #to save the graph

##Histograms
tiff("histogram_texture.tif", width = 2200, height = 1500, res = 300)
par(mfrow=c(1,3), mar=c(5,4,2,2))  #divide the window in 3 columns
plotNormalHistogram(texture$Clay, ylab="Frequency",xlab=expression(paste("Clay content (g ",kg^-1, ")", sep="")))
plotNormalHistogram(texture$Silt, ylab = "", xlab=expression(paste("Silt content (g ",kg^-1, ")", sep="")))
plotNormalHistogram(texture$Sand, ylab = "", xlab=expression(paste("Sand content (g ",kg^-1, ")", sep="")))
dev.off()

plotNormalHistogram(texture$Sand, ylab = "", 
                    xlab=expression(paste("Sand content (g ",kg^-1, ")", sep="")), xlim = c(0,1000),
                    ylim = c(0,35))
