## **Project Overview**
This project develops an advanced credit risk assessment framework designed to estimate borrower default risk with high accuracy and translate it into interpretable credit scores based on customer profiles. The analysis is conducted on a large dataset of approximately 400,000 observations and 23 variables capturing borrower demographics, employment history, socioeconomic indicators, and detailed loan characteristics, including loan-to-value (LTV) ratios, interest rates, and collateral information.

The study is set within the context of a typical UK private bank operating under current macroeconomic conditions characterised by economic downturn, sluggish growth, and heightened uncertainty driven in part by an oil crisis. These conditions increase overall credit risk exposure, reinforcing the need for robust, data-driven credit decisioning aligned with Basel II and Basel III regulatory frameworks.

To effectively model default risk, a dual-modelling strategy is adopted to balance interpretability and predictive performance. A transparent “white-box” Logistic Regression model is implemented to ensure explainability and regulatory compliance, while “black-box” ensemble methods such as XGBoost, Random Forest, and Gradient Boosting are used to capture complex, non-linear relationships and interaction effects in borrower behaviour, thereby improving predictive accuracy.

The modelling pipeline incorporates rigorous data preprocessing, including missing value treatment, outlier detection and handling, and appropriate variable transformations. Feature engineering and selection are guided by Weight of Evidence (WoE) encoding and Information Value (IV) metrics to ensure strong predictive power, monotonic relationships, and interpretability of variables. To validate model robustness and ensure generalisability, a triple-split framework is employed, dividing the dataset into training, test, and holdout samples. This approach ensures that performance is consistently evaluated not only in-sample but also on truly unseen data.

The framework extends beyond Probability of Default (PD) modelling to incorporate Loss Given Default (LGD) and Exposure at Default (EAD), enabling the computation of Expected Loss (EL). This provides a comprehensive, portfolio-level measure of credit risk, supporting improved risk management, capital allocation, and strategic decision-making.

Overall, the project progresses through a structured pipeline: data preprocessing and feature selection, PD modelling using both interpretable and ensemble approaches, and final credit risk quantification through LGD, EAD, and credit score derivation.

---

## **Model Objectives**
The primary objective of this project is to build a high-performance classification system that accurately distinguishes between "Good" and "Bad" (default) loan applicants. The specific goals include:
- **Risk Quantification:** Develop a probability-of-default (PD) score for each applicant to facilitate tiered risk management.
- **Explainability (White Box):** Implement interpretable models (such as Logistic Regression) to satisfy regulatory compliance and provide clear "reason codes" for loan denials or approvals.
- **Predictive Discrimination (Black Box Modelling):** Apply advanced machine learning algorithms such as XGBoost and Random Forest to effectively capture complex non-linear relationships and interaction effects between variables, thereby understanding the model’s ability to accurately distinguish between good and bad credit risk.
- **Feature Robustness and Stability:** Identify and validate key predictive drivers to ensure strong predictive performance and consistency across different data segments. This is reinforced through triple-split validation (Train, Test, and Holdout), ensuring that feature behaviour remains stable and generalises reliably across time and population subgroups.
- **Decision Support:** Deliver a scalable and efficient credit risk tool that streamlines underwriting processes, reduces reliance on manual decision-making, and improves risk management by minimising exposure to non-performing loans (NPLs) through more accurate and consistent credit assessments.

--- 

## **Data Sources and Structure**
The dataset is designed to replicate realistic borrower profiles within the UK consumer credit market, representative of a private banking institution such as Lloyds. It captures the interaction between demographic, financial, and behavioural factors that collectively influence creditworthiness. The synthetic structure is intentionally constructed to reflect economically plausible relationships; for example, higher interest rates and unstable or insufficient income streams are associated with an increased probability of default.

- **Dataset Name:** `credit_loan_dataset.csv`
- **Type:** Synthetic dataset, constructed based on UK consumer lending research and realistic credit risk structures typical of private UK banks
- **Number of Observations:** 400,000 records

- **Key Features:**

