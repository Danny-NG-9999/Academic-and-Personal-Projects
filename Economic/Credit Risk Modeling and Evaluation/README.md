## **Project Overview and Model Objective**
This project presents an **end-to-end credit risk modeling framework** developed to simulate the process of assessing borrower default risk within the context of the UK consumer lending market. The analysis leverages a **self-generated synthetic dataset**, constructed based on real-world distributions of lending rates, borrower demographics, and income profiles observed across UK financial institutions.  

The project was designed as a **practical research exercise** to explore and evaluate predictive modeling techniques used in credit scoring. The primary objective is to develop, validate, and interpret a model capable of estimating the **probability of loan default**, integrating best practices from both data science and applied risk analytics.  

From a methodological standpoint, this project mirrors a professional credit modeling workflow — encompassing **data preparation, feature engineering, model training, validation, interpretability, and business insight generation**. The approach reflects standards used by financial analysts and data scientists in banking, fintech, and credit risk management environments.  

Key goals include:
- Simulating realistic borrower and loan profiles for UK-based credit products.
- Evaluating multiple supervised learning algorithms for default prediction.
- Quantifying the predictive contribution of financial and demographic features.
- Translating model outcomes into actionable insights for risk-based decision-making.

This model serves both as a **technical demonstration** of machine learning in financial analytics and as a **learning platform** to practice data-driven evaluation of creditworthiness.

---

### **Data Sources and Structure**
- **Dataset Name:** `credit_loan_generation.csv`  
- **Type:** Synthetic (self-generated based on UK lending research and risk structure)  
- **Number of Observations:** ~10,000  
- **Key Features:**
  - `person_age` — Applicant’s age  
  - `person_income` — Annual income  
  - `person_home_ownership` — Housing status (Rent, Own, Mortgage)  
  - `person_emp_length` — Employment duration in years  
  - `loan_intent` — Purpose of loan (Education, Medical, Home, etc.)  
  - `loan_grade` — Risk grade assigned by the lender  
  - `loan_amnt` — Loan amount requested  
  - `loan_int_rate` — Interest rate (%) reflecting UK consumer credit trends  
  - `loan_status` — Target variable (1 = Default, 0 = Non-default)  

The dataset was designed with realistic dependencies — for example, higher interest rates and loan amounts correlate with increased default probability, while income and employment stability contribute negatively to risk.  

---

### **Data Preprocessing**

1. **Exploratory Data Analysis (EDA):**
   - Descriptive statistics and data visualization using `matplotlib` and `seaborn`.
   - Missing data inspection using `missingno` to identify potential data quality issues.

2. **Data Cleaning:**
   - Removal of duplicates and inconsistent records.
   - Missing value imputation (mean for continuous, mode for categorical variables).

3. **Feature Engineering:**
   - Derived metrics such as **Income-to-Loan Ratio** and **Employment Stability Index**.
   - One-hot encoding for categorical variables.
   - Standardization of numeric variables for optimized model convergence.

4. **Data Partitioning:**
   - **70/30 train-test split** using `train_test_split` from `scikit-learn`.

---

### **Modeling and Algorithms**

Multiple supervised learning algorithms were implemented to benchmark predictive performance across linear and ensemble approaches:

| Model | Description | Rationale |
|--------|--------------|------------|
| **Logistic Regression** | Baseline interpretable model | Serves as a benchmark for understanding linear feature relationships. |
| **Random Forest Classifier** | Tree-based ensemble model | Captures non-linear feature interactions and reduces variance. |
| **XGBoost Classifier** | Gradient boosting algorithm | Delivers superior performance and handles feature heterogeneity efficiently. |

All models were trained and tuned using **GridSearchCV** to identify optimal hyperparameters. The **XGBoost classifier** ultimately achieved the strongest performance across all key evaluation metrics.

---

### **Validation and Evaluation**
- **Cross-Validation:** 5-fold cross-validation for robust generalization.  
- **Performance Metrics:** Accuracy, Precision, Recall, F1-Score, and ROC-AUC.  
- **Visualization:** ROC curves, confusion matrices, and feature importance charts to assess discrimination power and interpretability.  
- **Reproducibility:** Fixed random seeds were used throughout to ensure consistent results.  

---

## 2. Executive Summary and Key Takeaways

### **Purpose and Goals**
This credit modeling project demonstrates how machine learning can be applied to **predict borrower default risk**, simulating a realistic lending environment within the UK credit market.  
It illustrates a complete analytical pipeline from **data synthesis and model development** to **evaluation and business insight extraction**, aligned with industry-standard practices in credit analytics.

### **Key Results**
- **Top-performing model:** XGBoost  
- **Performance Highlights:**
  - Accuracy: **0.86**
  - F1-Score: **0.84**
  - ROC-AUC: **0.89**
- **Most influential features:**
  - Loan interest rate
  - Loan grade
  - Income-to-loan ratio
  - Employment length

### **Main Takeaways**
- Borrowers with higher income relative to loan size show lower default risk.  
- Higher interest rates and risk grades are strongly associated with default probability.  
- Ensemble models outperform linear models in capturing non-linear risk relationships.  
- The feature importance structure aligns with financial intuition, validating model soundness.

---

## 3. Deep Dive Analysis

### **Model Comparison**

| Algorithm | Accuracy | Precision | Recall | F1-Score | AUC-ROC |
|------------|-----------|------------|----------|-----------|-----------|
| Logistic Regression | 0.78 | 0.76 | 0.74 | 0.75 | 0.80 |
| Random Forest | 0.84 | 0.82 | 0.79 | 0.81 | 0.86 |
| **XGBoost** | **0.86** | **0.85** | **0.83** | **0.84** | **0.89** |

### **Feature Importance Analysis**
- Loan-specific attributes (`loan_amnt`, `loan_int_rate`, `loan_grade`) drive most predictive power.  
- Demographic and employment features offer complementary explanatory value.  
- Derived features such as **Income-to-Loan Ratio** add interpretability and enhance performance.

### **Error and Residual Analysis**
- Most misclassifications occur among **medium-risk borrowers** (loan grades C–D).  
- False negatives (defaults predicted as safe) remain low — critical for minimizing exposure.  
- Probability calibration analysis confirms good alignment between predicted and actual default rates.

### **Visualizations**

```markdown
![ROC Curve](outputs/roc_curve.png)
![Confusion Matrix](outputs/confusion_matrix.png)
![Feature Importance](outputs/feature_importance.png)
