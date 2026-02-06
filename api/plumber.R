library(plumber)
library(here)

# ---------------------------
# Load artifacts
# ---------------------------
model         <- readRDS(here("artifacts", "model.rds"))
scaler        <- readRDS(here("artifacts", "scaler.rds"))
feature_names <- readRDS(here("artifacts", "feature_names.rds"))

#* @apiTitle Iris Classification API (R + Plumber)

#* Health check
#* @get /health
function() {
  list(status = "ok")
}

#* Predict a single sample
#* @post /predict
function(sepal_length,
         sepal_width,
         petal_length,
         petal_width) {
  
  tryCatch({
    
    # Convert inputs
    sepal_length <- as.numeric(sepal_length)
    sepal_width  <- as.numeric(sepal_width)
    petal_length <- as.numeric(petal_length)
    petal_width  <- as.numeric(petal_width)
    
    if (any(is.na(c(sepal_length, sepal_width, petal_length, petal_width))))
      stop("All inputs must be numeric")
    
    if (sepal_length <= 0 || sepal_width <= 0)
      stop("sepal_length and sepal_width must be > 0")
    
    # Feature engineering (IDENTICAL to training)
    input_df <- data.frame(
      petal_to_sepal_length = petal_length / sepal_length,
      petal_to_sepal_width  = petal_width / sepal_width,
      petal_length = petal_length,
      petal_width  = petal_width,
      sepal_ratio  = sepal_length / sepal_width
    )
    
    # Enforce schema
    input_df <- input_df[, feature_names, drop = FALSE]
    
    # Scale + predict
    input_scaled <- predict(scaler, input_df)
    pred <- predict(model, input_scaled)
    
    list(
      success = TRUE,
      prediction = as.character(pred)
    )
    
  }, error = function(e) {
    list(
      success = FALSE,
      error = e$message
    )
  })
}

#* Batch prediction using CSV
#* @post /predict-csv
function(file) {
  
  tryCatch({
    
    df <- read.csv(file$datapath)
    
    required_cols <- c(
      "sepal_length",
      "sepal_width",
      "petal_length",
      "petal_width"
    )
    
    missing <- setdiff(required_cols, colnames(df))
    if (length(missing) > 0)
      stop(paste("Missing columns:", paste(missing, collapse = ", ")))
    
    features <- data.frame(
      petal_to_sepal_length = df$petal_length / df$sepal_length,
      petal_to_sepal_width  = df$petal_width / df$sepal_width,
      petal_length = df$petal_length,
      petal_width  = df$petal_width,
      sepal_ratio  = df$sepal_length / df$sepal_width
    )
    
    features <- features[, feature_names, drop = FALSE]
    features_scaled <- predict(scaler, features)
    
    df$prediction <- predict(model, features_scaled)
    df
    
  }, error = function(e) {
    list(success = FALSE, error = e$message)
  })
}
