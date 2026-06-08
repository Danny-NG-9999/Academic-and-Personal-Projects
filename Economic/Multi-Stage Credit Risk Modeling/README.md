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
- **ROC‑AUC = 0.77** – The model has good discriminatory power, correctly ranking a randomly selected defaulted borrower above a non‑defaulted borrower approximately 77% of the time. In retail credit risk modeling, an AUC above 0.75 is generally considered strong.
- **Gini Index = 0.53** – This indicates a meaningful separation between good and bad borrowers. A Gini above 0.50 is often viewed as a solid result for consumer lending portfolios.
- **KS Statistic = 0.40** – Demonstrates good differentiation between defaulting and non‑defaulting borrowers, as values above 0.30 are typically considered acceptable in the industry.
- **Recall = 0.72** – The model successfully identifies 72% of actual defaults.
- **Precision = 0.14** – Only 14% of borrowers predicted as defaults actually default. While low, this is expected in highly imbalanced portfolios, especially when utilizing class weights to prioritize risk detection over false alarms
- **F1 Score = 0.23** – The low F1 score is a direct result of the precision-recall imbalance, reflecting a deliberate modeling decision to prioritize catching defaults (high recall) at the expense of a higher false-alarm rate

### Loss Given Default (LGD) Model - Stage 1: Classweighted Logistic Regression
- **ROC-AUC = 0.72** – Indicates good ability to distinguish between accounts with no recovery and those with some recovery after default.  
- **Gini Index = 0.44** – Shows moderate predictive power
- **Recall = 0.84** – The model captures 84% of accounts that eventually experience recovery, a strong result for recovery identification.  
- **Precision = 0.48** – Nearly half (48%) of the accounts predicted to have recovery potential do yield recoveries. This represents a high-efficiency rate for a recovery classification framework.
- **F1 Score = 0.61** – Represents a balanced and practical model, confirming that Stage 1 effectively separates recovery and non‑recovery cases.  

### Loss Given Default (LGD) Model - Stage 2: Linear Regression (OLS)
- **MAE = 0.03** – On average, the model's predictions deviate from actual recovery rates by an average of just 3 percentage points. From a portfolio management perspective, this represents a highly acceptable margin of error. It allows the business to forecast aggregate recovery inflows with strong operational confidence.
- **RMSE = 0.05** – Since RMSE penalizes large mistakes more heavily than MAE, the fact that RMSE is only modestly higher than MAE suggests the model is not generating a large number of extreme prediction errors. This indicates reasonable stability and consistency across the recovery-rate distribution.
- **R² = 0.02** – The model explains only a small proportion of recovery-rate variability, reflecting the inherently unpredictable nature of post-default recoveries. Recovery outcomes depend on many unobserved factors not present in Lending Club's loan application data — such as legal actions, collection strategies, and borrower financial circumstances and broader economic conditions

Although the model has limited loan-level explanatory power, it produces low prediction errors and provides stable estimates of average recovery behaviour. Consequently, it is more valuable for portfolio-level LGD forecasting and Expected Loss estimation than for predicting exact recoveries on individual loans.

### EAD Model - Linear Regression (OLS)
- **MAE	= 0.08** - On average, the model’s predictions deviate from the true EAD by an average of 8 percentage points. This level of error is relatively low given the variability in borrower utilization behaviour prior to default.
- **RMSE = 0.12**	- The standard deviation of the residuals is 12%. Because this is higher than the MAE (0.08), it indicates that the model experiences occasional large errors (outliers) when predicting individual loans.
- **R² = 0.35** – The model explains 35% of the variation in exposure at default (EAD). This is a reasonably strong result for retail credit risk modeling. Unlike loss given default (LGD), EAD is more predictable because it depends on observable factors such as remaining loan balance, payment history, and credit utilization patterns.

## Model Performance: Test vs. Holdout Comparison
- **PD model generalises well** – ROC‑AUC difference is only 0.0039 (0.77 on both sets), indicating stable discriminatory power.
- **Recall increased on holdout** (0.72 → 0.79) – model catches more actual defaults on unseen data, which is positive for risk avoidance.
- **Precision dropped slightly** (0.14 → 0.13) – more false alarms on holdout, but acceptable given the recall gain.
- **F1‑score difference is small** (0.0165) – the trade‑off between recall and precision remains consistent.
- **LGD model errors are higher on holdout** – MAE rose from 0.046 to 0.058, RMSE from 0.057 to 0.080. This is expected because recovery outcomes are noisier and less predictable in new data.
- **Overall, both models perform robustly** – no severe overfitting; performance degradation is within reasonable limits for credit risk modeling.
