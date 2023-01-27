# ----------------------------------------------------------------------------------
# Exp, 1 Male mate choice experiment between P. reticulata and G. affinis
# Apply the dirichlet regression, and plotting the figure 1, 
# 
# title: 1_2_dirichletReg
# Date：2019/01/18, modification for submitted journal
# ----------------------------------------------------------------------------------
library(tidyverse) # dataframe modification
library(DirichletReg) # apply Dirichlet distribution

# set the directory and data file
speciesIdentification <- read.csv("exp1_maleMateChoiceDataset.csv")

# some males were excluded from the anlysis (P. reticulata; n = 4, G. affinis; n = 2),
# because those fishes did not associate the conspecific female during the acclimation period
speciesIdentification <- subset(speciesIdentification, exclude == "0")

# exclude the records of acclimation period (treatment = control)
preferenceTimeData <- subset(speciesIdentification, treatment == "preference" & femaleSpecies != "intermediate")

# ----------------------------------------------------------------------------------
# Regression analysis assumed dirichlet distribution
# 
# list of explanatory variables
# maleSpecies (P. reticulata or G. affinis)
# maleWeight：Body weight of male
# femaleWeight_poMinusga：Difference of body weight between two females
# （P. reticulata female - G.affinis female）
# ---------------------------------------------------------------------------------

# Convert the dataframe to DR_data
modifiedData <- subset(speciesIdentification, treatment == "preference")
modifiedData <- tidyr::spread(modifiedData, key = femaleSpecies, value = spendingTime)
DirichleDataset <- DR_data(modifiedData[9:11])

# Apply the dirihclet regression
model <- DirichReg(DirichleDataset ~ maleSpecies + maleWeight + femaleWeight_poMinusga, modifiedData)
summary(model) # Table 1

# -----------------------------------------------------------------------------------------
# The proportion of male association time for P. reticulata female and G.affinis female
# -----------------------------------------------------------------------------------------
# Figure. P. reticulata males
poMdata <- subset(modifiedData, maleSpecies == "poecilia")[9:11]
poMdata <- data.frame(intermediate = poMdata$intermediate, poecilia = poMdata$poecilia, gambusia = poMdata$gambusia)
poDRplot <- DR_data(poMdata)
plot(poDRplot, a2d = list(colored = FALSE), cex = 1.2, main = "Poecilia male")

# Figure. G. affinis males
gaMdata <- subset(modifiedData, maleSpecies == "gambusia")[9:11]
gaMdata <- data.frame(intermediate = gaMdata$intermediate, poecilia = gaMdata$poecilia, gambusia = gaMdata$gambusia)
gaDRplot <- DR_data(gaMdata)
plot(gaDRplot, a2d = list(colored = FALSE), cex = 1.2, main = "Gambusia male")