| Category        | Column Name                 | Description                                                                
|----------------|-----------------------------|-------------------------------------------------------------|
| Demographics   | `person_age`                  | Age of the applicant.                                     |                
| Demographics   | `gender`                      | Gender of the borrower.                                   |                  
| Demographics   | `marriage_status`             | Marital status (e.g., Single, Married).                   |                 
| Employment     | `annual_inc`                  | Total gross annual income.                                |                 
| Employment     | `emp_length`                  | Years in current employment.                              |                 
| Employment     | `emp_title`                   | Job title or profession.                                  |                  
| Financials     | `home_ownership`             | Type of tenure (e.g. RENT, MORTGAGE, OWN).                 |                     
| Financials     | `addr_cities`                | Residential city of the borrower.                          |                 
| Financials     | `fixed_obligation`           | Fixed monthly non-loan expenses.                           |                 
| Credit History  | `mths_since_earliest_cr_line` | Age of the borrower's credit history.                    |                  
| Credit History  | `existing_loans`             | Whether the borrower has other active loans.              |                  
| Credit History  | `existing_emi`               | Monthly installment for existing debts.                   |                   
| Loan Details   | `loan_amount`                | Total principal requested.                                 |
| Loan Details   | `purpose`                    | Stated reason for the loan application.                    |
| Loan Details   | `term`                       | Length of the loan (in months).                            |               
| Loan Details   | `terms_remaining`            | Remaining repayment terms.                                 |                
| Loan Details   | `int_rate`                   | Annual interest rate percentage.                           |                 
| Loan Details   | `interest_band`              | Binned ranges of interest rates.                           |                
| Loan Details   | `grade`                      | Internal risk rating (e.g., A, B, C, D).                   |                
| Loan Details   | `loan_to_value`             | (LTV) Ratio of loan to asset value.                         |                
| Loan Details   | `collateral`                | Flag for pledged assets.                                    |                
| Loan Details   | `regularity_of_inflows`     | Consistency of monthly income.                              |                
| Target         | `default_status`            | Target variable – whether the borrower defaulted            |              

---

## **Data Preprocessing and Engineering**
The preprocessing pipeline is designed to systematically transform raw borrower data into a clean, structured, and model-ready format, while preserving statistical consistency across all data subsets. A robust triple-split validation framework (Train, Test, and Holdout) is implemented to ensure unbiased model development and evaluation. In particular, the holdout dataset is kept entirely unseen during model training and tuning, enabling a realistic assessment of out-of-sample performance and closely simulating real-world deployment conditions.

**Notebook Name:** `credit_loan_preprocess.ipynb`

**Output Datasets:**
The preprocessing stage generates separate input (features) and target (labels) datasets for each data split, ensuring clear separation of modelling components and preventing data leakage:
- `loan_inputs_train.csv` – Training features used for model fitting
- `loan_targets_train.csv` – Training labels (default outcomes)
- `loan_inputs_test.csv` – Test features used for model evaluation and tuning
- `loan_targets_test.csv` – Test labels for performance validation
- `loan_inputs_holdout.csv` – Holdout features reserved for final, unbiased evaluation
- `loan_targets_holdout.csv` – Holdout labels for true out-of-sample assessment

**Preprocessing Pipeline: Key Processes**
| Category            | Process                  | Description                                                                                                                                               |
| ------------------- | ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Data Cleaning       | Missing Value Imputation | Handles missing values in features (if any) using mode (categorical) and median (numerical) to reduce the impact of outliers.                             |
| Feature Engineering | LTV Grouping             | Segments feature such as `loan_to_value` into risk tiers (Low, Moderate, High) to better capture non-linear increases in default risk.                    |
| Feature Engineering | Interest Rate Banding    | Converts continuous feature such as `int_rate` into categorical bands to support interpretability and enable WoE transformation.                          |
| Exposure Modelling  | EAD Computation          | Estimates Exposure at Default (EAD) as the remaining loan exposure, representing total capital at risk.                                                   |
| Encoding            | One-Hot Encoding         | Transforms categorical variables (e.g., `home_ownership`, `purpose`) into numerical format for model compatibility.                                       |
| Scaling             | Standardisation          | Normalises numerical features (e.g., `annual_inc`, `loan_amount`) to ensure balanced contribution across variables.                                       |
| Audit               | Stability Audit          | Validates that feature distributions remain consistent across Train, Test, and Holdout datasets to ensure robustness.                                     |


