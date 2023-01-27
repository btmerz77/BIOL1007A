# --------------------------------------------------------------------------------------------------------------
# Title: Alternative reproductive tactics in male freshwater fish influence the accuracy of species recognition
# 
# Principal investigators:
#  Shingo Fujimoto, Graduate School of Medicine, University of the Ryukyus, Okinawa 903-0125, Japan, fujimoto.s@outlook.com
#  Kaori Tsurui-Sato, Faculty of Agriculture, University of the Ryukyus, 1 Senbaru, Nishihara, Okinawa 903-0213, Japan, tsuruikaori@gmail.com
#
# Date of Data collection: experiment 1 and 2, 2016/06/24-2016/07/14, experiment 3, 2016/03-2016/10
# Geographic location of data collection: Okinawa prefecture, Japan
# Keywords: mate recognition, male mate choice, reproductive interference, Fisherian process, Poeciliidae
#
# --------------------------------------------------------------------------------------------------------------
# Abstract
# --------------------------------------------------------------------------------------------------------------
Sexual conflict can result in coercive mating. Because males bear low costs of heterospecific mating,
coercive males may engage in misdirected mating attempts toward heterospecific females. In contrast,
sexual selection through consensual mate choice can cause mate recognition cues among species to diverge,
leading to more accurate species recognition. Some species show both coercive mating and
mate choice–associated courtship behaviors as male alternative reproductive tactics. We hypothesized that
if the selection pressures on each tactic differ, then the accuracy of species recognition would also change depending on
the mating tactic adopted. We tested this hypothesis in the guppy (Poecilia reticulata) and mosquitofish (Gambusia affinis)
by a series of choice experiments. Poecilia reticulata and G. affinis males both showed imperfect species recognition
and directed all components of mating behavior towards heterospecific females. They tended to direct courtship displays
more frequently towards conspecific than heterospecific females. With male P. reticulata, however,
accurate species recognition disappeared when they attempted coercive copulation:
they directed coercions more frequently towards heterospecific females. We also found that
heterospecific sexual interaction had little effect on the fecundity of gravid females,
which suggests that pre-pregnancy interactions likely underpin the exclusion of G. affinis by P. reticulata in our region.

# --------------------------------------------------------------------------------------------------------------
# Data and file overview
# --------------------------------------------------------------------------------------------------------------

exp1_maleMateChoice ------ exp1_maleMateChoiceDataset.csv (2019/07/23): Male association preference for con- and heterospecific females.
                       |-- exp1_1_summaryResult.R: Average, Standard deviation, and paired t test for male association preference.
                       |-- exp1_2_dirichletReg.R: Effect of body size estimated using Dirichlet regression

exp2_matingBehavior ------ maleIDandBehavior.csv (2019/05/04): Frequency of mating behaviors for con- and heterospecific females
                       |-- 2_1_behaviorFreqeuncy_overdispersion.R: Overdispersion test for each behavior (Table S1)
                       |-- 2_2_Fig2_behaviorFreqeuncy.R: Boxplot for each behavior
                       |-- 2_3_testEachBehavior.R: Wald tests for differences in behavioral frequency between male and female combinations
                       |-- FigS4_behaviorTransitionNetwork.R: Illustrate the behavior transition network

exp3_fecundity ------ exp3_fecundityDataset.csv (2019/01/18): Male effect on female fecundity
                  |-- 3_1_fecundityExperimentSummary.R: Summary of experiment (Table S2) 
                  |-- 3_1_fecundityExperimentSummary.R: Estimation of size-fecundity relationship using Poisson regression

# --------------------------------------------------------------------------------------------------------------
# Sharing and access information
# --------------------------------------------------------------------------------------------------------------
Attribution License: ODC-By

Users are free to use the database and its content in new and different ways,
provided they provide attribution to the source of the data and/or the database.

# --------------------------------------------------------------------------------------------------------------
# Methodological information: (reference)
# --------------------------------------------------------------------------------------------------------------
Description of methods for data collection or generation: https://doi.org/10.1002/ece3.7267
The R scripts were written and performed using R version 3.3.2 for Windows (R Core Team, 2016, www.r-project.org/).

# --------------------------------------------------------------------------------------------------------------
# Data-specific information
# --------------------------------------------------------------------------------------------------------------
exp1_maleMateChoiceDataset.csv (2019/07/23)
                       |-- femaleSpecies: The category is where males spent the time.
                       |-- maleSpecies: Male species used in the trial.
                       |-- maleID: Male individual identifier used in the trial.
                       |-- treatment: In the "Acclimation", we showed only conspecific female, while in the "preference", we showed conspecific and heterospecific females.
                       |-- spendingTime: Total time spent in the area, the unit is second.
                       |-- maleWeight: Male wet body weight, the unit is gram.
                       |-- averageFemaleWeight: average female body weight, the unit is gram.
                       |-- femaleWeight_poMinusga: female weight difference defined Poecilia female minus Gambusia female, the unit is gram.
                       |-- po_femalePerga_female: female weight ratio defined by dividing Poecilia female by Gambusia female.
                       |-- exclude: Male individuals excluded from statistical analysis, 1: exlude; 0:include.

exp2_matingBehavior ------ maleIDandBehavior.csv (2019/05/04)
                       |-- maleID:  Male individual identifier used in the experiment.
                       |-- male_species: Male species used in the trial.
                       |-- female_species: Female species used in the trial.
                       |-- combination: Conspecific or Heterospecific pair in the trial.
                       |-- follow: The total counts of "follow" behavior in 20 minutes.
                       |-- gonopodial_swing: The total counts of "gonopodial swing" behavior in 20 minutes.
                       |-- gonopodial_thrust: The total counts of "gonopodial thrust" behavior in 20 minutes.
                       |-- jolt:  The total counts of "jolts" behavior in 20 minutes.
                       |-- sigmoid_display:  The total counts of "sigmoid display" behavior in 20 minutes.
                       |-- male_SL_mm: Male standard length, the unit is mm.
                       |-- female_SL_mm:  Female standard length, the unit is mm.
                       |-- male_BW: Male body weight, the unit is gram.
                       |-- female_BW: Female body weight, the unit is gram.

exp3_fecundity ------ exp3_fecundityDataset.csv (2019/01/18)
                  |-- experiment_No: Trial identifier used in the experiment.
                  |-- femaleSpecies: Female species used in the trial.
                  |-- maleSpecies: Male species used in the trial. "control" means absence of male.
                  |-- sex: the sex of males in the trial.
                  |-- releaseDay: On the date of giving birth, we continued for up to 32 days.
                  |-- larvaeNumber: The number of offspring produced by gravid P. reticulata and G. affinis females
                  |-- femaleSL: Female standard length, the unit is mm.
