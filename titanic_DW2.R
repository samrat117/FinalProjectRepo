#Load the libraries
library(tidyr)
library(stringr)

#Read the file from local directory
titanic <- read.csv(file = 'titanic_original.csv',header = TRUE,na.strings = "")
titanic_tb <- tbl_df(titanic)
summary(titanic_tb)

#Port of embarkation
embarkation <- which(is.na(titanic_tb$embarked))
titanic_tb$embarked[embarkation] <- "S" 
summary(titanic_tb)

#Age
mean_age <- mean(titanic_tb$age,na.rm = TRUE)
mage <- which(is.na(titanic_tb$age))
titanic_tb$age[mage] <- mean_age
summary(titanic_tb)

#Lifeboat
tboat <- which(is.na(titanic_tb$boat))
titanic_tb$boat[tboat] <- NA 
summary(titanic_tb)

#Cabin
titanic_tb1 <- titanic_tb %>% 
  mutate(has_cabin_number = as.factor(if_else(!is.na(cabin),1,0)))
summary(titanic_tb1)

#View Final Data
View(titanic_tb1)