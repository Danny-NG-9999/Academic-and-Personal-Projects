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

## **Data Sources and Structure**
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

## **Data Preprocessing**
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

## **Modeling and Algorithms**

Multiple supervised learning algorithms were implemented to benchmark predictive performance across linear and ensemble approaches:
To benchmark predictive performance, following supervised learning algorithms were implemented:

| Model | Description | Rationale |
|--------|--------------|------------|
| **Logistic Regression** | Classical linear classification model estimating the probability of default. | Serves as a transparent baseline for evaluating feature significance and directionality of effects. |
| **XGBoost Classifier** | Gradient boosting algorithm leveraging sequential tree-based learning with regularization. | Provides robust handling of non-linear relationships and variable interactions, delivering high predictive accuracy and resistance to overfitting. |

Both models were optimized using hyperparameter configurations (e.g., regularization strength for Logistic Regression, learning rate and tree depth for XGBoost).
The XGBoost Classifier demonstrated superior performance across all evaluation criteria, offering a balanced trade-off between interpretability and predictive precision.

---

## **Validation and Evaluation**

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

## **Key Results**

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
## Visualisation

### Interpretation of Threshold-Performance Results (Logistic Regression)
<img width="976" height="576" alt="image" src="https://github.com/user-attachments/assets/8034fd9f-1834-458f-bb3f-048cd2aee725" />
The chart visualises how Default Recall, Non-default Recall, and Overall Accuracy evolve as the probability threshold shifts from 0.1 to 0.9. This type of threshold sensitivity analysis is fundamental in credit risk modelling because it directly informs risk appetite calibration, cut-off strategy design, and the trade-offs between risk mitigation and customer acceptance.

1. Default Recall (Blue Line)
- Default Recall is highest at very low thresholds (≈0.1–0.2), indicating that the model captures the majority of true defaults when it adopts a more aggressive stance in predicting default.
- Declines steadily as the threshold increases. If the objective is to minimise credit losses, a threshold lower than 0.5 should be considered.
- If objective is to prioritise loss minimisation and early risk detection, thresholds below 0.5 would provide stronger protection, albeit at the expense of higher rejection rates.

2. Non-default Recall (Orange Line)
- Low at small thresholds (many borrowers incorrectly classified as defaulters).
- Performance improves rapidly as the threshold moves toward 0.4–0.5 and stabilises thereafter, indicating more reliable identification of good customers.
- Higher thresholds reduce false positives and improve customer acceptance rates. If business priority is to avoid rejecting good customers, thresholds above 0.5 are more favourable.

3. Model Accuracy (Green Line)
- Reaches a maximum around 0.40 (representing the threshold where the model best balances true positives and true negatives.), remains relatively stable through 0.60, and then exhibits a modest decline.
- However, in credit risk modeling, accuracy is often misleading due to inherent class imbalance (defaults are typically rare, e.g., 5-10% of portfolios) and asymmetric misclassification costs of failing to detect a default is far costlier than rejecting a non-defaulter. From my experience, I advocate supplementing this with metrics like Precision-Recall curves, F1-score, or AUC-ROC for a more robust evaluation. The observed peak around 0.4 hints at a potentially optimal operating point for balanced performance, especially in imbalanced datasets.


- Accuracy is highest when the balance between misclassifying defaults and non-defaults is optimal.
- Accuracy alone is not sufficient for credit risk modelling due to class imbalance and asymmetric costs.
- Still, the peak around ~0.4 suggests this may be a more balanced threshold than the default 0.5.

Accuracy peaks around 0.35–0.45, where the model strikes a more balanced compromise between detecting defaults and preserving good-customer approvals.

Although accuracy provides a high-level view of classification performance, it is not a sufficient metric in credit risk due to class imbalance and the substantially higher cost of missing a default compared with incorrectly flagging a non-default.

Implication:
The peak near 0.4 suggests this may be a more operationally balanced cut-off than the conventional 0.5 threshold.



4. Current Threshold = 0.5 (Red Dashed Line)
- Default Recall is relatively low, meaning the bank may underestimate default risk.
- Non-default Recall is high, meaning more good customers are correctly approved.
- Threshold = 0.5 favours customer acceptance over risk protection. Depending on the institution’s risk tolerance, this may be too lenient.

Overall Conclusion
- The model becomes more conservative toward defaults at lower thresholds, improving its ability to detect risky borrowers but increasing false positives.
- At the standard 0.5 threshold, the model:
  - Performs well for identifying non-defaulters
  - Performs weaker for identifying defaulters
  - A threshold between 0.30–0.40 appears to provide a better balance, improving Default Recall without overly sacrificing Non-default Recall.

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
