library(readr)
library(dplyr)
source("src/validate.R")

model <- readRDS("artifacts/model.rds")

predict_single <- function(features_list) {
  
  df <- as.data.frame(features_list)
  
  if (!"class" %in% colnames(df)) {
    df$class <- "setosa"
  }
  
  validate_original_schema(df)
  df <- create_features(df)
  validate_feature_schema(df)
  
  df$class <- as.factor(df$class)
  
  prediction <- predict(model, df)
  
  return(prediction$.pred_class)
}

