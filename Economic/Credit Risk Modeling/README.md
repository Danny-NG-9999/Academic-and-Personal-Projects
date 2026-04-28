# Credit Risk Modelling | Calculation of PD, LGD, EAD and EL with Machine Learning in Python

Table of contents
Background
Project
Pipeline
Key documents
Datasets
Model performances
Deliverables
Getting Started
Technologies
Top-directory layout
License
Author

- [Project Overview](#project-overview)
- [Model Objectives](#model-objectives)
- [Data Sources and Structure)](#data-sources-and-structure)
- [Data Preprocessing and Engineering](#data-preprocessing-and-engineering)


- 
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

### **Risk Strategy and Model Objective**
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

### **Model Interpretation: Key Drivers of Credit Risk Predictions**
To ensure the model is both robust and interpretable, we evaluate features based on their ability to distinguish between classes. The selection is driven by two primary metrics:
- Weight of Evidence (WoE): Measures the "strength" of a specific grouping (bin) of a feature in predicting the target.
- Information Value (IV): Provides a score to rank the overall predictive power of the entire feature.

**Continuous features (White Box)**

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/02771bb5-5125-4757-9267-cc3fa4de4e0e" />
- `loan_to_value`: This is the strongest predictive feature, with an Information Value (IV) of 0.5639, indicating excellent discriminatory power. This confirms that leverage plays a critical role in differentiating between high- and low-risk borrowers, making it the primary driver in the dataset.
- `int_rate serves`: This act as a key secondary driver, with an IV of 0.4057, reflecting moderate-to-strong predictive strength. Its importance highlights the role of risk-based pricing, where higher interest rates are typically associated with higher perceived default risk.
- `annual_inc` and `emp_length`: Although these features are included in the model, they exhibit relatively low IV values. This suggests they contribute limited standalone predictive power compared to loan-specific variables. Their impact is more supplementary, providing incremental context rather than acting as core risk differentiators.

**Categorical features (White Box)**

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/d46d82d9-c79d-4001-94fc-7a3bf860504c" />
- `collateral`, `regularity_of_inflows` and `ltv_group`: These features are emerge as the most influential categorical features, providing strong differentiation in borrower risk profiles. A key insight is that income stability outweighs income magnitude: variables such as annual income (income_group) and employment length are less predictive than the consistency of cash inflows. This indicates that borrowers with steady and predictable income streams are significantly less likely to default, even if their total income level is relatively modest. In practical terms, cash flow reliability is a more critical indicator of creditworthiness than absolute income size.
- `interest_band` and `grade`: These features are closely align with the underlying interest rate (int_rate) and serve as strong proxies for loan pricing and borrower credit quality. These variables reinforce the model’s ability to capture risk-based pricing dynamics, where higher interest rates and lower credit grades are associated with elevated default risk. As such, they function as complementary risk signals, strengthening the overall predictive power of the model.

**Key insights**
- Loan characteristics (such as loan-to-value ratio and interest rate) are more powerful predictors of default risk than traditional borrower demographics (such as income level and employment length). This highlights that structured loan terms capture risk more effectively than static personal attributes.
- Cash flow stability emerges as a central determinant of creditworthiness. The consistency and regularity of income inflows are more influential than the absolute level of income, indicating that predictable liquidity is a stronger signal of repayment ability than earnings magnitude alone.
- There is strong alignment between continuous variables (e.g., interest rate) and categorical proxies (e.g., credit grade, interest band). This consistency across feature types reinforces the robustness of the model and increases confidence in its underlying predictive structure.
- For a more detailed assessment of potential data leakage risks, including feature selection decisions and preprocessing safeguards, please refer to the notebook `credit_loan_preprocess.ipynb`, which provides a comprehensive walkthrough of the data preparation pipeline and highlights key steps taken to ensure model integrity and prevent information leakage.
  
**LIME prediction (Black Box)**
<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/a4250837-b7b6-4b6e-9f55-6df95dc9ff08" />

LIME (Local Interpretable Model-Agnostic Explanations) provides a local, instance-specific view of model behaviour, explaining why a prediction was made for a single borrower (Instance 5). Unlike Information Value (IV), which captures global feature importance across the dataset, LIME focuses on the decision logic for an individual prediction.

The results for Instance 5 across all five models (Extra Trees, Random Forest, Gradient Boosting, XGBoost, and MLP) strongly reinforce the earlier IV findings, particularly the dominance of income stability over income level.

- **Primary Negative Driver (Across All Models):** The feature `regularity_of_inflows` is consistently the most influential driver in every model. This indicates that the absence of regular income inflows is the strongest factor pushing the prediction toward higher risk. It confirms that cash flow stability acts as a core decision anchor at the individual level, not just in aggregate feature importance.
- **Income Consistency vs Income Level:** The LIME explanation clearly supports earlier IV-based findings that income regularity is more important than total income amount. Even when borrowers have relatively high income, irregular inflows significantly increase perceived default risk. This reinforces the model’s focus on financial stability rather than earnings magnitude.
- **Asset and Collateral Protection Effect:** Features such as collateral and loan_to_value (LTV) consistently appear as strong explanatory drivers across all models. This aligns with global feature importance results and shows that, at the local level, models heavily rely on asset-backed security as a protective buffer against default risk. Higher LTV exposure and lack of collateral increase predicted risk, while secured lending positions reduce it..

### **Model Selection: ADASYN as Preferred Resampling Method** ##
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

### **Confusion Matrix and Classification Interpretation (White Box model)**

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/a0b8c32b-e496-40c5-bc2b-13abad2eb8e9" />
<br>


| Classification | Mapping | Count | Financial Meaning |
|----------------|--------|-------|-------------------|
| True Negative (TN) | Predicted 0, Actual 0 | 61,019 | Efficient Capital Allocation: Safe borrowers correctly identified and approved. |
| True Positive (TP) | Predicted 1, Actual 1 | 7,063 | Loss Avoidance: Risky borrowers correctly identified and blocked. |
| False Positive (FP) | Predicted 1, Actual 0 | 11,364 | Opportunity Cost: Safe borrowers rejected; requires secondary manual review. |
| False Negative (FN) | Predicted 0, Actual 1 | 554 | Credit Loss: Defaulters wrongly approved; represents a direct capital hit. |
</br>
 
<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/ec026787-0e76-4b2a-8597-023a2e7ab95e" />
<br>

| Metric | Value | Interpretation |
|--------|------|----------------|
| **Precision (Default)** | 0.3833 | Only ~38% of customers flagged as high-risk actually default. This indicates a relatively high false positive rate, meaning some creditworthy borrowers may be incorrectly rejected. In practical terms, for every ~2.6 customers classified as high-risk, only 1 defaults. |
| **Recall (Default)** | 0.9273 | The model correctly identifies over 92% of actual defaulters. False negatives are minimal, meaning very few high-risk borrowers are missed. This makes the model highly effective for risk mitigation, portfolio protection, and audit assurance. |
| **F1-Score (Default)** | 0.5424 | Reflects a deliberate trade-off between high recall and moderate precision. The model prioritises capturing defaults while accepting some loss in classification precision, which is appropriate in a stressed macroeconomic environment. |
| **Overall Accuracy** | 0.8510 | 85.10% of all predictions are correct. However, accuracy is less informative in this context due to class imbalance and the risk-sensitive objective of the model. |
</br>

### **Discrimation Power: ROC-AUC, GINI coefficient, CAP curve and Kolmogorov-Smirnov curve Interpretation (White Box model)**
The following results assess how effectively the credit risk model distinguishes between defaulters and non-defaulters, and how well it ranks borrowers by risk. In a banking context, these metrics are critical because they directly determine the model’s reliability in supporting lending decisions, risk-based pricing, and portfolio risk mitigation—especially under stressed macroeconomic conditions.

1. ROC-AUC Score (0.9524)

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/6a861bf8-f965-4ca8-9300-c94e8a736dc7" />

- The model achieves a ROC-AUC score of 0.9524, indicating excellent ranking performance.
- In simple terms, this means that 95.24% of the time, the model assigns a higher risk score to a borrower who will default than to one who will not. This reflects a very high level of separability between risky and safe customers.

2. Gini Index and CAP curve(0.9048)

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/fb4a95d2-a557-4406-bbcd-b29e3dacecb5" />

- The Gini index measures the “separation” between the two groups. A Gini of 0 means the model sees no difference; a Gini of 1 means every defaulter has a higher risk score than every non‑defaulter. 0.9048 is extraordinarily close to 1.
- The CAP (Cumulative Accuracy Profile) curve shows that the model captures about 90% of all defaulters within the first 20% of the highest‑risk population.
 - Random selection would require checking 50% of applicants to find 50% of defaulters.
 - Our model finds 9 out of 10 defaulters by looking at only the riskiest 20% of applicants.
 - This means the bank can focus expensive manual underwriting on a very small fraction of applications while still catching almost all bad debt – a huge efficiency gain.
   
3. Kolmogorov-Smirnov Statistic (0.7703)
<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/c05c169a-3efa-494e-9e8d-ab157af4d635" />

- The Kolmogorov-Smirnov (KS) statistic measures the maximum vertical distance between the cumulative curves of defaulters and non‑defaulters. A value of 0.7703 means that at the optimal decision threshold, the model achieves a 77% difference in how it treats the two groups.
- The red curve (defaulters) and blue curve (non‑defaulters) are far apart. The maximum gap of 0.7703 occurs at the threshold 0.6461. This visual confirms that the model does not confuse the two groups – a clear sign of high discriminatory power.

### **Credit Score Transformation & Scorecard Interpretation**
<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/353d663e-c388-4c89-8d9d-5f9938c1ce73" />

Machine learning models like Logistic Regression output a Probability of Default (PD)—a decimal between 0 and 1. To make these results actionable for credit officers and customers, we transform these probabilities into a Credit Score using following components.

| Component                       | High Value Means                           | Low Value Means                            | Business Interpretation                                               |
| ------------------------------- | ------------------------------------------ | ------------------------------------------ | --------------------------------------------------------------------- |
| **Probability of Default (PD)** | High risk of default                       | Low risk of default                        | Direct risk likelihood; used for prediction but not decision-friendly |
| **Log-Odds**                    | Safer borrower                             | Riskier borrower                           | Better separation of risk levels; used for scoring transformation     |
| **PDO Scaling**                 | Small score change = large risk difference | Large score change = lower risk difference | Converts statistical output into meaningful business intervals        |
| **Credit Score**                | Low risk / strong borrower                 | High risk / weak borrower                  | Final interpretable output used for lending decisions                 |


The final credit score is calculated using a linear transformation of the log-odds:
$$Score = Offset + (Factor \times \ln(Odds))$$

Alternatively, expressed using the Probability of Default (PD):
$$Score = A - B \times \ln\left(\frac{PD}{1 - PD}\right)$$

The dashboard serves as the operational layer of the project, turning the mathematical scaling logic into a functional rating system.

1. Top 10 Risk Drivers (Point Deductions)
- Major Point Deductions: loan_to_value is the single most aggressive risk driver, resulting in a deduction of nearly 80 points when values are unfavorable. This confirms that high leverage is the primary indicator of default risk in our model.
- Positive Score Impact: Features like lower interest bands (6.4-7.5) and specific grades contribute positive points, helping borrowers move into higher rating tiers.

2. Score vs. Probability of Default (PD)
- Inverse Relationship: As the Credit Score increases, the Probability of Default (PD) drops exponentially.
- Rating Tiers: Borrowers are segmented into four distinct buckets:

3. Portfolio Distribution & Volume
- Portfolio Volume by Rating: The majority of the portfolio falls into the Fair (32,199) and Good (24,420) categories. The "Poor" category is the smallest (5,339), suggesting that the underlying lending criteria are relatively selective.
- Overall Score Distribution: The histogram shows a multi-modal distribution with significant density at the higher end of the scale (900+).

### **LGD, EAD, and Expected Loss (EL) Estimation Framework**
This section summarises the credit risk modelling approach used to estimate Loss Given Default (LGD), Exposure at Default (EAD), and Expected Loss (EL) for loan applicants. The framework combines borrower purpose, loan characteristics, and repayment dynamics to support risk-based credit decisions.

1. Loss Given Default (LGD) Assumptions by Loan Purpose

LGD is derived from expected recovery rates, which vary depending on the loan purpose and underlying collateral quality.

| Loan Purpose | Recovery Rate (RR) | LGD (1 − RR) | Risk Interpretation |
|--------------|--------------------|--------------|----------------------|
| Home Improvement | 45% | 55% | Moderate risk due to strong collateral support (e.g., property-linked borrowing) |
| Debt Consolidation | 25% | 75% | High risk as borrowers are already financially stressed |
| Car Purchase | 40% | 60% | Moderate recovery potential through vehicle repossession |
| Major Purchase | 30% | 70% | Higher risk due to rapid asset depreciation |
| Small Business | 20% | 80% | Highest risk due to low recoverability of business assets |

2. Exposure at Default (EAD) Estimation

EAD is calculated using loan structure and amortisation dynamics (using features such as `loan_amount`, `int_rate`, `term` and `term_remaining`), capturing the remaining exposure at the point of default:
$$EAD = P \times \frac{(1 + r)^n - (1 + r)^p}{(1 + r)^n - 1}$$
Where:
- $P$ = Original Loan Amount
- $r$ = Monthly Interest Rate (Annual Rate / 12)
- $n$ = Total Number of Terms (Months)
- $p$ = Number of installments already paid ($n - \text{terms\_remaining}$)

3. Expected Loss (EL) Framework

Expected Loss is computed by combining risk probability and loss severity:

$$EL = PD × LGD × EAD$$

This allows the model to translate borrower characteristics into monetary credit risk estimates, enabling consistent comparison across applicants.

4. Real-Time High vs Low Risk Borrower Comparison
   
**Input Characteristics**
| Sample | int_rate | loan_to_value | ead | interest_band | grade | collateral | regularity_of_inflows | ltv_group | purpose |
|--------|----------|---------------|-----|---------------|-------|------------|----------------------|-----------|---------|
| 1. High Risk (Small Business, 80% LGD) | 24.5 | 0.95 | 50000 | 20.0+ | G | No | No | Critical | Small Business |
| 2. Low Risk (Home Improvement, 55% LGD) | 6.2 | 0.35 | 20000 | 5.0-7.5 | A | Yes | Yes | Low | Home Improvement |

**Model Output and Decision**
| Metric | Sample 1: Small Business | Sample 2: Home Improvement |
|--------|---------------------------|----------------------------|
| Credit Score | 641 (High Risk) | 947 (Excellent) |
| Prob. of Default (PD) | 99.36% | 0.38% |
| Exposure (EAD) | £50,000 | £20,000 |
| Loss Factor (LGD) | 80% | 55% |
| Expected Loss (EL) | £39,746.34 | £42.10 |
| Final Decision | 🚨 REJECT | ✅ APPROVE |

**Execution of code**
```python
# Sample 1: High Risk (Small Business - 80% LGD)
sample_business = {
    'int_rate': 24.5, 'loan_to_value': 0.95, 'ead': 50000,
    'interest_band': '20.0+', 'grade': 'G', 'collateral': 'No',
    'regularity_of_inflows': 'No', 'ltv_group': 'Critical', 
    'purpose': 'Small Business'
}

# Sample 2: Low Risk (Home Improvement - 55% LGD)
sample_home = {
    'int_rate': 6.2, 'loan_to_value': 0.35, 'ead': 20000,
    'interest_band': '5.0-7.5', 'grade': 'A', 'collateral': 'Yes',
    'regularity_of_inflows': 'Yes', 'ltv_group': 'Low', 
    'purpose': 'Home Improvement'
}

# Execution
print("Generating Risk Dashboards...")
predict_and_score_visual(sample_business, loaded_artifacts)
predict_and_score_visual(sample_home, loaded_artifacts)
```

<img width="383" height="724" alt="image" src="https://github.com/user-attachments/assets/8e5f0cec-589a-45ef-bec2-cc31d797a4d8" />

**Note:** Full implementation details, including model logic and visual dashboards, are available in: `LGD and EL computation.ipynb`
