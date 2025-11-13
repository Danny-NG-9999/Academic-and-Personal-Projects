## **Project Overview and Model Objective**
This project is a **working credit risk modeling file** created as part of my personal learning and practice in predictive analytics. The dataset used in this analysis is **self-generated**, designed to replicate realistic UK credit market conditions based on publicly available research on lending rates, income distributions, and borrower demographics.  

The main goal of this project is to **understand, apply, and evaluate credit risk modeling techniques** — specifically focusing on predicting the likelihood of loan default using machine learning.  
It reflects a full analytical workflow, from **data preparation and feature engineering** to **model training, validation, and performance interpretation**. From a methodological standpoint, this project mirrors a professional credit modeling workflow — encompassing **data preparation, feature engineering, model training, validation, interpretability, and business insight generation**. The approach reflects standards used by financial analysts and data scientists in banking, fintech, and credit risk management environments.  

Rather than building a production-ready model, the focus here is on developing **sound analytical reasoning**, ensuring **methodological transparency**, and practicing best practices that align with how professional data scientists approach model evaluation.  

Key objectives:
- Simulating realistic borrower and loan profiles for UK-based credit products.
- Evaluating multiple supervised learning algorithms for default prediction.
- Quantifying the predictive contribution of financial and demographic features.
- Translating model outcomes into actionable insights for risk-based decision-making.

This model serves both as a **technical demonstration** of machine learning in financial analytics and as a **learning platform** to practice data-driven evaluation of creditworthiness.

---

### **Data Sources and Structure**
The dataset was designed to emulate realistic borrower profiles within the UK consumer credit market. It captures the interplay between demographic, financial, and behavioral characteristics that influence creditworthiness. The synthetic data structure intentionally reflects plausible relationships — for instance, higher loan amounts and interest rates are associated with increased default probability, while strong income levels and stable employment histories typically reduce credit risk.
- **Dataset Name:** `credit_loan_generation.csv`  
- **Type:** Synthetic (self-generated based on UK lending research and risk structure)  
- **Number of Observations:** 500,000
- **Key Features:**
  - `person_age` — Applicant’s age in years.
  - `person_income` — Annual income of the applicant, measured in GBP.
  - `person_home_ownership` — Housing status of the applicant (Rent, Own, or Mortgage).
  - `person_emp_length` — Duration of employment (in years), representing job stability and earning consistency.
  - `loan_intent` — Declared purpose of the loan (e.g., Education, Home Improvement, Venture, etc.).
  - `loan_grade` — Credit grade assigned to the loan, indicating the assessed level of borrower risk.
  - `loan_amnt` — Total amount of the loan requested (GBP).
  - `loan_int_rate` — Applied interest rate (%) consistent with UK consumer lending benchmarks.
  - `loan_status` — Target variable indicating loan outcome (1 = Default, 0 = Non-default).
  - `cb_person_default_on_file` — Binary indicator of any previous loan default history.
  - `marriage_status` — Marital status of the applicant (1 = Married, 0 = Not Married).
  - `interest_rate_band` — Categorical segmentation representing the interest rate band applicable to personal lending products.

---

### **Data Preprocessing**
1. **Exploratory Data Analysis (EDA):**
   - Conducted a detailed exploratory assessment using `pandas`, `matplotlib`, and `seaborn` to understand variable distributions and detect outliers.
   - Descriptive statistics and data visualization using `matplotlib` and `seaborn`.
   - Utilized `missingno` visualizations to assess the extent and structure of missing data patterns, ensuring early identification of potential data quality concerns.

2. **Data Cleaning:**
   - Removed duplicate and inconsistent records to maintain data integrity.
   - Missing value imputation (mean for continuous, mode for categorical variables).
   - Verified data type consistency and standardized categorical label formats for reliable downstream processing.

3. **Feature Engineering:**
   - Applied one-hot encoding to transform categorical variables into binary indicator columns suitable for machine learning algorithms.
   - Standardization of numeric variables for optimized model convergence.

