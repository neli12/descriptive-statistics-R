library(corrplot)

## Load dataset from github
githubURL <- "https://github.com/neli12/machine-learning-R/raw/main/new_dataset.RData"
load(url(githubURL))


## Basic corrplots
corrplot(cor(dados), method = "number", type = "upper", tl.cex = 0.8, number.cex = 0.8)
corrplot(cor(dados), method = "color", type = "upper", tl.cex = 0.8, number.cex = 0.8)
corrplot(cor(dados), method = "shade", type = "upper", tl.cex = 0.8, number.cex = 0.8)
corrplot(cor(dados), method = "pie", type = "upper", tl.cex = 0.8, number.cex = 0.8)
corrplot(cor(dados), method = "ellipse", type = "upper", tl.cex = 0.8, number.cex = 0.8)

