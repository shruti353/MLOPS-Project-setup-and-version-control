# Load libraries
library(dplyr)
library(ggplot2)
library(caret)
library(naniar)
library(randomForest)
library(validate)

# Load raw dataset
raw_data <- iris %>%
  rename(
    sepal_length = Sepal.Length,
    sepal_width  = Sepal.Width,
    petal_length = Petal.Length,
    petal_width  = Petal.Width,
    class = Species
  ) %>%
  mutate(class = tolower(as.character(class)))

cat("Libraries loaded and raw_data initialized.\n")

