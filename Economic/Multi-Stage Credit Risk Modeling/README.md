# Basel-Aligned Multi-Stage Credit Risk Modeling Framework: Development and Application (White-Box model)

## Introduction
In modern lending, accurately measuring credit risk is essential for making smart lending decisions, managing portfolios, allocating capital, and meeting regulatory standards. This repository contains a production-grade credit risk framework designed around the Basel Committee’s Internal Ratings-Based (IRB) guidelines. While standard credit models usually stop after predicting whether a borrower will default, this framework goes a step further. It uses an integrated, multi-stage pipeline to analyze the entire risk lifecycle by breaking credit risk down into three industry-standard metrics

- **Probability of Default (PD):** A class-weighted model that calculates how likely a borrower is to default, using an optimized threshold (Youden's Index) to catch high-risk profiles early.
- **Loss Given Default (LGD):** A conditional two-stage model that activates only when a default occurs. It first estimates the likelihood of recovering zero money, and then uses a continuous regressor to forecast the actual recovery rate.
- **Exposure at Default (EAD):** A regression model that predicts exactly how much outstanding credit the borrower will owe at the moment they break their contract.By tying these three models together conditionally ($PD \times LGD \times EAD$), the system creates a comprehensive Expected Loss (EL) engine. This engine translates statistical probabilities into clear, real-world dollar loss projections across the loan portfolio.

## Context & Data Framework
This project develops and applies a Basel-aligned credit risk modeling framework using historical loan-level data from LendingClub, one of the largest peer-to-peer lending platforms in the United States. The analysis focuses on a specific portfolio vintage: loans originated between 2017 and 2018. This specific timeframe provides two distinct advantages for credit risk analysis:

- Macroeconomic Relevance: This period captures a unique market phase of steady consumer credit expansion followed by tightening monetary policies, making it a great environment to test how resilient our models are under changing economic conditions.
- Maturity Window: These cohorts have sufficient performance history to fully observe borrower outcomes (whether they paid in full or defaulted) and track long-term collections and recovery behavior.

By grounding the framework in this mature, real-world data window, the resulting models simulate the actual data pipelines and auditing standards required by institutional lending teams.

## Data Structure Overview
**Dataset:** Lending Club Loan Data
**Source:** https://www.kaggle.com/datasets/wordsforthewise/lending-club/data
**Observation Period:** 2017–2018
**Domain:** Consumer Lending and Credit Risk Analytics

### Original Dataset
The original Lending Club dataset comprises over 1.2 million loan records issued between 2007 and 2018, containing approximately 152 variables that capture borrower demographics, credit characteristics, loan attributes, repayment behavior, and recovery outcomes.

To develop and validate the Basel-aligned credit risk modeling framework, a representative sample of approximately 250,000 loans originated between 2017 and 2018 was extracted. Focusing on the most recent lending period ensures that the models are trained on borrower behavior and underwriting practices that are more reflective of contemporary credit risk conditions while maintaining a sufficiently large sample for robust statistical analysis.

| **Metric**                  | **Value**               |
| --------------------------- | ------------------------|
| Original Dataset Size       | ~1.2 Million Loans      |
| Original Feature Count      | 152 Columns             |
| Selected Observation Period | Jan-2017 to Dec-2018    |
| Working Sample Size         | ~250,000 Loans          |

### Data for Modelling and Feature Selection
A comprehensive data preparation process was performed prior to model development, including:
- Missing value treatment and data quality checks
- Feature engineering and business-driven variable creation
- Multicollinearity assessment using Variance Inflation Factor (VIF) and Condition Index (CI)
- Predictive power evaluation using Weight of Evidence (WoE) and Information Value (IV)
- Removal of redundant, highly correlated, and low-information variables

Following feature selection, the dataset was reduced from 152 variables to 34 highly predictive features suitable for multi-staged modeling. Details are presented below:
| **Feature**             | **Count**          |
| ----------------------- | -------------------|
| Numerical Features      | 25                 |
| Categorical Features    | 9                  |
| Total Selected Features | 34                 |

**Column breakdown**
| Column                        | Meaning                                                                                                           | Data Type   |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------|-------------|
| funded_amnt                   | Original loan amount funded by investors                                                                          | Numerical   |
| installment                   | Monthly loan repayment amount                                                                                     | Numerical   |
| total_acc                     | Total number of credit accounts currently held by the borrower                                                    | Numerical   |
| total_rev_hi_lim              | Total revolving credit limit available to the borrower                                                            | Numerical   |
| open_acc                      | Number of open credit accounts                                                                                    | Numerical   |
| revol_util                    | Revolving credit utilization rate                                                                                 | Numerical   |
| mths_since_issue_d            | Number of months since loan issuance                                                                              | Numerical   |
| all_util                      | Overall utilization rate across all credit lines                                                                  | Numerical   |
| fico_mean                     | Average FICO credit score of the borrower                                                                         | Numerical   |
| tot_cur_bal                   | Total current balance across all accounts                                                                         | Numerical   |
| pub_rec_bankruptcies          | Number of public bankruptcy records                                                                               | Numerical   |
| pub_rec                       | Number of derogatory public records                                                                               | Numerical   |
| mort_acc                      | Number of mortgage accounts                                                                                       | Numerical   |
| int_rate                      | Interest rate assigned to the loan                                                                                | Numerical   |
| mo_sin_rcnt_tl                | Months since the most recent credit account was opened                                                            | Numerical   |
| mo_sin_rcnt_rev_tl_op         | Months since the most recent revolving account was opened                                                         | Numerical   |
| mths_since_earliest_cr_line   | Months since the borrower's earliest credit line was opened                                                       | Numerical   |
| delinq_2yrs                   | Number of delinquencies within the last two years                                                                 | Numerical   |
| mths_since_last_delinq        | Months since the last delinquency event                                                                           | Numerical   |
| annual_inc                    | Reported annual income of the borrower                                                                            | Numerical   |
| inq_last_6mths                | Number of credit inquiries in the previous six months                                                             | Numerical   |
| dti                           | Debt-to-income ratio                                                                                              | Numerical   |
| emp_length                    | Length of employment (years)                                                                                      | Numerical   |
| recovery_rate                 | Proportion of the funded loan amount recovered after default through collections, repayments, or recovery actions | Numerical   |
| CCF                           | Measures the proportion of the committed credit exposure expected to be utilized at the time of default           | Numerical   |
| term                          | Loan repayment term (e.g., 36 or 60 months)                                                                       | Categorical |
| grade                         | Lending Club assigned credit grade                                                                                | Categorical |
| sub_grade                     | Detailed sub-grade within each credit grade                                                                       | Categorical |
| home_ownership                | Home ownership status of the borrower                                                                             | Categorical |
| verification_status           | Income verification status                                                                                        | Categorical |
| purpose                       | Declared purpose of the loan                                                                                      | Categorical |
| initial_list_status           | Initial listing status of the loan                                                                                | Categorical |
| application_type              | Individual or joint loan application                                                                              | Categorical |
| int_rate_tier                 | Interest rate band or tier derived from loan pricing                                                              | Categorical |

The final feature set captures key dimensions of borrower creditworthiness, indebtedness, repayment capacity, credit history, and loan structure. These variables serve as the foundation for developing the Probability of Default (PD), Loss Given Default (LGD), Exposure at Default (EAD), and Expected Loss (EL) models within the Basel-aligned credit risk framework.

### Data for holdout testing
To assess the robustness and generalizability of the developed models, an independent holdout dataset comprising 50,000 loans was extracted from the same observation period (January 2017 to December 2018).

This dataset was completely excluded from the model development process, including feature selection, training, validation, and hyperparameter tuning. As a result, it serves as an unbiased benchmark for evaluating model performance on previously unseen data.

The holdout sample was used to assess the stability and predictive accuracy of the Probability of Default (PD), Loss Given Default (LGD), Exposure at Default (EAD), and Expected Loss (EL) models. Comparing performance metrics between the development dataset and the holdout dataset provides insight into the models' ability to generalize to new lending portfolios and helps identify potential overfitting or performance degradation.

## Project Notebooks
| Notebook                                                                                       | Description                                                                                                                                                                  |
| ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **N01 – Data Preprocessing and Feature Engineering for Credit Risk Modeling**                  | Data acquisition, cleaning, Exploratory Data Analysis (EDA), feature engineering, and variable selection using VIF, Condition Index (CI), Weight of Evidence (WoE), and Information Value (IV). |
| **N02 – Probability of Default (PD) Modeling and Credit Scorecard Development**                | Development of the Probability of Default model, scorecard construction, model evaluation, calibration, and performance assessment.                                                  |
| **N03 – Loss Given Default (LGD), Exposure at Default (EAD), and Expected Loss (EL) Modeling** | Development of Basel-aligned LGD and EAD models, integration of risk parameters, and construction of the Expected Loss framework.                                                    |
| **N04 – Holdout Validation and Comparative Model Performance Assessment**                      | Independent out-of-sample validation using a holdout dataset to evaluate model robustness, stability, and generalization performance.                                                |

## Model performances
<img width="984" height="578" alt="image" src="https://github.com/user-attachments/assets/f126b37c-02d3-48bd-b7b4-0be3c79510b2" />

### Probability of Default (PD) Model - Class-Weighted Logistic Regression

- **ROC-AUC = 0.77**
  - The model has good discriminatory power.
  - It can correctly rank a randomly selected defaulted borrower above a non‑defaulted borrower approximately 77% of the time.
  - In retail credit risk modeling, an AUC above 0.75 is generally considered strong.

- **Gini Index = 0.53**
  - Indicates a meaningful separation between good and bad borrowers.
  - A Gini above 0.50 is often viewed as a solid result for consumer lending portfolios.

- **KS Statistic = 0.40**
  - Demonstrates good differentiation between defaulting and non‑defaulting borrowers.
  - Values above 0.30 are typically considered acceptable in the industry.

- **Recall = 0.72**
  - The model successfully identifies 72% of actual defaults.

- **Precision = 0.14**
  - Only 14% of borrowers predicted as defaults actually default.

- **F1 Score = 0.23**
  - Reflects the trade‑off between high recall and low precision.
  - The model prioritizes capturing defaults rather than minimizing false alarms.

- **ROC‑AUC = 0.77** – The model has good discriminatory power, correctly ranking a randomly selected defaulted borrower above a non‑defaulted borrower approximately 77% of the time. In retail credit risk modeling, an AUC above 0.75 is generally considered strong.

- **Gini Index = 0.53** – This indicates a meaningful separation between good and bad borrowers. A Gini above 0.50 is often viewed as a solid result for consumer lending portfolios.

- **KS Statistic = 0.40** – Demonstrates good differentiation between defaulting and non‑defaulting borrowers, as values above 0.30 are typically considered acceptable in the industry.

- **Recall = 0.72** – The model successfully identifies 72% of actual defaults.

- **Precision = 0.14** – Only 14% of borrowers predicted as defaults actually default.

- **F1 Score = 0.23** – Reflects the trade‑off between high recall and low precision; the model prioritizes capturing defaults rather than minimizing false alarms.

- 
### Loss given default (LGD) Model - Stage 1: Classweighted Logistic Regression


0	Optimal Threshold	0.42
1	Youden's Index	0.33
2	ROC-AUC	0.72
3	F1 Score	0.61
4	Recall	0.84
5	Precision	0.48
0	ROC-AUC Score	0.72
1	Gini Index	0.44

Stage 2 Model: Linear Regression (OLS)
	Model	MAE	MSE	RMSE	R2
0	OLS	0.03	0.00	0.05	0.02

LGD Model: Linear Regression (OLS)

Metric	Value
0	Mean Actual LGD	0.96
1	Mean Predicted LGD	0.95
2	Mean Absolute Error (MAE)	0.05
3	Mean Squared Error (MSE)	0.00
4	Root Mean Squared Error (RMSE)	0.06
5	R² Coefficient of Determination	0.03
6	Systemic Bias (Mean Residual)	0.01






Exposure at default (EAD)
Model: Linear regression
Metric: Accuracy: 0.658
