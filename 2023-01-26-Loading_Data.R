##### Loading Data
##### 26 January 2023
##### BTM


### Read in a dataset
  # read.table()
    # allows you to add # at the beggining of the file for meta data

  # read.table(file="Path/To/OutputFileName.csv",
  #             HEADER=TRUE,
  #             sep=",")
  
  ## also use read.csv()
  # read.csv(file = "data.csv", header = T)

### Create and save a dataset
# write.table(x=my_data,
#             file="Path/To/OutputFileName.csv",
#             HEADER=TRUE,
#             sep=",")

### Use RDS object hwen only working in R
  ## Save RDS(my_data, file = "FileName.RDS") ## Make sure to put .RDS so you know what type of object this is
  ## readRDS("Filename.RDS")
  ## ex p <- readRDS("Filename.RDS")



### ‘Long’ vs ‘Wide’ data format:
  # A wide format contains values that do not repeat in the ID column. A long format contains values that do repeat in the ID column.
  # sometimes data is collected and entered one way, but needed in a different format for analysis and plotting

  # the pivot_longer() function in the tidyr package makes datasets longer by increasing the number of rows and decreasing the number of columns.

library(tidyverse) 

#billboard rank of songs in the year 2000
head(billboard)
billboard %>%
  pivot_longer(
    cols = starts_with("wk"), #specify which columns you want to make 'longer'
    names_to = "week", #name of new column of header names
    values_to = "rank", #name of new column of cell values
    values_drop_na = TRUE #removes any rows where the values = NA
  )

  # pivot_wider() “widens” data, increasing the number of columns and decreasing the number of rows.
  # best for making occupancy matrix
head(fish_encounters) 
table(fish_encounters$seen) 
# create an occupancy matrix  
head(fish_encounters)
fish_encounters %>%
  pivot_wider(names_from = station, #which column would you like to turn into multiple columns
              values_from = seen) #which column contains the values for the new columns
# Fill in missing values with 0s
fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen, values_fill = 0) # any NA that need to be filled will be 0



# Publicly available data through Dryad
  # a curated resource that makes research data discoverable, freely reusable, and citable.
  # You can explore data sets here: https://datadryad.org/search

dryadData <- read.table("/Users/BenM/Library/Mobile Documents/com~apple~CloudDocs/Documents/College/Bio/Reproducible R/Git Repository/BIOL1007A/Data/veysey-babbitt_data_amphibian.csv", header=TRUE, sep=",", stringsAsFactors = TRUE)

glimpse(dryadData)
head(dryadData)

table(dryadData$species)
summary(dryadData$mean.hydro)

### Analysis

# Archetype Experimental Designs
  # independent versus dependent variables
  # discrete versus continuous variables
  # continuous variables (integer and real)
  # direction of cause and effect, x axis is independent
  # continuous versus discrete (natural or arbitrary or statistical bins)
# Regression (dependent: continuous, independent: continuous)
  # linear model of y=a+bx
  # statistical tests for null of hypothesis of slope and/or intercept = 0
  # confidence and prediction intervals of uncertainty
  # goodness of fit tests for linearity

# Basic linear regression analysis in R (using 2 continuous variables)
# Is there a relationship between mean pool hydroperiod and number of breeding frogs caught?

# model y (response) ~ x (explanatory)
regModel <- lm(count.total.adults~mean.hydro,data=dryadData)
# model output
regModel # printed output is sparse
#View(summary(regModel)) # you can expand table to get coefficients code
head(regModel$residuals)
hist(regModel$residuals) 
# contains residuals
# 'summary' of model has elements
summary(regModel) # p=3.27e-06

summary(regModel)[["r.squared"]]
summary(regModel)$"r.squared"

summary(regModel)$coefficients

# best to examine entire matrix of coefficients:
summary(regModel)$coefficients[] #shows all
summary(regModel)$coefficients[2,1]   # slope estimate of the relationship



library(tidyverse)
library(ggthemes)
dryadData$species<-factor(dryadData$species, labels=c("Spotted Salamander", "Wood Frog")) #creating 'labels' to use for the plot
class(dryadData$treatment)

dryadData$treatment <- factor(dryadData$treatment, 
                              levels=c("Reference",
                                       "100m", "30m"))


p<- ggplot(data=dryadData, 
           aes(x=interaction(wetland, treatment), 
               y=count.total.adults, fill=factor(year))) + geom_bar(position="dodge", stat="identity", color="black") +
  ylab("Number of breeding adults") +
  xlab("") +
  scale_y_continuous(breaks = c(0,100,200,300,400,500)) + # y axis should be broken up by 100s
  scale_x_discrete(labels=c("30 (Ref)", "124 (Ref)", "141 (Ref)", "25 (100m)","39 (100m)","55 (100m)","129 (100m)", "7 (30m)","19 (30m)","20 (30m)","59 (30m)")) + 
  facet_wrap(~species, nrow=2, strip.position="right") +
  theme_few() + scale_fill_grey() + 
  theme(panel.background = element_rect(fill = 'gray94', color = 'black'), legend.position="top",  legend.title= element_blank(), axis.title.y = element_text(size=12, face="bold", colour = "black"), strip.text.y = element_text(size = 10, face="bold", colour = "black")) + 
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) 

p

