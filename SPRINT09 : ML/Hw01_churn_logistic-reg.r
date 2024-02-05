library(tidyverse)
library(caret)
df <- read.csv("churn.csv")
head(df)

##1 split data
train_test_split <- function(data,size=0.8){
  set.seed(42)
  n <- nrow(data)
  train_id <- sample(1:n, size*n)
  train_df <- data[train_id, ]
  test_df <- data[-train_id, ]
  return(list(train_df,test_df))
}
prep_df <- train_test_split(df, size=0.8)

##2 train data 
ctrl <- trainControl(method="cv",
                     number= 5)
model <- train(churn ~ totaldaycharge+totalnightcharge+totalevecharge+numbercustomerservicecalls, 
               data= prep_df[[1]],
               method = "glm",
               trControl = ctrl)
##3 score data
pred_churn <- predict(model, newdata = prep_df[[2]])

##4 evaluate model
result1 <- confusionMatrix(pred_churn, factor(prep_df[[2]]$churn),mode = "prec_recall", positive = "Yes")
