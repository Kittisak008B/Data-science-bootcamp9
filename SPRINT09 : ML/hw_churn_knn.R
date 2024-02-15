## build ML to classify customer churn 
library(tidyverse)
library(caret)
library(mlbench)
library(MLmetrics)
df <- read.csv("churn.csv")

## explore dataset
glimpse(df)
## no missing value
mean(complete.cases(df))

## select variables
df_starter <- df %>%
  select(3,4,5,6,8,9,11,12,14,15,17,18,churn)

## 1. split data
set.seed(42)
n <- nrow(df_starter)
id <- sample(1:n, size = 0.8*n)
train_df <- df_starter[id, ]
test_df <- df_starter[-id, ]

## 2. train 
set.seed(42)

## use for Recall, Precision, F1, AUC
ctrl <- trainControl(method="cv", 
                     number=5,
                     ## pr = precision + recall
                     summaryFunction = prSummary,
                     classProbs = TRUE)

knn_model <- train(churn ~ .,
                   data = train_df,
                   method = "knn",
                   metric = "Recall",
                   trControl = ctrl)
print(knn_model)
## 3. score
p <- predict(knn_model, newdata = test_df)

## 4. evaluate
mean(p == test_df$churn)

## confusion matrix
confusionMatrix(p, 
                factor(test_df$churn),
                positive="Yes",
                mode="prec_recall")















