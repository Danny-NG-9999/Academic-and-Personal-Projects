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
## Key Metrics and Estimated Losses (LR model)
- Predicted Defaults (predicted class = 1): 28,144 (True Positive + False Positive count)
- Actual Defaults in Test Data: 40,239 (True Positive + False Negative count)
- Number of Actual Defaults Captured (TP): 20,018
- Default Recall (TP / (TP + FN)): 0.5025 → The model captures only ~50.25% of true defaulters, leaving 20,221 actual defaults undetected (FN).
- Average Loan Amount: £9,583.51
- Estimated Financial Impact (Expected Loss from Missed Defaults):
  - Number of Missed Defaults (FN): 20,221
  - Estimated Loss on Missed Defaults: £191,842,721.95 (= 20,221 × £9,583.51, assuming full principal exposure and zero recovery for simplicity)

## Key Metrics and Estimated Losses (LR model)
- Predicted Defaults (predicted class = 1): 33,616 (True Positive + False Positive count)
- Actual Defaults in Test Data: 40,239 (True Positive + False Negative count)
- Number of Actual Defaults Captured (TP): 28,131
- Default Recall (TP / (TP + FN)): 0.6991 → The model captures only ~50.25% of true defaulters, leaving 20,221 actual defaults undetected (FN).
- Average Loan Amount: £9,583.51
- Estimated Financial Impact (Expected Loss from Missed Defaults):
  - Number of Missed Defaults (FN): 12,108 
  - Estimated Loss on Missed Defaults: £116,037,150.43 (= 12,108  × £9,583.51, assuming full principal exposure and zero recovery for simplicity)

---
## Visualisation

### Interpretation of Threshold-Performance Results (Logistic Regression)
<img width="976" height="576" alt="image" src="https://github.com/user-attachments/assets/8034fd9f-1834-458f-bb3f-048cd2aee725" />
The chart visualises how Default Recall, Non-default Recall, and Overall Accuracy evolve as the probability threshold shifts from 0.1 to 0.9. This type of threshold sensitivity analysis is fundamental in credit risk modelling because it directly informs risk appetite calibration, cut-off strategy design, and the trade-offs between risk mitigation and customer acceptance.

1. Default Recall (Blue Line)
- Default Recall is highest at very low thresholds (≈0.1–0.2), 
- Declines steadily as the threshold increases. If the objective is to minimise credit losses, a threshold lower than 0.5 should be considered.
- If objective is to prioritise loss minimisation and early risk detection, thresholds below 0.5 would provide stronger protection, albeit at the expense of higher rejection rates.

2. Non-default Recall (Orange Line)
- Low at small thresholds (many borrowers incorrectly classified as defaulters).
- Performance improves rapidly as the threshold moves toward 0.4–0.5 and stabilises thereafter, indicating more reliable identification of good customers.
- Higher thresholds reduce false positives and improve customer acceptance rates. If business priority is to avoid rejecting good customers, thresholds above 0.5 are more favourable.

3. Model Accuracy (Green Line)
- Reaches a maximum around 0.40 (representing the threshold where the model best balances true positives and true negatives), remains relatively stable through 0.60, and then exhibits a modest decline.
- However, in credit risk modeling, overall accuracy can be misleading due to pronounced class imbalance (defaults typically comprising only 5–10% of the portfolio) and the asymmetric cost structure, where the economic impact of missing a default far exceeds that of rejecting a non-defaulter. Drawing from extensive practical experience, I strongly recommend complementing accuracy with more informative metrics such as Precision-Recall curves, the F1-score, or AUC-ROC to ensure robust evaluation. The peak observed around 0.40 nonetheless signals a potentially advantageous operating point for balanced performance in imbalanced settings.

4. Current Threshold = 0.5 (Red Dashed Line)
- At the conventional threshold of 0.50, Default Recall is suboptimal at approximately 0.60, implying the model may miss a significant portion of actual defaulters, thereby underestimating portfolio risk and potentially leading to higher-than-expected losses.
- Conversely, Non-Default Recall is strong, favoring higher approval rates for good borrowers, which aligns with strategies emphasizing volume over caution.
- This setting reflects a lenient risk tolerance, common in stable economic conditions but risky in volatile ones.

### Interpretation of Threshold-Performance Results (XGBoost Model)
<img width="976" height="576" alt="image" src="https://github.com/user-attachments/assets/101298c8-08e1-4004-aa9b-04331fb873b8" />
The chart visualises how Default Recall, Non-default Recall, and Overall Accuracy evolve as the probability threshold shifts from 0.1 to 0.9. This type of threshold sensitivity analysis is fundamental in credit risk modelling because it directly informs risk appetite calibration, cut-off strategy design, and the trade-offs between risk mitigation and customer acceptance.

1. Default Recall (Blue Line)
- Peak performance at low thresholds (~0.1–0.2), indicating that the model captures the majority of true defaults when it adopts a more aggressive stance in predicting default.
- Steady decline with rising threshold: By 0.5, recall drops to ~0.60, meaning 40% of true defaulters are missed — followed by a sharp drop beyond 0.5.
- If objective is to prioritise loss minimisation and early risk detection, thresholds below 0.5 would provide stronger protection, albeit at the expense of higher rejection rates.

2. Non-default Recall (Orange Line) – Specificity to Good Borrowers
- Low at aggressive thresholds (<0.3): High false positive rate — many creditworthy applicants are wrongly declined, hurting revenue and customer experience.
- Sharp improvement from 0.3 to 0.5, then plateaus above 0.5: Beyond this point, nearly all good borrowers are correctly approved.
- For growth-focused strategies (e.g., acquisition campaigns), thresholds ≥ 0.5 maximize acceptance rates while maintaining acceptable risk.

