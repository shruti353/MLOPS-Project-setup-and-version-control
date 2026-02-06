# MLOPS-Project-setup-and-version-control

##  Project Overview
This project demonstrates an end-to-end **Machine Learning Operations (MLOps)** workflow implemented using **R**.  
The goal is to build, evaluate, and manage a machine learning model for classifying iris flower species using the Iris dataset.

The project focuses on:
- Reproducible ML workflows
- Model training and evaluation
- Model versioning and persistence
- Clear documentation and structure

---

##  Problem Statement
Given measurements of iris flowers:
- Sepal Length
- Sepal Width
- Petal Length
- Petal Width  

Predict the species of the flower:
- Setosa
- Versicolor
- Virginica

---

##  Technologies Used
- **Programming Language:** R  
- **IDE:** RStudio  
- **Libraries:**
  - caret
  - dplyr
  - ggplot2
  - e1071
  - readr

---

---

##  MLOps Workflow

1. **Data Ingestion**
   - Load dataset and inspect structure
2. **Data Preprocessing**
   - Handle missing values
   - Feature preparation
3. **Model Training**
   - Train a classification model using Random Forest
4. **Model Evaluation**
   - Accuracy, confusion matrix
5. **Model Versioning**
   - Save trained model using `.rds`
6. **Reproducibility**
   - Script-based pipeline

---

##  Model Used
- **Algorithm:** Random Forest
- **Reason:** Robust, handles multi-class classification well, minimal tuning required

---

##  Evaluation Metrics
- Accuracy
- Confusion Matrix

---

##  How to Run the Project

1. Clone the repository
2. Open the project in RStudio
3. Run:
   
source("main.R")

Future Enhancements

Add MLflow integration

Automated retraining

CI/CD pipeline

mlops-r/
│
├── data/
│   └── iris-processed.csv        # Preprocessed dataset
│
├── src/
│   ├── validate.R                # Data validation & feature engineering
│   └── train.R                   # Model training & comparison
│
├── api/
│   └── plumber.R                 # REST API for model deployment
│
├── artifacts/
│   ├── model.rds                 # Trained model artifact
│   └── scaler.rds                # Feature scaler
│
├── mlops-iris-report.Rmd         # RPubs report (R Markdown)
├── README.md                     # Project documentation
└── mlops-r.Rproj                 # RStudio project file

---

##  Models Implemented

The following models were trained and evaluated:

- Logistic Regression  
- Random Forest  
- Decision Tree  
- Gaussian Naïve Bayes  

**Model Selection Criterion:** Recall  
**Selected Model:** Logistic Regression  

---

##  Evaluation Metrics

Models were evaluated using:
- Accuracy  
- Precision  
- Recall  

Logistic Regression achieved the best overall performance and was selected
for deployment.

---

##  Model Deployment

The trained model is deployed as a REST API using the **Plumber** framework.

### Available Endpoints
- `/health` – Health check
- `/predict` – Single sample prediction
- `/predict-csv` – Batch prediction using CSV upload

### Sample Request

http://127.0.0.1:7860/predict?sepal_length=5&sepal_width=3.5&petal_length=1.2&petal_width=0.4

### Sample Response
```json
{
  "success": true,
  "prediction": "setosa"
}


 Documentation (RPubs)
The complete project report with:


Code


Outputs


Interpretations


Results


is published on RPubs:
🔗 RPubs Link:
https://rpubs.com/na_adarshpritam/1394035

Testing & Validation
The project validates:


Dataset schema integrity


Pipeline reproducibility


Model performance thresholds


Failure handling


Deployment verification



 Tools & Technologies


R, RStudio


caret, tidyverse, randomForest, e1071


Plumber (API deployment)


Git & GitHub


RPubs



## Academic Context


Program: M.Sc. Data Science


Course: Machine Learning Operations (MLOps)


Institution: Alliance University, Bengaluru



👥 Authors


Shruti Thakkar


Adarsh Pritam


Amrutha Prasad



 References


UCI Machine Learning Repository – Iris Dataset


R Project for Statistical Computing


caret Package Documentation


Plumber Package Documentation



---

Model monitoring