---

## **Modeling Approach & Implementation**

**Notebook Name:** `credit_risk_PD_model.ipynb`
**Modeling Output:**
- `credit_risk_pd_model.pkl`
- `final_scoring_results.csv`

**Notebook Name:** `credit_risk_PD_model (part 2).ipynb`
**Modeling Output:**
- `extra_trees_pipeline.pkl`
- `random_forest_pipeline.pkl`
- `gradient_boosting_pipeline.pkl`
- `xgboost_pipeline.pkl`
- `mlp_neural_net_pipeline.pkl`

**Modeling Stages and Key Details**
| Stage                          | Action                        | Technical Detail                                                                                                                                                                                                                                                        |
| ------------------------------ | ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Class Imbalance Handling       | Resampling Techniques         | Evaluated multiple resampling techniques—including SMOTE, ADASYN, and Tomek Links—through a comparative analysis framework using optimal Youden thresholds. This approach enabled the selection of the most effective method for addressing class imbalance, improving the model’s ability to accurately identify rare default events while maintaining balanced classification performance.|
| Baseline Intepretable Modelling (White Box) | Logistic Regression           | Implemented Logistic Regression as an interpretable baseline model to ensure regulatory compliance, providing transparent and explainable outputs for credit decision-making. Model performance was comprehensively evaluated using standard classification metrics (Accuracy, Precision, Recall, F1-Score, and ROC-AUC) to assess overall predictive power. In addition, discriminatory power was rigorously tested using industry-standard risk metrics, including the Gini coefficient, Kolmogorov–Smirnov (KS) statistic, and CAP curve, to measure the model’s ability to effectively distinguish between default and non-default borrowers. |
| Non-interpretable Modelling (Black Box) | Ensemble & Non-Linear Models  | Developed and compared multiple high-performance models, including XGBoost, CatBoost, Random Forest, and Multi-Layer Perceptron (MLP), to capture complex non-linear relationships and interaction effects in borrower behaviour.|
| Credit Score Generation | Application of PD Model for Credit Scoring | Transformed model-derived Probability of Default (PD) into a standardized credit score using log-odds transformation and Points-to-Double-Odds (PDO) scaling. The scoring framework is aligned with established UK credit bureau methodologies (e.g., Experian-style scorecards), enabling consistent interpretation of borrower risk and facilitating actionable credit decisioning through a calibrated scorecard system. |
| Expected Loss (EL) computation | Estimation of expected credit loss using available exposure, default probability, and recovery assumptions | Calculate EL using available dataset inputs and apply a standard assumed average recovery rate where specific recovery data is not provided. Combine observed or estimated default risk with exposure at default to derive a consistent EL estimate. | 
| Deployment Readiness           | Model Packaging               | Prepared final model artefacts (e.g., `.pkl` files) for deployment, ensuring reproducibility and seamless integration into production or decision-support systems. |

---

## Key Results, Summary, and Strategic Interpretation
The current macroeconomic environment—defined by an economic downturn, subdued growth, and elevated uncertainty driven by external shocks such as an oil crisis—has materially increased systemic credit risk within the banking sector. For a UK retail and commercial bank such as Lloyds, this translates into higher probabilities of default (PD), increased portfolio volatility, and more constrained risk appetite.

### **1. Risk Strategy and Model Objective**
In response to a stressed macroeconomic environment, the modeling strategy shifts from a neutral posture to a risk‑averse, capital‑preservation framework. The primary objective is early and reliable identification of credit defaults to protect the bank’s balance sheet and maintain financial stability. Consequently, the model is deliberately optimized to maximize recall (sensitivity to defaults), even at the cost of a higher number of false positives.