3. Model Accuracy (Green Line) – Overall Correct Classification
- Peaks around 0.40 — the point of optimal balance between detecting defaulters and approving non-defaulters — then remains stable through ~0.60 before a modest decline.
- However, in credit risk modeling, overall accuracy can be misleading due to pronounced class imbalance (defaults typically comprising only 5–10% of the portfolio) and the asymmetric cost structure, where the economic impact of missing a default far exceeds that of rejecting a non-defaulter. Drawing from extensive practical experience, I strongly recommend complementing accuracy with more informative metrics such as Precision-Recall curves, the F1-score, or AUC-ROC to ensure robust evaluation. The peak observed around 0.40 nonetheless signals a potentially advantageous operating point for balanced performance in imbalanced settings.

4. Current Threshold = 0.50 (Red Dashed Line) – Evaluation
- Default Recall ≈ 0.60: Suboptimal — the model fails to flag 40% of actual defaulters, leading to under-provisioning, capital inefficiency, and unexpected loss spikes.
- Non-default Recall ≈ 0.95: Excellent — supports high approval rates and customer satisfaction.
- Risk Posture: Lenient and growth-oriented. Suitable in low-default, stable environments but vulnerable in downturns.

### Interpretation of the ROC Curve
In credit risk modelling, evaluating how well a classification model distinguishes between defaulting and non-defaulting borrowers is essential. One of the most widely used diagnostic tools for this purpose is the Receiver Operating Characteristic (ROC) curve. The ROC curve illustrates the trade-off between the True Positive Rate (Sensitivity) and the False Positive Rate (1 – Specificity) across various classification thresholds. A model with strong discriminatory power will generate a curve that bows sharply toward the upper-left corner, indicating high true positive identification with minimal false alarms.

1. Logistic Regression (Blue Line)
- At low False Positive Rates (FPR ≤ 0.2) — when the model is conservative and rarely flags good borrowers by mistake — it correctly identifies about 78% of actual defaulters.
- At moderate FPR (0.4–0.6) — when we allow more false alarms — the model catches 85–95% of defaulters, striking a good balance between risk control and loan approvals. However, beyond this point, gains slow down: approving more loans doesn’t add much extra safety.
- Overall AUC = 0.8574 means the model is strongly effective at separating defaulters from non-defaulters — far better than random guessing (AUC = 0.5). However, in a highly imbalanced data (where defaults are rare, e.g., <5%), performance can drop unless features are carefully engineered.

2. Gradient Boosting Model (Green Line)
- At low FPR (≤0.2), TPR ≈ 0.99, capturing almost all defaulters with minimal false positives—ideal for high-stakes environments like subprime lending, where early risk flagging prevents losses.
- At moderate FPR (0.4–0.6), TPR remains at ~1.00, showcasing exceptional robustness and minimal trade-offs, thanks to GBT's ability to capture nonlinearities and interactions (e.g., via tree ensembles).
- Overall AUC ≈ 0.9347 reflects near-flawless separation, often achievable in well-tuned ensembles on tabular credit data. This positions GBT as a production-ready choice for dynamic risk scoring, though it demands vigilance against overfitting via cross-validation.

3. Comparison to Random Prediction (Dashed Gray Diagonal) and Between Models
- Versus Random Prediction (AUC = 0.50):
  - Both models vastly outperform randomness, as their curves lie entirely above the diagonal. LR's AUC (0.8574) yields ~72% improvement in separability (calculated as (AUC - 0.5)/0.5), while GBT's (0.9347) approaches perfection (~87% improvement).
  - A threshold between 0.30–0.40 appears to provide a better balance, improving Default Recall without overly sacrificing Non-default Recall.
- LR versus GBT:
  - Superiority of GBT: GBT dominates LR across all FPR levels. The ~0.078 AUC gap underscores GBT's edge in handling complex features common in credit datasets.
  - When to Choose LR: Despite trailing, LR's interpretability (via logit coefficients) aids regulatory audits and quick iterations, making it preferable for smaller datasets or when explainability trumps raw accuracy.

### Calibration Curve (Reliability Diagram) Analysis
<img width="1176" height="776" alt="image" src="https://github.com/user-attachments/assets/fbc6d160-cc75-4893-a438-c5220e452cb4" />

Perfectly Calibrated (Dotted Line): The diagonal dotted line represents a model that is perfectly calibrated. For any given predicted probability (x-axis), the actual observed fraction of positives (y-axis) is exactly the same.  For example, if a model assigns a 40% probability of default, then—under perfect calibration—approximately 40% of those borrowers should actually default. Achieving good calibration is especially important in credit risk and insurance, since predicted probabilities feed directly into financial metrics such as Expected Loss (EL = PD × LGD × EAD). Poor calibration leads to biased risk estimates and mispriced portfolios.

| Model                                               | Interpretation                                                                                                   | Calibration Behaviour                                                                                                                                                                                                        |
| --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Logistic Regression (Blue, Square Markers)**      | The curve sits above the perfect-calibration line for predicted probabilities roughly between 0.35 and 0.70. | Underestimation (Optimistic Bias): LR predicts probabilities that are too low in the mid-to-high risk range. When LR predicts a 50% default probability, the actual observed default rate is closer to 60%. (True risk is higher than predicted). |
| **Gradient Boosting Trees (Green, Circle Markers)** | The curve falls below the perfect-calibration line for probabilities between about 0.40 and 0.90            | Overestimation (Pessimistic Bias): GBT assigns probabilities that are too high in the mid-to-high risk range. When GBT predicts a 60% chance of default, the actual observed default rate is closer to 55%. (True risk is lower than predicted).                                          |

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
