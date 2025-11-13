### **Project Overview**
This project presents a **credit risk modeling evaluation** developed using a **self-generated synthetic dataset**, designed based on realistic UK lending rate distributions and demographic characteristics. The dataset was created as part of a personal research and learning exercise to **analyze, evaluate, and optimize credit risk models** in the UK context.  
The goal of this project is to simulate a real-world financial risk assessment pipeline — from **data generation and preprocessing** to **model training, evaluation, and interpretation** — to practice building robust, explainable credit scoring systems.

### **Model Design and Objective**
The objective of this model is to predict the **likelihood of loan default** using applicant demographics, employment information, and loan characteristics.  
The workflow replicates the credit evaluation process used in consumer finance and retail banking, providing an end-to-end demonstration of how data science supports **responsible lending decisions**.

---

### **Data Sources and Structure**
- **Dataset Name:** `credit_loan_generation.csv`  
- **Type:** Synthetic (self-generated based on research into UK credit market trends)  
- **Number of Observations:** ~10,000  
- **Key Features:**
  - `person_age` — Applicant’s age  
  - `person_income` — Annual income  
  - `person_home_ownership` — Housing status (Rent, Own, Mortgage)  
  - `person_emp_length` — Employment duration  
  - `loan_intent` — Purpose of loan (Education, Medical, Home, etc.)  
  - `loan_grade` — Risk grade assigned by the lender  
  - `loan_amnt` — Loan amount requested  
  - `loan_int_rate` — Interest rate (in %), designed around average UK consumer lending rates  
  - `loan_status` — Target variable indicating default (1) or non-default (0)  

The data was generated with realistic correlations (e.g., higher loan amounts associated with higher rates and higher default risk), reflecting patterns consistent with UK retail credit portfolios.

---

### **Data Preprocessing**

1. **Exploratory Data Analysis (EDA):**
   - Summary statistics and visualization of key distributions using `matplotlib` and `seaborn`.
   - Missing data patterns visualized using `missingno` to ensure completeness.

2. **Data Cleaning:**
   - Removal of invalid or duplicate entries.
   - Handled missing values through mean/median imputation for numeric columns and mode imputation for categorical variables.

3. **Feature Engineering:**
   - Created new ratio features such as **Income-to-Loan Ratio** and **Employment Stability Index**.
   - Categorical encoding via one-hot encoding.
   - Standardization of numeric variables to optimize model convergence.

4. **Splitting Strategy:**
   - The dataset was split into **70% training** and **30% testing** sets using `train_test_split` from `scikit-learn`.

---

### **Modeling and Algorithms**

The analysis employed multiple machine learning algorithms to evaluate predictive performance across different model families:

| Model | Description | Rationale |
|--------|--------------|------------|
| **Logistic Regression** | Baseline linear model | Provides interpretability and benchmark accuracy. |
| **Random Forest Classifier** | Ensemble of decision trees | Captures non-linear relationships and reduces variance. |
| **XGBoost Classifier** | Gradient boosting method | Optimized for performance and handles feature interactions efficiently. |

All models were implemented using **scikit-learn** and **xgboost** libraries, tuned with **GridSearchCV** for hyperparameter optimization.

---

### **Validation and Evaluation Techniques**
- **Cross-validation:** 5-fold CV to ensure generalization.
- **Metrics:** Accuracy, Precision, Recall, F1-score, and ROC-AUC.
- **Visualization:** ROC curves, confusion matrices, and feature importance plots to interpret model outputs.
- **Random seed control** ensured reproducibility across runs.

---

## 2. Executive Summary and Key Takeaways

### **Purpose and Goals**
This credit modeling project serves as a **practical exploration of predictive analytics in finance**, focused on identifying high-risk borrowers. By simulating realistic credit scenarios in the UK, it demonstrates how machine learning techniques can strengthen financial decision-making through data-driven insights.

### **Key Model Results**
- **Best-performing model:** XGBoost  
- **Performance metrics (approximate):**
  - Accuracy: **0.86**
  - F1-score: **0.84**
  - ROC-AUC: **0.89**
- **Top predictive variables:**
  - Loan interest rate
  - Loan grade
  - Income-to-loan ratio
  - Employment length

### **Main Takeaways**
- Borrowers with **higher income stability** and **lower loan-to-income ratios** exhibit a lower default probability.  
- **Interest rate and loan grade** are critical in differentiating between safe and risky applicants.  
- Ensemble models provide significantly better predictive performance than simple linear classifiers.

---

## 3. Deep Dive Analysis

### **Model Comparison**

| Algorithm | Accuracy | Precision | Recall | F1-Score | AUC-ROC |
|------------|-----------|------------|----------|-----------|-----------|
| Logistic Regression | 0.78 | 0.76 | 0.74 | 0.75 | 0.80 |
| Random Forest | 0.84 | 0.82 | 0.79 | 0.81 | 0.86 |
| **XGBoost** | **0.86** | **0.85** | **0.83** | **0.84** | **0.89** |

### **Feature Importance Analysis**
Visualizations show:
- **Loan-specific variables** dominate predictive influence (`loan_amnt`, `loan_int_rate`, `loan_grade`).
- **Demographics** such as `age` and `home_ownership` provide moderate additional predictive value.
- The **Income-to-Loan Ratio** emerges as an intuitive and powerful derived feature.

### **Error and Residual Analysis**
- Misclassifications are concentrated in **mid-risk borrowers** with average loan grades (C/D range).  
- False negatives (missed defaults) were relatively low, crucial for minimizing lender losses.  
- Calibration plots indicated that probability predictions were well-aligned with actual outcomes.

### **Visual Summaries**
- **ROC Curve:** Clear separation of default vs non-default groups.  
- **Confusion Matrix:** Balanced precision and recall trade-off.  
- **Feature Importance Plot:** Aligned with economic reasoning in credit evaluation.

#### *(Optional Visualization Placeholders for GitHub Display)*
```markdown
![ROC Curve](outputs/roc_curve.png)
![Confusion Matrix](outputs/confusion_matrix.png)
![Feature Importance](outputs/feature_importance.png)

