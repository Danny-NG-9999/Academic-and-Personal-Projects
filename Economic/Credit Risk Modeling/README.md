## **Project Overview**
This project develops an advanced credit risk assessment framework designed to estimate borrower default risk with high accuracy and translate it into credit scores based on customer profiles. The analysis uses a large dataset of approximately 400,000 observations and 23 variables covering borrower demographics, employment history, socioeconomic indicators, and detailed loan characteristics such as loan-to-value (LTV), interest rates, and collateral information. This comprehensive data foundation supports robust, data-driven credit decision-making.

To model default risk effectively, a dual-modelling strategy is applied to balance interpretability and predictive performance. A transparent White Box model (Logistic Regression) is used to ensure explainability and regulatory compliance, while Black Box ensemble models such as XGBoost, Random Forest, and Gradient Boosting capture complex, non-linear relationships and interaction effects in borrower behaviour to improve predictive accuracy.

The modelling pipeline includes rigorous preprocessing steps such as missing value treatment, outlier handling, and variable transformation. Feature engineering and selection are performed using Weight of Evidence (WoE) encoding and Information Value (IV) metrics to ensure predictive strength, monotonicity, and interpretability. To ensure the model performs reliably in real-world applications, a triple-split validation framework (Train, Test, and Holdout datasets) is implemented. This approach enables robust out-of-sample evaluation, confirming that model performance is not only strong on training and test data but also generalises well to unseen data. 

Beyond Probability of Default (PD) modelling, the framework is extended to include Loss Given Default (LGD) and Exposure at Default (EAD), enabling the computation of Expected Loss (EL). This provides a full portfolio-level view of credit risk and supports more informed risk management and capital allocation decisions. Overall, the project progresses through three stages: data preprocessing and feature selection, PD modelling using both interpretable and ensemble methods, and final credit risk quantification through LGD, EAD, and credit score derivation.

## **Model Objectives**
The primary objective of this project is to build a high-performance classification system that accurately distinguishes between "Good" and "Bad" (default) loan applicants. The specific goals include:
- **Risk Quantification:** Develop a probability-of-default (PD) score for each applicant to facilitate tiered risk management.
- **Explainability (White Box):** Implement interpretable models (such as Logistic Regression) to satisfy regulatory compliance and provide clear "reason codes" for loan denials or approvals.
- **Predictive Discrimination (Black Box Modelling):** Apply advanced machine learning algorithms such as XGBoost and Random Forest to effectively capture complex non-linear relationships and interaction effects between variables, thereby understanding the model’s ability to accurately distinguish between good and bad credit risk.
- **Feature Robustness and Stability:** Identify and validate key predictive drivers to ensure strong predictive performance and consistency across different data segments. This is reinforced through triple-split validation (Train, Test, and Holdout), ensuring that feature behaviour remains stable and generalises reliably across time and population subgroups.
- **Decision Support:** Deliver a scalable and efficient credit risk tool that streamlines underwriting processes, reduces reliance on manual decision-making, and improves risk management by minimising exposure to non-performing loans (NPLs) through more accurate and consistent credit assessments.

## **Data Sources and Structure**
The dataset is designed to replicate realistic borrower profiles within the UK consumer credit market, representative of a private banking institution such as Lloyds. It captures the interaction between demographic, financial, and behavioural factors that collectively influence creditworthiness. The synthetic structure is intentionally constructed to reflect economically plausible relationships; for example, higher interest rates and unstable or insufficient income streams are associated with an increased probability of default.

- **Dataset Name:** `credit_loan_dataset.csv`
- **Type:** Synthetic dataset, constructed based on UK consumer lending research and realistic credit risk structures typical of private UK banks
- **Number of Observations:** 400,000 records

- **Key Features:**

| Category        | Column Name                 | Description                                                                 | Predictive Value / Information Provided |
|----------------|-----------------------------|-----------------------------------------------------------------------------|------------------------------------------|
| Demographics   | person_age                  | Age of the applicant.                                                       | Helps identify life-stage risk and age-based credit patterns. |
| Demographics   | gender                      | Gender of the borrower.                                                     | Demographic identifier for segmentation analysis. |
| Demographics   | marriage_status             | Marital status (e.g., Single, Married).                                    | Often used as a proxy for financial stability or shared obligations. |
| Employment     | annual_inc                 | Total gross annual income.                                                  | Primary indicator of the borrower's capacity to repay. |
| Employment     | emp_length                 | Years in current employment.                                                | Measures career stability and consistency of income. |
| Employment     | emp_title                  | Job title or profession.                                                    | Identifies high-risk or stable industries (e.g., Teacher vs. Freelancer). |
| Financials     | home_ownership             | Type of tenure (RENT, MORTGAGE, OWN).                                      | Indicates asset backing and existing monthly housing overhead. |
| Financials     | addr_cities                | Residential city of the borrower.                                           | Captures regional economic factors or cost-of-living variances. |
| Financials     | fixed_obligation           | Total monthly non-loan expenses.                                            | Essential for calculating residual income after living costs. |
| Credit History  | mths_since_earliest_cr_line | Age of the borrower's credit history.                                      | Measures credit maturity; longer history usually implies lower risk. |
| Credit History  | existing_loans             | Boolean flag for other active loans.                                        | Indicates existing debt burden and credit appetite. |
| Credit History  | existing_emi               | Monthly installment for current debts.                                      | Directly impacts the Debt-to-Income (DTI) ratio. |
| Loan Details   | loan_amount                | Total principal requested.                                                  | The total exposure at risk for the lender. |
| Loan Details   | term                       | Length of the loan (in months).                                            | Determines the repayment horizon and interest sensitivity. |
| Loan Details   | int_rate                   | Annual interest rate percentage.                                            | Reflects the risk premium assigned to the borrower. |
| Loan Details   | interest_band              | Binned ranges of interest rates.                                            | Used for categorical analysis in the White Box model. |
| Loan Details   | grade                      | Internal risk rating (e.g., A, B, C, D).                                   | The bank's synthetic assessment of borrower quality. |
| Loan Details   | loan_to_value             | (LTV) Ratio of loan to asset value.                                         | Measures the "skin in the game" and collateral adequacy. |
| Loan Details   | collateral                | Flag for pledged assets.                                                    | Provides a secondary source of repayment in case of default. |
| Loan Details   | regularity_of_inflows     | Consistency of monthly income.                                              | Validates the reliability of the capacity to repay. |
| Target         | default_status            | Binary indicator (0 = Good, 1 = Bad).                                      | The target variable for PD (Probability of Default) modeling. |


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
