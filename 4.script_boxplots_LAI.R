## Load libraries

require(raster)
require(reshape)
require(xts)
require(dplyr)
require(ggplot2)
require(forcats)

## Load raster data
soil <- raster("SOIL.tif")
geo <- raster("Mat_orig_rfcut.tif")
IAF <- stack("IAF_Cut.tif")  ## IAF: Indice de area foliar (Leaf area index)

## Resample the IAF to fit the soil pixel size
IAF.resampled <- resample(IAF, soil)

## Stack both rasters and convert the new stack into data frame
IAF.soil <- stack(IAF.resampled, soil)
IAF.soil <- as.data.frame(IAF.soil)


## Select complete cases and change the 25th column to factor format
IAF.soil <- IAF.soil[complete.cases(IAF.soil),]
IAF.soil[,25] <- as.factor(IAF.soil[,25])

## Rename the columns
colnames(IAF.soil) <- c("Dec", "Jan1", "Jan2", "Fev", "Mar1", "Mar2", "Mar3", "Apr", "Jun1", "Jun2", 
                      "Jun3", "Jun4", "Jul1", "Jul2", "Jul3", "Jul4", "Aug1", "Sep1",  "Sep2", "Sep3", "Oct1", "Oct2", "Oct3", "Nov", "Soil")

## Reshape the dataset
IAF.melt <- melt(IAF.soil)

## Plot boxplots by month
p <- IAF.melt %>%
  mutate(variable = fct_relevel(variable , 
                             "Dec", "Jan1", "Jan2", "Fev", "Mar1", "Mar2", "Mar3", "Apr", "Jun1", "Jun2", 
                             "Jun3", "Jun4", "Jul1", "Jul2", "Jul3", "Jul4", "Aug1", "Sep1",  "Sep2", "Sep3", "Oct1", "Oct2", "Oct3", "Nov")) %>%
  ggplot(aes(x=variable, y=value, fill = Soil)) + xlab("Month") + ylab("LAI")+
  geom_boxplot(outlier.shape = NA) + theme_bw() + ylim(0,6) + 
  scale_fill_brewer(palette="RdBu")
p