This design reflects the asymmetric cost structure of credit risk errors:
1. False Negatives (Type II errors): Represent undetected defaulters. These are highly material, as they directly translate into credit losses, increased provisions, and potential capital erosion—especially during downturn conditions.
2. False Positives (Type I errors): Represent safe borrowers incorrectly classified as high risk. While this results in opportunity costs (e.g., forgone interest income or unnecessary manual review), it does not directly impair solvency or capital adequacy.

Given this asymmetry, minimising false negatives takes precedence over precision. Under volatile, recessionary conditions, the cost of missing a true defaulter far outweighs the cost of incorrectly flagging a creditworthy borrower. A conservative classification threshold is therefore justified, prioritising early risk detection and portfolio protection over lending efficiency.

In practical terms:
- Higher recall is prioritised over precision.
- The model becomes more sensitive to early warning signals of distress.
- Portfolio protection is enhanced through proactive risk flagging.

While this approach inevitably increases false positives, the trade‑off is strategically acceptable: the marginal loss from rejected or reviewed low‑risk customers is outweighed by the reduction in credit losses from undetected defaults.

### **2. Model Selection: ADASYN as Preferred Resampling Method** ##
To address the inherent class imbalance of credit default data, we benchmarked four advanced resampling techniques: SMOTE, ADASYN, SMOTE-ENN, and ROS-Tomek.

| Method         | Optimal Threshold | Youden's Index | Test F1-Score | Test Recall | Test Precision | Train Size | Event Count (Train) |
|----------------|-------------------|----------------|---------------|-------------|----------------|------------|---------------------|
| ADASYN          | 0.646100          | 0.770300       | 0.542400      | 0.927300    | 0.383300       | 436002     | 218854              |
| SMOTE           | 0.486100          | 0.770100       | 0.536000      | 0.933000    | 0.376000       | 434296     | 217148              |
| SMOTE-ENN       | 0.499000          | 0.770300       | 0.535900      | 0.933400    | 0.375900       | 359271     | 180891              |
| ROS-Tomek       | 0.489200          | 0.770200       | 0.536500      | 0.932800    | 0.376500       | 434295     | 217147              |

Among these, ADASYN (Adaptive Synthetic Sampling) demonstrates the strongest overall performance, although improvements over alternative methods are marginal. Its advantage lies in its ability to provide a superior ability to focus on "hard-to-learn" boundary cases, delivering marginal but critical improvements in ranking power over alternative methods:
- Highest F1‑score (0.5424): Demonstrates the most effective trade‑off between recall (identifying actual defaulters) and precision (limiting false alarms).
- Highest Youden’s Index (0.7703): Reflects superior overall discriminative capability, meaning the model is most effective at separating default from non‑default cases across all probability thresholds.

## **3. Confusion Matrix and Classification Interpretation**
 
<img width="776" height="584" alt="image" src="https://github.com/user-attachments/assets/a0b8c32b-e496-40c5-bc2b-13abad2eb8e9" />
<br>


| Classification | Mapping | Count | Financial Meaning |
|----------------|--------|-------|-------------------|
| True Negative (TN) | Predicted 0, Actual 0 | 61,019 | Efficient Capital Allocation: Safe borrowers correctly identified and approved. |
| True Positive (TP) | Predicted 1, Actual 1 | 7,063 | Loss Avoidance: Risky borrowers correctly identified and blocked. |
| False Positive (FP) | Predicted 1, Actual 0 | 11,364 | Opportunity Cost: Safe borrowers rejected; requires secondary manual review. |
| False Negative (FN) | Predicted 0, Actual 1 | 554 | Credit Loss: Defaulters wrongly approved; represents a direct capital hit. |

 
<img width="467" height="199" alt="image" src="https://github.com/user-attachments/assets/ec026787-0e76-4b2a-8597-023a2e7ab95e" />
<br>