4. **Data Partitioning:**
   - Split the cleaned dataset into training (60%) and testing (40%) subsets using `train_test_split` from `scikit-learn`.
   - Maintained class distribution consistency across both sets through stratified sampling, ensuring representative model evaluation.
  
---

### **Modeling and Algorithms**

Multiple supervised learning algorithms were implemented to benchmark predictive performance across linear and ensemble approaches:
To benchmark predictive performance, following supervised learning algorithms were implemented:

| Model | Description | Rationale |
|--------|--------------|------------|
| **Logistic Regression** | Classical linear classification model estimating the probability of default. | Serves as a transparent baseline for evaluating feature significance and directionality of effects. |
| **XGBoost Classifier** | Gradient boosting algorithm leveraging sequential tree-based learning with regularization. | Provides robust handling of non-linear relationships and variable interactions, delivering high predictive accuracy and resistance to overfitting. |

Both models were optimized using hyperparameter configurations (e.g., regularization strength for Logistic Regression, learning rate and tree depth for XGBoost).
The XGBoost Classifier demonstrated superior performance across all evaluation criteria, offering a balanced trade-off between interpretability and predictive precision.

---

### **Validation and Evaluation**

A rigorous validation process was implemented to ensure that model results were both statistically robust and practically interpretable.

- **Performance Metrics:**  
  Model evaluation was conducted using **Accuracy**, **Precision**, **Recall**, **F1-Score**, and **ROC-AUC**, providing a balanced view of classification performance and discriminatory power across models.

- **Visualization and Diagnostic Tools:**  
  - **ROC Curves** were employed to evaluate model discrimination thresholds and assess overall separability between default and non-default classes.  
  - **Confusion Matrices** provided detailed insights into true positive, false positive, and false negative classifications, supporting error analysis.  
  - **Feature Importance Charts** (for XGBoost) highlighted the most influential predictors of default risk, reinforcing interpretability and alignment with domain expectations.  

- **Reproducibility Controls:**  
  - All random seeds were fixed to ensure deterministic model behavior and result reproducibility across runs.  
  - Consistent data preprocessing and validation workflows were applied throughout to maintain experimental transparency.

---

## **Main Takeaways**

- Borrowers with **higher income relative to loan size** exhibit significantly lower default probability.  
- **Higher interest rates** and **risk grades** show a strong positive correlation with default likelihood.  
- **Ensemble methods** (e.g., XGBoost) outperform linear approaches in capturing complex, non-linear relationships within the data.  
- The **feature importance structure** aligns closely with financial intuition, indicating that the model captures economically meaningful patterns.

---

### **Key Results**

- **Best-performing model:** XGBoost  
- **Performance Summary:**
  - **Precision (Default):** 0.8368  
  - **Recall (Default):** 0.6991  
  - **F1-Score (Default):** 0.7618  
  - **Overall Accuracy:** 0.9045  

- **Top Predictive Features:**
  - `person_income` — Applicant’s annual income  
  - `loan_percent_income` — Ratio of loan amount to income  
  - `person_age` — Applicant’s age  
  - `loan_amnt` — Total loan amount requested  

---

### **Error and Residual Insights**

- Misclassifications predominantly occurred among **medium-risk borrowers** (loan grades C–D), where signal boundaries between default and non-default groups were less distinct.  
- **False negatives** (defaults misclassified as safe) were minimal, suggesting the model effectively prioritizes risk minimization.  
- Probability predictions were **well-calibrated** and closely aligned with observed outcomes, enhancing reliability for risk-based decision making.

---

### **Limitations and Potential Improvements**

- Incorporate **SHAP value analysis** to provide deeper, feature-level interpretability and model transparency.  
- Introduce **behavioral and temporal features** (e.g., payment history, credit utilization trends) to capture borrower dynamics more comprehensively.  
- Address potential **class imbalance** through techniques such as **SMOTE** or cost-sensitive learning to further stabilize performance across minority classes.  
- Expand model validation using **out-of-sample testing** or cross-market datasets to evaluate robustness under varying economic conditions.

---
