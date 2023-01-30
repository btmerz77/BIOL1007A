##### Simple Data Analysis and More complex Control Structures
##### 30 January 2023
##### BTM

dryadData <- read.table(file = "/Users/BenM/Library/Mobile Documents/com~apple~CloudDocs/Documents/College/Bio/Reproducible R/Git Repository/BIOL1007A/Data/d_8/veysey-babbitt_data_amphibian.csv", header = T, sep = ",")

## set up libraries
library(tidyverse)
library(ggthemes)

### Analyses
### Experimental designes
    ### independent/explanatory variable(x-axis) vs dependent/response variable (y-axis)
    ### continuous (range of numbers: height, weight, temperature) vs discrete/categoral (categories: species, treatments, site)

# Regression (dependent: continuous, independent: continuous)
  # linear model of y=a+bx
    # Comes form a scatter plot
  # statistical tests for null of hypothesis of slope and/or intercept = 0
  # confidence and prediction intervals of uncertainty
  # goodness of fit tests for linearity

# ANOVA: Dependent: categorical, independent: continuous
  # ANOVA
  # T-test
  # Visualize
    # boxplot
    # barplot

# Chi-squared: dependent: = categorical, independent: categorical

# logistic regression: dependent: continous, indepented = categorical
  # logistic regression curve

glimpse(dryadData)



### Basic linear regression analysis (2 continuous variables)
## Is there a relationship between mean pool hydroperiod and number of breeding frogs caught?

# model y (response) ~ x (explanatory)
regModel <- lm(count.total.adults ~ mean.hydro, data = dryadData)
# model output
regModel # printed output is sparse
#View(summary(regModel)) # you can expand table to get coefficients code
head(regModel$residuals)

# looks like a relatively normal distribution
hist(regModel$residuals) 
# contains residuals
# 'summary' of model has elements
summary(regModel) # p=3.27e-06

# Two different ways to extract certain elements from 
summary(regModel)[["r.squared"]]
summary(regModel)$"r.squared"

summary(regModel)$coefficients

# best to examine entire matrix of coefficients:
summary(regModel)$coefficients[] #shows all
summary(regModel)$coefficients[2,1]   # slope estimate of the relationship'

# visualize
regPlot <- ggplot(data = dryadData, aes(x = mean.hydro, y = count.total.adults)) +
  geom_point() +
  stat_smooth(method = "lm", se = 0.99)
regPlot + theme_few()



### Basic ANOVA
## Was there a statistically signficant difference in the number of adults among years?

# y~x 
ANOmodel <- aov(count.total.adults ~ factor(wetland), data=dryadData)
print(ANOmodel)
summary(ANOmodel)

dryadData %>%
  group_by(factor(wetland)) %>%
  summarise(avgHydro = mean(count.total.adults, na.rm=T), n=n())

dryadData %>%
  group_by(wetland) %>%
  summarise(avgHydro = mean(count.total.adults, na.rm=T), n=n())

### Boxplot
dryadData$wetland <- factor(dryadData$wetland) # overwrite wetland to make it a factor

ANOplot <- ggplot(data = dryadData, mapping = aes(x = wetland, y = count.total.adults, fill = species)) +
  geom_boxplot() +
  scale_fill_grey()
## either save via export in the plots window
# ggsave(file = "SpeciesBoxplots.pdf", plot = ANOplot, device = "pdf")



# Data frame construction for logistic regression

## Gamma Distribution: a continuous probability distribution that is widely used in different fields of science to model continuous variables that are always positive and have skewed distributions.

xVar <- sort(rgamma(n=200,shape=5,scale=5))
yVar <- sample(rep(c(1,0),each=100),prob=seq_len(200))
lRegData <- data.frame(xVar,yVar)

### Logistic regression Analysis
logRegModel <- glm(yVar ~ xVar, data = lRegData, family = binomial(link = logit))
summary(lRegData)

logRegPlot <- ggplot(data = lRegData, aes(x = xVar, y = yVar)) +
  geom_point() + 
  stat_smooth(method = "glm", method.args = list(family = binomial))
logRegPlot


