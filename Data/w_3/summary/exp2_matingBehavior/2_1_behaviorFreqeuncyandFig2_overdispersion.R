# -----------------------------------------------------------------------------------------
# Exp, 2 The frequency of mating behaviors for the conspecific and heterospecific females
# 
# title: 2_1_behaviorFrequencyAndFig2
# Date?¼?2019/01/18, modification for submitted journal
# -----------------------------------------------------------------------------------------
library(beeswarm)
library("AER") # overdispersion test
library("MASS") # GLM with negative binomial error

# set the directory and data file
maleIDandBehavior <- read.csv("maleIDandBehavior.csv")

# tests for overdispersion with Poisson error
# Table S1
dispersiontest(glm(gonopodial_thrust ~ male_species * combination, data = maleIDandBehavior, family = poisson))
dispersiontest(glm(gonopodial_swing ~ male_species * combination, data = maleIDandBehavior, family = poisson))
dispersiontest(glm(follow ~ male_species * combination, data = maleIDandBehavior, family = poisson))
dispersiontest(glm(sigmoid_display ~ combination, data = subset(maleIDandBehavior, male_species == "poecilia"), family = poisson))
dispersiontest(glm(jolt ~ combination, data = subset(maleIDandBehavior, male_species == "gambusia"), family = poisson))
 
# Table S2
# gonopodial thrust
model1 <-  glm.nb(gonopodial_thrust ~ male_species * combination, data = maleIDandBehavior)
model2 <-  glm.nb(gonopodial_thrust ~ male_species + combination, data = maleIDandBehavior)
model3 <-  glm.nb(gonopodial_thrust ~ male_species, data = maleIDandBehavior)
model4 <-  glm.nb(gonopodial_thrust ~ combination, data = maleIDandBehavior)
model5 <-  glm.nb(gonopodial_thrust ~ 1, data = maleIDandBehavior)
AIC(model1, model2, model3, model4, model5)

# gonopodial swing
model1 <-  glm.nb(gonopodial_swing ~ male_species * combination, data = maleIDandBehavior)
model2 <-  glm.nb(gonopodial_swing ~ male_species + combination, data = maleIDandBehavior)
model3 <-  glm.nb(gonopodial_swing ~ male_species, data = maleIDandBehavior)
model4 <-  glm.nb(gonopodial_swing ~ combination, data = maleIDandBehavior)
model5 <-  glm.nb(gonopodial_swing ~ 1, data = maleIDandBehavior)
AIC(model1, model2, model3, model4, model5)

# follow
model1 <-  glm.nb(follow ~ male_species * combination, data = maleIDandBehavior)
model2 <-  glm.nb(follow ~ male_species + combination, data = maleIDandBehavior)
model3 <-  glm.nb(follow ~ male_species, data = maleIDandBehavior)
model4 <-  glm.nb(follow ~ combination, data = maleIDandBehavior)
model5 <-  glm.nb(follow ~ 1, data = maleIDandBehavior)
AIC(model1, model2, model3, model4, model5)

# sigmoid_display
model1 <-  glm.nb(sigmoid_display ~ combination, data = subset(maleIDandBehavior, male_species == "poecilia"))
model2 <-  glm.nb(sigmoid_display ~ 1, data = subset(maleIDandBehavior, male_species == "poecilia"))
AIC(model1, model2)

# jolt
model1 <-  glm.nb(jolt ~ combination, data = subset(maleIDandBehavior, male_species == "gambusia"))
model2 <-  glm.nb(jolt ~ 1, data = subset(maleIDandBehavior, male_species == "gambusia"))
AIC(model1, model2)
