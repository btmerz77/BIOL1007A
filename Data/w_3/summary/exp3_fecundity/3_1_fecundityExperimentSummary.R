# -----------------------------------------------------------------------------------------
# Exp, 3 The fecundity of P. reticulata females and G. affinis females
# (gravid female alone as a control,
#  housed with P. reticulata male or G. affnis male)
# 
# title: 3_1_fecundityAnalysis
# Date：2019/01/18, modification for submitted journal
# -----------------------------------------------------------------------------------------
# set the directory and data file
releaseData <- read.csv("exp3_fecundityDataset.csv")

# Extract the record of reproduct female
reproductDataset <- subset(releaseData, larvaeNumber > 0) 

# the summary of experiment
# -----------------------------------------------------------------------------------
totalNum <- aggregate(releaseDay ~ maleSpecies * femaleSpecies, data = releaseData, length) # replicates of each treatment
reproductNum <- aggregate(releaseDay ~ maleSpecies * femaleSpecies, data = reproductDataset, length) # the number of female reproduction
meanLarvaeNumber <- aggregate(larvaeNumber ~ maleSpecies * femaleSpecies, data = reproductDataset, mean) # mean larvae number
minLarvaeNumber <- aggregate(larvaeNumber ~ maleSpecies * femaleSpecies, data = reproductDataset, min) # min larvae number
maxLarvaeNumber <- aggregate(larvaeNumber ~ maleSpecies * femaleSpecies, data = reproductDataset, max) # max larvae number
meanFemaleSL <- aggregate(femaleSL ~ maleSpecies * femaleSpecies, data = reproductDataset, mean) # mean standard length of reproduct female
sdFemaleSL <- aggregate(femaleSL ~ maleSpecies * femaleSpecies, data = reproductDataset, sd) # standard deviation of reproduct female

data.frame(totalNum = totalNum[,3],
           reproductNum = reproductNum[,3],
           meanLarvaeNumber = meanLarvaeNumber[,3],
           minLarvaeNumber = minLarvaeNumber[,3],
           maxLarvaeNumber = maxLarvaeNumber[,3],
           meanFemaleSL = meanFemaleSL[,3],
           sdFemaleSL = sdFemaleSL[,3]
           )

# -----------------------------------------------------------------------------------
# poisson regression for the fecundity
# analysis were conducted P. reticulata females and G. affinis females, sepalately
# 
# list of explanatory variable
#  releaseDay: The day female released fry
#  femaleSL: Standard length of female
#  malesSpecies(control, P. reticulata male, G. affinis male)
# -----------------------------------------------------------------------------------
# Table. 3
# GLM for P. reticulata females
poFData <- subset(releaseData, femaleSpecies == "poecilia")
model <- glm(releaseDay ~  femaleSL + maleSpecies, data = poFData, family = poisson)
summary(model)

poFData <- subset(releaseData, femaleSpecies == "poecilia")
model <- glm(larvaeNumber ~ releaseDay + femaleSL + maleSpecies, data = poFData, family = poisson)
summary(model)

# GLM for G. affinis females
gaFData <- subset(releaseData, femaleSpecies == "gambusia")
model <- glm(releaseDay ~  femaleSL + maleSpecies, data = gaFData, family = poisson)
summary(model)

model <- glm(larvaeNumber ~ releaseDay + femaleSL + maleSpecies, data = gaFData, family = poisson)
summary(model)

# ------------------------------------------------------------------------------------
# Figure 3. Size-fecundity relationship in P. reticulata female and G. affinis female
# ------------------------------------------------------------------------------------
par(mfrow = c(2,2))
# result of P. reticulata females
plot(poFData$femaleSL, log10(poFData$larvaeNumber / poFData$releaseDay), pch = as.numeric(poFData$maleSpecies),
     xlim = c(20, 40), ylim = c(-2, 2), main = "P. reticulata female", las = 1,
     xlab = "Female standard length (mm)", ylab = "Log10 fecundity rate (offspring / day)")
model <- glm(larvaeNumber ~ releaseDay * femaleSL + maleSpecies, data = poFData, family = poisson)
sampleSL <- seq(15, 50, by = 0.1)
maleTagControl <- rep("control", length(sampleSL))
maleTagGa <- rep("gambusia", length(sampleSL))
maleTagPo <- rep("poecilia", length(sampleSL))

# drawing the size-fecundity relationship
samlpleDay <- rep(round(mean(poFData$releaseDay)), length(sampleSL))
predictControl <- predict(model, newdata = list(femaleSL = sampleSL, maleSpecies = maleTagControl, releaseDay = samlpleDay), type = "response")
predictPo <- predict(model, newdata = list(femaleSL = sampleSL, maleSpecies = maleTagPo, releaseDay = samlpleDay), type = "response")
predictGa <- predict(model, newdata = list(femaleSL = sampleSL, maleSpecies = maleTagGa, releaseDay = samlpleDay), type = "response")
lines(sampleSL, log10(predictControl/mean(poFData$releaseDay)))
lines(sampleSL, log10(predictGa/mean(poFData$releaseDay)), lty = "dashed")
lines(sampleSL, log10(predictPo/mean(poFData$releaseDay)), lty = "dotted")

# result of G. affinis females
plot(gaFData$femaleSL, log10(gaFData$larvaeNumber / gaFData$releaseDay), pch = as.numeric(gaFData$maleSpecies),
     xlim = c(20, 40), ylim = c(-2, 2), main = "G. affinis female", las = 1,
     xlab = "Female standard length (mm)", ylab = "Log10 fecundity rate (offspring / day)")
model <- glm(larvaeNumber ~ releaseDay * femaleSL + maleSpecies, data = gaFData, family = poisson)
sampleSL <- seq(15, 50, by = 0.1)
maleTagControl <- rep("control", length(sampleSL))
maleTagGa <- rep("gambusia", length(sampleSL))
maleTagPo <- rep("poecilia", length(sampleSL))
samlpleDay <- rep(round(mean(gaFData$releaseDay)), length(sampleSL))
predictControl <- predict(model, newdata = list(femaleSL = sampleSL, maleSpecies = maleTagControl, releaseDay = samlpleDay), type = "response")
predictPo <- predict(model, newdata = list(femaleSL = sampleSL, maleSpecies = maleTagPo, releaseDay = samlpleDay), type = "response")
predictGa <- predict(model, newdata = list(femaleSL = sampleSL, maleSpecies = maleTagGa, releaseDay = samlpleDay), type = "response")
lines(sampleSL, log10(predictControl/mean(gaFData$releaseDay)))
lines(sampleSL, log10(predictGa/mean(gaFData$releaseDay)), lty = "dashed")
lines(sampleSL, log10(predictPo/mean(gaFData$releaseDay)), lty = "dotted")
legend("topright", legend = levels(gaFData$maleSpecies), pch = c(1, 2, 3), bty = "n", cex = 1.2)

