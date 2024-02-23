## decision tree , random forest , Ridge & Lasso Regression
library(tidyverse)
library(caret)
library(mlbench)

## load data
data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes
# check null 
mean(complete.cases(df))

## train model rpart
## recursive partitioning (decision tree)
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE,
  classProbs = TRUE, # we can change threshold 0.5
  summaryFunction = twoClassSummary
)

tree_model <- train(
  diabetes ~ glucose + pressure + insulin + mass + age,
  data = df,
  method = "rpart",
  metric = "ROC",
  trControl = ctrl
)

## prediction
predict(tree_model, df, type = "prob")[1:10, ]

## change threshold
probs <- predict(tree_model, df, type = "prob")

p_class <- ifelse(probs$pos >= 0.5, "pos", "neg")

table(df$diabetes, p_class)

## random forest (bagging)
## RPART
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE
)

tree_model <- train(
  diabetes ~ .,
  data = df,
  method = "rpart",
  metric = "Accuracy",
  trControl = ctrl
)

## Random Forest
rf_model <- train(
  diabetes ~ .,
  data = df,
  method = "rf", 
  metric = "Accuracy",
  tuneGrid = data.frame(mtry = c(2,3,4)),
  trControl = ctrl
)

## RF > Decision Tree 95%


## Ridge vs. Lasso Regression
## Regularization 
## Ridge => beta will be lower, but not zero
## Lasso => beta can be zero (feature selection)
##alpha=1 Lasso , alpha=0 Ridge
glmnet_model <- train(
  diabetes ~ .,
  data = df,
  method = "glmnet", 
  metric = "Accuracy",
  tuneGrid = expand.grid(
    alpha = 0:1,
    lambda = c(0.004, 0.04, 0.08)
  ),
  trControl = ctrl
)

## save model
##saveRDS(glmnet_model, "ridge_lasso_reg.RDS")
## call to use
##model <- readRDS("ridge_lasso_reg.RDS")
