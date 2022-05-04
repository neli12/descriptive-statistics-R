## Load libraries
library(plotly)
library(ggpubr)

## Load data
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/violin_data.csv")


## Basic violin plot
plot_ly(df, y = ~total_bill, type = 'violin', color = "pink", box = list(visible = T),
              meanline = list(visible = T), x0 = 'Total bill') %>% 
     layout(yaxis = list(title = "", zeroline = F))

## Plot by sex
plot_ly(df, x = ~sex, y = ~total_bill, split = ~sex, type = 'violin', box = list(visible = T),
              meanline = list(visible = T), x0 = 'Total bill') %>% 
  layout(yaxis = list(title = "Sex", zeroline = F))

## Plot by sex and day
plot_ly(df, type = 'violin') %>%   
  add_trace(x = ~day[df$sex == 'Male'], y = ~total_bill[df$sex == 'Male'], 
                  legendgroup = 'M', scalegroup = 'M', name = 'M',
                  box = list(visible = T), 
                  meanline = list(visible = T),
                  color = I('red')) %>%
  add_trace(x = ~day[df$sex == 'Female'], y = ~total_bill[df$sex == 'Female'], 
            legendgroup = 'F', scalegroup = 'F', name = 'F',
            box = list(visible = T), 
            meanline = list(visible = T),
            color = I('yellow')) %>%
  layout(yaxis = list(zeroline = F, title = 'Total bill'), violinmode = 'group',
         xaxis = list(title = ''))

