# Load the required libraries used here
library(ISLR)
library(ggplot2)
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)

#check the data
head(College)

#assiging College to dcf dataframe
dcf <- College

#exploratory Data analysis
ggplot(dcf, aes(dcf$Room.Board, dcf$Grad.Rate)) +
  geom_point(aes(col=Private), size=2)

#histogram
ggplot(dcf, aes(dcf$F.Undergrad)) +
  geom_histogram(aes(fill=Private), col='black', bins=50, alpha=0.5) +
  theme_bw()

ggplot(dcf, aes(dcf$Grad.Rate)) + 
  geom_histogram(aes(fill=Private), col='black', bins=50, alpha=0.5) +
  theme_bw()

#Outlier data, 125% is more than 100
subset(dcf, dcf$Grad.Rate > 100)
dcf['Cazenovia College', 'Grad.Rate'] <- 100
subset(dcf, dcf$Grad.Rate > 100)
# Cazenovia College has an outliar with graduation rate more than 125%

#Split data into train, test
set.seed(101)

sample <- sample.split(dcf$Private, SplitRatio = 0.70)
train <- subset(dcf, sample == T)
test <- subset(dcf, sample == F)

#decision Tree
tree <- rpart(Private ~ ., method = 'class', data = train)

#Intuitive Prediction
tree.preds <- predict(tree,test)
head(tree.preds)

#creating a confusion matrix
tree.preds <- as.data.frame(tree.preds)


joiner <- function(x){
  if (x >= 0.5){
    return('Yes')
  } else {
    return('No')
  }
}

tree.preds$Private <- sapply(tree.preds$Yes, joiner)

print(head(tree.preds))

#creating a confusion matrix
table(tree.preds$Private, test$Private)

#plot the decision
prp(tree)

## Using randomForest
#decision Tree
rf.model <- randomForest(Private ~ ., data = train, importance = TRUE)

#Checking the importance of Confusion and importance
rf.model$confusion

#Intuitive Prediction
rf.preds <- predict(rf.model, test)
table(rf.preds, test$Private)

