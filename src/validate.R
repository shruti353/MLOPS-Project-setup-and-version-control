library(dplyr)

validate_original_schema <- function(df) {
  
  required_cols <- c(
    "sepal_length",
    "sepal_width",
    "petal_length",
    "petal_width",
    "class"
  )
  
  if (!all(required_cols %in% colnames(df))) {
    stop("Missing required columns")
  }
  
  if (any(df$sepal_length <= 0) ||
      any(df$sepal_width <= 0) ||
      any(df$petal_length <= 0) ||
      any(df$petal_width <= 0)) {
    stop("All numeric values must be > 0")
  }
  
  allowed_classes <- c("setosa", "versicolor", "virginica")
  
  if (!all(df$class %in% allowed_classes)) {
    stop("Invalid class labels")
  }
}

create_features <- function(df) {
  
  df_features <- df %>%
    mutate(
      petal_to_sepal_length = petal_length / sepal_length,
      petal_to_sepal_width  = petal_width / sepal_width,
      sepal_ratio           = sepal_length / sepal_width
    ) %>%
    select(
      petal_to_sepal_length,
      petal_to_sepal_width,
      petal_length,
      petal_width,
      sepal_ratio,
      class
    )
  
  return(df_features)
}

validate_feature_schema <- function(df) {
  
  required_cols <- c(
    "petal_to_sepal_length",
    "petal_to_sepal_width",
    "petal_length",
    "petal_width",
    "sepal_ratio",
    "class"
  )
  
  if (!all(required_cols %in% colnames(df))) {
    stop("Feature schema mismatch")
  }
}

