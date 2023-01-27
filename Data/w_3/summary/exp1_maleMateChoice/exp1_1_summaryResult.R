# ----------------------------------------------------------------------------------
# Exp, 1 Male mate choice experiment between P. reticulata and G. affinis
# calculate the mean and standard deviation of experimental results
# 
# title: 1_1_resultSymmary
# Date：2019/01/18, modification for submitted journal
# ----------------------------------------------------------------------------------
# set the directory and data file
speciesIdentification <- read.csv("exp1_maleMateChoiceDataset.csv")

# some males were excluded from the anlysis (P. reticulata; n = 4, G. affinis; n = 2),
# because those fishes did not associate the conspecific female during the acclimation period
speciesIdentification <- subset(speciesIdentification, exclude == "0")

# exclude the records of acclimation period (treatment = acclimation)
preferenceTimeData <- subset(speciesIdentification, treatment == "preference" & femaleSpecies != "intermediate")


# the mean and standard deviation of time spent in conspecific and heterospecific zone
data.frame(maleSpecies = c("poecilia", "poecilia", "gambusia", "gambusia"),
           femaleSpecies = c("gambusia", "poecilia", "gambusia", "poecilia"),
           average = c(mean(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "poecilia" & 
                                                              preferenceTimeData$femaleSpecies == "gambusia"]),
                       mean(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "poecilia" &
                                                              preferenceTimeData$femaleSpecies == "poecilia"]),
                       mean(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "gambusia" & 
                                                              preferenceTimeData$femaleSpecies == "gambusia"]),
                       mean(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "gambusia" &
                                                              preferenceTimeData$femaleSpecies == "poecilia"])),
           sd = c(sd(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "poecilia" & 
                                                       preferenceTimeData$femaleSpecies == "gambusia"]),
                  sd(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "poecilia" &
                                                       preferenceTimeData$femaleSpecies == "poecilia"]),
                  sd(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "gambusia" & 
                                                       preferenceTimeData$femaleSpecies == "gambusia"]),
                  sd(preferenceTimeData$spendingTime[preferenceTimeData$maleSpecies == "gambusia" &
                                                       preferenceTimeData$femaleSpecies == "poecilia"]))
)

# -------------------------------------------------------------------------------
# strength of preference (SOP):
# SOP = the time spent in conspecific zone /
#             the sum of the time spent in conspecific and heterospecific zones
# -------------------------------------------------------------------------------
totalAssociationTime <- aggregate(spendingTime ~ treatment * maleID * maleSpecies,data = preferenceTimeData, sum)

gamconfSOP <- (subset(preferenceTimeData, maleSpecies == "gambusia" & femaleSpecies == "gambusia")$spendingTime / 
                  subset(totalAssociationTime, maleSpecies == "gambusia")$spendingTime)
gamheterofSOP <- (subset(preferenceTimeData, maleSpecies == "gambusia" & femaleSpecies == "poecilia")$spendingTime / 
                  subset(totalAssociationTime, maleSpecies == "gambusia")$spendingTime)
pomconfSOP <- (subset(preferenceTimeData, maleSpecies == "poecilia" & femaleSpecies == "poecilia")$spendingTime / 
                 subset(totalAssociationTime, maleSpecies == "poecilia")$spendingTime)
pomheterofSOP <- (subset(preferenceTimeData, maleSpecies == "poecilia" & femaleSpecies == "gambusia")$spendingTime / 
                    subset(totalAssociationTime, maleSpecies == "poecilia")$spendingTime)

# t.test in SOP of G. affinis 
t.test(gamconfSOP, gamheterofSOP, paired = TRUE)

# t.test in SOP of P. reticulata 
t.test(pomconfSOP, pomheterofSOP, paired = TRUE)

# the mean and standrd deviation of SOP in P. reticulata males and G. affinis males
mean(gamconfSOP)
sd(gamconfSOP)
mean(gamheterofSOP)
sd(gamheterofSOP)
mean(pomconfSOP)
sd(pomconfSOP)
mean(pomheterofSOP)
sd(pomheterofSOP)