### Contigency table (chi-squared) anlysis
# Are there differences in couunts of males and females between species
countData<- dryadData %>%
  group_by(species) %>%
  summarize(Males=sum(No.males, na.rm=T), Females=sum(No.females, na.rm=T)) %>%
  select(-species) %>%
  as.matrix() 

row.names(countData)=c("SS","WF") # have to give names
countData

print(chisq.test(countData))

# some simple plots using baseR
mosaicplot(x=countData,
           col=c("goldenrod","grey"),
           shade=FALSE)

countDataLong <- countData %>%
  as_tibble() %>%
  mutate(Species=c(rownames(countData))) %>%
  pivot_longer(cols=Males:Females,
               names_to = "Sex",
               values_to = "Count")
ggplot(countDataLong, aes(x=Species, y=Count, fill=Sex)) +
  geom_bar(stat="identity", position="dodge") +
  scale_fill_manual(values=c("black", "darkslateblue"))


##################################
#Control Structures
##################################

# if statements
  # if (condition) {expression1}
  # if (condition) {expression1} else {expression2}
  # if (condition1) {expression1} else
  # if (condition2) {expression2} else

# note that final unspecified else captures rest of the (unspecified) conditions
# else statement must appear on the same line as the expression
# typically enclose multiple statements in brackets {} for compound expression
# if ny final unspecificed else captures the rest of the (unspecified conditions)

z <- signif(runif(1),digits=2)
print(z)
z > 0.5

# works with or without {} after if
if (z > 0.8) {cat(z,"is a large number","\n")} else 
  if (z < 0.2) {cat(z,"is a small number","\n")} else
  {cat(z,"is a number of typical size","\n")
    cat("z^2 =",z^2,"\n")}

# if statement requires a single logical value. With a vector,
# it will throw an error.
z <- 1:10
# this does not do anything
if (z > 7) print(z)

# use subsetting!
print(z[z < 7])


#### ifelse to fill vectors
# ifelse(test,yes,no)
  # test is an object that can be coerced to a logical yes/no
  # yes return values for true elements of test
  # no return vales for false elements of test

# Suppose we have an insect population in which each female lays, on average, 10.2 eggs, following a Poisson distribution with λ=10.2. However, there is a 35% chance of parasitism, in which case no eggs are laid. Here is the distribution of eggs laid for 1000 individuals:

# Poisson: a statistical distribution showing the likely number of times that an event will occur within a specified period of time

tester <- runif(1000) # start with random uniform elements
eggs <- ifelse(tester>0.35,rpois(n=1000,lambda=10.2),0)
hist(eggs)

pVals <- runif(1000)
z <- ifelse(pVals<=0.025,"lowerTail","nonSig")
z[pVals>=0.975] <- "upperTail"
table(z)



#### For loops
# The workhorse function for doing repetitive tasks
# Universal in all computer languages
# Controversial in R
  # often not necessary (use vectorized operations!)
  # very slow with binding operations (c,rbind,cbind,list)
  # many operations can be handled by special family of apply functions

# Anatomy of a for loop

# for (var in seq) { # start of for loop
#   # body of for loop 
# } # end of for loop
# var is a counter variable that will hold the current value of the loop (i, j, k)
# seq is an integer vector (or a vector of character strings) that defines the starting and ending values of the loop

for (i in 1:5) {
  cat("stuck in a loop",i,"\n")
  cat(3 + 2,"\n")
  cat(runif(1),"\n")
}
print(i)

# use a counter variable that maps to the position of the element
my_dogs <- c("chow","akita","malamute","husky","samoyed")
for (i in 1:length(my_dogs)){
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}


# using doubles for loops
m <- matrix(round(runif(20),digits=2),nrow=5)
# loop over rows
for (i in 1:nrow(m)) { # could use for (i in seq_len(nrow(m)))
  m[i,] <- m[i,] + i
} 
print(m)

# Loop over columns
m <- matrix(round(runif(20),digits=2),nrow=5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# Loop over rows and columns
m <- matrix(round(runif(20),digits=2),nrow=5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j
  } # end of column j loop
} # end or row i loop
print(m) 