| Metric | Value | Interpretation |
|--------|------|----------------|
| **Precision (Default)** | 0.3833 | Only ~38% of customers flagged as high-risk actually default. This indicates a relatively high false positive rate, meaning some creditworthy borrowers may be incorrectly rejected. In practical terms, for every ~2.6 customers classified as high-risk, only 1 defaults. |
| **Recall (Default)** | 0.9273 | The model correctly identifies over 92% of actual defaulters. False negatives are minimal, meaning very few high-risk borrowers are missed. This makes the model highly effective for risk mitigation, portfolio protection, and audit assurance. |
| **F1-Score (Default)** | 0.5424 | Reflects a deliberate trade-off between high recall and moderate precision. The model prioritises capturing defaults while accepting some loss in classification precision, which is appropriate in a stressed macroeconomic environment. |
| **Overall Accuracy** | 0.8510 | 85.10% of all predictions are correct. However, accuracy is less informative in this context due to class imbalance and the risk-sensitive objective of the model. |





| **Gini Coefficient** | 0.9048 | Indicates near-perfect discriminatory power. The model is highly effective at ranking borrowers by risk, providing strong support for credit scoring and risk-based pricing decisions. |


Precision (Default) = 0.3833
Only about 4 out of every 10 flagged customers actually default. This implies a significant number of false positives, requiring manual review and potentially rejecting creditworthy applicants. In practical terms, for every 2.6 customers labelled as high‑risk, only 1 truly defaults.

Recall (Default) = 0.9273
The model correctly identifies approximately 9 out of 10 actual defaulters. False negatives are very rare, meaning almost no high‑risk borrowers go undetected. This makes the model highly effective for risk mitigation and audit assurance.

F1‑Score (Default) = 0.5424
Reflects the inherent trade‑off: strong recall is partially offset by lower precision. This balance is deliberately chosen given the macroeconomic environment.

Overall Accuracy = 0.8510
While accuracy is high, it is less informative than recall and precision due to class imbalance.



Precision (Default): 0.3833
- Only about 4 out of 10 flagged customers actually default (A significant number of false positives, requiring additional review and potentially rejecting creditworthy customers)
- In practical terms, for every ~2.6 customers flagged as high-risk, only 1 truly defaults
Recall (Default): 0.9273
- The model correctly identifies approximately 9 out of 10 defaulters
- Implies very few false negatives, meaning almost no high-risk customers go undetected
- Highly effective for risk mitigation and audit assurance
F1-Score (Default): 0.5424
- Reflects the inherent trade-off: Strong recall is partially offset by lower precision
Overall Accuracy: 0.8510

Recall (92.73%): The model captures over 9 out of 10 defaulters. This exceptional sensitivity ensures that nearly all high-risk exposures are flagged, providing high levels of audit assurance and risk mitigation.

Precision (38.33%): For every ~2.6 customers flagged as high-risk, one truly defaults. While this indicates a higher rejection rate for safe customers, it serves as a necessary "safety buffer" in a fragile economy.

Gini Coefficient (0.9048): A Gini score exceeding 0.90 indicates near-perfect discrimination. This confirms that the model’s ranking of borrower risk is statistically robust and provides an excellent foundation for risk-based pricing.

Overall Accuracy (85.10%): Despite the aggressive pursuit of defaults, the model maintains a high degree of total correct classifications.



In a high-risk economic environment, a risk-averse strategy is both appropriate and justified. The model prioritizes minimizing false negatives (missed defaulters), aligning with the bank’s objective of protecting its loan portfolio. While this approach leads to a higher incidence of false positives, the trade-off is acceptable given the need to maintain financial stability during periods of elevated uncertainty.

GINI coefficient 
- 0.9048 which is near perfect discrimination

CAP curve
- Baseline: A random selection (diagonal line) would require sampling 50% of the data to find 50% of defaults.
Model Efficiency: Our model (orange) captures approximately 90% of defaults within the first 20% of the sampled population.
Conclusion: The model shows significant "lift" over the random baseline, making it highly effective for targeted intervention and risk mitigation.
