library(caret)
library(tidyverse)
library(nnet)
library(randomForest)
library(rpart)
library(e1071)

# ---------------------------
# Load data
# ---------------------------
df <- read.csv("data/iris-processed.csv")
df$class <- as.factor(df$class)

# ---------------------------
# Feature Engineering (ONE SOURCE OF TRUTH)
# ---------------------------
feature_engineering <- function(df) {
  data.frame(
    petal_to_sepal_length = df$petal_length / df$sepal_length,
    petal_to_sepal_width  = df$petal_width / df$sepal_width,
    petal_length = df$petal_length,
    petal_width  = df$petal_width,
    sepal_ratio  = df$sepal_length / df$sepal_width,
    class = df$class
  )
}

df_fe <- feature_engineering(df)

# ---------------------------
# Train / Test split
# ---------------------------
set.seed(66)
idx <- createDataPartition(df_fe$class, p = 0.8, list = FALSE)
train_df <- df_fe[idx, ]
test_df  <- df_fe[-idx, ]

# ---------------------------
# Scaling (ONLY engineered features)
# ---------------------------
preproc <- preProcess(train_df[, -6], method = c("center", "scale"))
x_train <- predict(preproc, train_df[, -6])
x_test  <- predict(preproc, test_df[, -6])

y_train <- train_df$class
y_test  <- test_df$class

# ---------------------------
# Train control
# ---------------------------
ctrl <- trainControl(
  method = "cv",
  number = 5,
  classProbs = TRUE
)

# ---------------------------
# Models to compare
# ---------------------------
models <- list(
  LogisticRegression = "multinom",
  RandomForest       = "rf",
  DecisionTree       = "rpart",
  NaiveBayes         = "nb"
)

results <- list()

# ---------------------------
# Train & evaluate
# ---------------------------
for (model_name in names(models)) {
  
  cat("\n==============================\n")
  cat("Training:", model_name, "\n")
  cat("==============================\n")
  
  model <- train(
    x = x_train,
    y = y_train,
    method = models[[model_name]],
    trControl = ctrl
  )
  
  preds <- predict(model, x_test)
  preds <- factor(preds, levels = levels(y_test))
  
  cm <- confusionMatrix(preds, y_test)
  
  metrics <- list(
    accuracy  = as.numeric(cm$overall["Accuracy"]),
    recall    = mean(cm$byClass[, "Recall"]),
    precision = mean(cm$byClass[, "Precision"])
  )
  
  print(metrics)
  
  results[[model_name]] <- list(
    model = model,
    metrics = metrics
  )
}

# ---------------------------
# Select best model (Recall)
# ---------------------------
best_model_name <- names(results)[which.max(
  sapply(results, function(x) x$metrics$recall)
)]

best_model <- results[[best_model_name]]$model

# ---------------------------
# Save artifacts (IMPORTANT)
# ---------------------------
dir.create("artifacts", showWarnings = FALSE)

saveRDS(best_model, "artifacts/model.rds")
saveRDS(preproc, "artifacts/scaler.rds")
saveRDS(colnames(x_train), "artifacts/feature_names.rds")

cat("\n=====================================\n")
cat("Best Model Selected:", best_model_name, "\n")
cat("Artifacts saved in /artifacts\n")
cat("=====================================\n")
