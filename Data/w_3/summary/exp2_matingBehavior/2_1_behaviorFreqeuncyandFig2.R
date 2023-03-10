# -----------------------------------------------------------------------------------------
# Exp, 2 The frequency of mating behaviors for the conspecific and heterospecific females
# 
# title: 2_1_behaviorFrequencyAndFig2
# Date???2019/01/18, modification for submitted journal
# -----------------------------------------------------------------------------------------
library(beeswarm)
library(AER)

# set the directory and data file
maleIDandBehavior <- read.csv("maleIDandBehavior.csv")

# Table 2
# The difference between conspecific and heterospecific females
# assumed by the Poisson distribution, male species and female species
summary(glm(gonopodial_thrust ~ male_species * combination, data = maleIDandBehavior, family = poisson))
summary(glm(gonopodial_swing ~ male_species * combination, data = maleIDandBehavior, family = poisson))
summary(glm(follow ~ male_species * combination, data = maleIDandBehavior, family = poisson))

# sigmoid display is only P. reticula males and jolt is only G. affinis males
summary(glm(sigmoid_display ~ combination, data = subset(maleIDandBehavior, male_species == "poecilia"), family = poisson))
summary(glm(jolt ~ combination, data = subset(maleIDandBehavior, male_species == "gambusia"), family = poisson))



# ---------------------------------------------------------
# Drawing the boxplot and beeswarm plot
# ---------------------------------------------------------
# Calculate the frequency in a minute for each behavior
maleIDandBehavior$gonopodial_thrust <- maleIDandBehavior$gonopodial_thrust / 20
maleIDandBehavior$gonopodial_swing <- maleIDandBehavior$gonopodial_swing / 20
maleIDandBehavior$follow <- maleIDandBehavior$follow / 20
maleIDandBehavior$sigmoid_display <- maleIDandBehavior$sigmoid_display / 20
maleIDandBehavior$jolt <- maleIDandBehavior$jolt / 20

# rename the factor to distinguish male species and female species on the graph label
levels(maleIDandBehavior$male_species) <- c("gaM", "poM")
levels(maleIDandBehavior$female_species) <- c("gaF", "poF")

# reorder the label of female species
maleIDandBehavior$male_species <- relevel(maleIDandBehavior$male_species, ref = "poM")
maleIDandBehavior$female_species <- relevel(maleIDandBehavior$female_species, ref = "poF")

# separating the dataframe for drawing the beeswarm plot
gaMgaF <- subset(maleIDandBehavior, male_species == "gaM" & female_species == "gaF")
poMgaF <- subset(maleIDandBehavior, male_species == "poM" & female_species == "gaF")
gaMpoF <- subset(maleIDandBehavior, male_species == "gaM" & female_species == "poF")
poMpoF <- subset(maleIDandBehavior, male_species == "poM" & female_species == "poF")

par(mfrow = c(2,3))
# gonopodial_thrust
boxplot(gonopodial_thrust ~ combination * male_species, data = maleIDandBehavior,
        ylab = "Count per minute", xlab = "",
        main = "Gonopodial thrust", outline = FALSE, las = 1, ylim = c(0, 1))
beeswarm(list(poMpoF$gonopodial_thrust, poMgaF$gonopodial_thrust, gaMgaF$gonopodial_thrust, gaMpoF$gonopodial_thrust),
         method = "swarm", spacing = 1.0, cex = 1.2, add = TRUE)

# gonopodial_swing
boxplot(gonopodial_swing ~ combination * male_species, data = maleIDandBehavior,
        ylab = "", xlab = "",
        main = "Gonopodial swing", outline = FALSE, las = 1, ylim = c(0, 1))
beeswarm(list(poMpoF$gonopodial_swing, poMgaF$gonopodial_swing, gaMgaF$gonopodial_swing, gaMpoF$gonopodial_swing),
         method = "swarm", spacing = 1.0, cex = 1.2, add = TRUE)

# empty plot to adjust the order
plot(c(1), c(3), type = "n", yaxt = "n", xaxt = "n", ylab = "", xlab = "", bty = "n")

# follow
boxplot(follow ~ combination * male_species, data = maleIDandBehavior,
        ylab = "", xlab = "",
        main = "Follow", outline = FALSE, las = 1, ylim = c(0, 2))
beeswarm(list(poMpoF$follow, poMgaF$follow, gaMgaF$follow, gaMpoF$follow),
         method = "swarm", spacing = 1.0, cex = 1.2, add = TRUE)

# sigmoid_display
boxplot(sigmoid_display ~ combination * male_species, data = maleIDandBehavior,
        ylab = "", xlab = "",
        main = "Sigmoid display", outline = FALSE, las = 1, ylim = c(0, 1))
beeswarm(list(poMpoF$sigmoid_display, poMgaF$sigmoid_display, gaMgaF$sigmoid_display, gaMpoF$sigmoid_display),
         method = "swarm", spacing = 1.0, cex = 1.2, add = TRUE)

# jolt
boxplot(jolt ~ combination * male_species, data = maleIDandBehavior,
        ylab = "", xlab = "Combination of male species and female species",
        main = "Jolt", outline = FALSE, las = 1, ylim = c(0, 1))
beeswarm(list(poMpoF$jolt, poMgaF$jolt, gaMgaF$jolt, gaMpoF$jolt),
         method = "swarm", spacing = 1.0, cex = 1.2, add = TRUE)
