## **Project Overview**
This project develops an advanced credit risk assessment framework designed to estimate borrower default risk with high accuracy and translate it into credit scores based on customer profiles. The analysis uses a large dataset of approximately 400,000 observations and 23 variables covering borrower demographics, employment history, socioeconomic indicators, and detailed loan characteristics such as loan-to-value (LTV), interest rates, and collateral information. This comprehensive data foundation supports robust, data-driven credit decision-making.

To model default risk effectively, a dual-modelling strategy is applied to balance interpretability and predictive performance. A transparent White Box model (Logistic Regression) is used to ensure explainability and regulatory compliance, while Black Box ensemble models such as XGBoost, Random Forest, and Gradient Boosting capture complex, non-linear relationships and interaction effects in borrower behaviour to improve predictive accuracy.

The modelling pipeline includes rigorous preprocessing steps such as missing value treatment, outlier handling, and variable transformation. Feature engineering and selection are performed using Weight of Evidence (WoE) encoding and Information Value (IV) metrics to ensure predictive strength, monotonicity, and interpretability. To ensure the model performs reliably in real-world applications, a triple-split validation framework (Train, Test, and Holdout datasets) is implemented. This approach enables robust out-of-sample evaluation, confirming that model performance is not only strong on training and test data but also generalises well to unseen data. 

Beyond Probability of Default (PD) modelling, the framework is extended to include Loss Given Default (LGD) and Exposure at Default (EAD), enabling the computation of Expected Loss (EL). This provides a full portfolio-level view of credit risk and supports more informed risk management and capital allocation decisions. Overall, the project progresses through three stages: data preprocessing and feature selection, PD modelling using both interpretable and ensemble methods, and final credit risk quantification through LGD, EAD, and credit score derivation.

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
|----------------|-----------------------------|-----------------------------------------------------------|
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
  
