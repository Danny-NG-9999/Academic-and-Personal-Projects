# Basel-Aligned Multi-Stage Credit Risk Modeling Framework: Development and Application (White-Box model)

## Introduction
In modern lending, accurately measuring credit risk is essential for making smart lending decisions, managing portfolios, allocating capital, and meeting regulatory standards. This repository contains a production-grade credit risk framework designed around the Basel Committee’s Internal Ratings-Based (IRB) guidelines. While standard credit models usually stop after predicting whether a borrower will default, this framework goes a step further. It uses an integrated, multi-stage pipeline to analyze the entire risk lifecycle by breaking credit risk down into three industry-standard metrics

- Probability of Default (PD): A class-weighted model that calculates how likely a borrower is to default, using an optimized threshold (Youden's Index) to catch high-risk profiles early.
- Loss Given Default (LGD): A conditional two-stage model that activates only when a default occurs. It first estimates the likelihood of recovering zero money, and then uses a continuous regressor to forecast the actual recovery rate.
- Exposure at Default (EAD): A regression model that predicts exactly how much outstanding credit the borrower will owe at the moment they break their contract.By tying these three models together conditionally ($PD \times LGD \times EAD$), the system creates a comprehensive Expected Loss (EL) engine. This engine translates statistical probabilities into clear, real-world dollar loss projections across the loan portfolio.

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
The original Lending Club dataset contains over 1.2 million loan records and approximately 152 variables spanning borrower characteristics, loan attributes, payment performance, and recovery information.

For this project, a representative sample of approximately 250,000 loans originated between 2017 and 2018 was extracted to construct and validate the credit risk modeling framework.

| **Metric**                  | **Value**               |
| --------------------------- | ------------------------|
| Original Dataset Size       | ~1.2 Million Loans      |
| Original Feature Count      | 152 Columns             |
| Selected Observation Period | Jan-2017 to Dec-2018    |
| Working Sample Size         | ~250,000 Loans          |


### Data Cleaning and Feature Selection

A comprehensive data preparation process was performed prior to model development, including:

Missing value treatment and data quality checks
Feature engineering and business-driven variable creation
Multicollinearity assessment using Variance Inflation Factor (VIF) and Condition Index (CI)
Predictive power evaluation using Weight of Evidence (WoE) and Information Value (IV)
Removal of redundant, highly correlated, and low-information variables
- **Source:** [Lending Club loan data from Kaggle](https://www.kaggle.com/datasets/wordsforthewise/lending-club/data)

**Original Dataset**
- Initial Size: ~250,000 records between 2017-2018 (out of 1.2 million records) with 152 columns initially

**Cleaned Dataset**
- Cleaned Size: ~250,000 records between 2017-2018 with 32 columns after cleaning and feature selection processing using VIF, CI, WOE and IV. Following Weight of Evidence (WoE) transformation and Information Value (IV) analysis, a total of **32 predictive features** were retained for model development, consisting of **23 numerical variables** and **9 categorical variables**.


Final Feature Selection & Schema Dictionary
| **Column**                  | **Meaning**                                                    | **Data Type** |
| --------------------------- | -------------------------------------------------------------- | ------------- |
| funded_amnt                 | Original loan amount funded by investors                       | Numerical     |
| installment                 | Monthly loan repayment amount                                  | Numerical     |
| total_acc                   | Total number of credit accounts currently held by the borrower | Numerical     |
| total_rev_hi_lim            | Total revolving credit limit available to the borrower         | Numerical     |
| open_acc                    | Number of open credit accounts                                 | Numerical     |
| revol_util                  | Revolving credit utilization rate                              | Numerical     |
| mths_since_issue_d          | Number of months since loan issuance                           | Numerical     |
| all_util                    | Overall utilization rate across all credit lines               | Numerical     |
| fico_mean                   | Average FICO credit score of the borrower                      | Numerical     |
| tot_cur_bal                 | Total current balance across all accounts                      | Numerical     |
| pub_rec_bankruptcies        | Number of public bankruptcy records                            | Numerical     |
| pub_rec                     | Number of derogatory public records                            | Numerical     |
| mort_acc                    | Number of mortgage accounts                                    | Numerical     |
| int_rate                    | Interest rate assigned to the loan                             | Numerical     |
| mo_sin_rcnt_tl              | Months since the most recent credit account was opened         | Numerical     |
| mo_sin_rcnt_rev_tl_op       | Months since the most recent revolving account was opened      | Numerical     |
| mths_since_earliest_cr_line | Months since the borrower's earliest credit line was opened    | Numerical     |
| delinq_2yrs                 | Number of delinquencies within the last two years              | Numerical     |
| mths_since_last_delinq      | Months since the last delinquency event                        | Numerical     |
| annual_inc                  | Reported annual income of the borrower                         | Numerical     |
| inq_last_6mths              | Number of credit inquiries in the previous six months          | Numerical     |
| dti                         | Debt-to-income ratio                                           | Numerical     |
| emp_length                  | Length of employment (years)                                   | Numerical     |
| term                        | Loan repayment term (e.g., 36 or 60 months)                    | Categorical   |
| grade                       | Lending Club assigned credit grade                             | Categorical   |
| sub_grade                   | Detailed sub-grade within each credit grade                    | Categorical   |
| home_ownership              | Home ownership status of the borrower                          | Categorical   |
| verification_status         | Income verification status                                     | Categorical   |
| purpose                     | Declared purpose of the loan                                   | Categorical   |
| initial_list_status         | Initial listing status of the loan                             | Categorical   |
| application_type            | Individual or joint loan application                           | Categorical   |
| int_rate_tier               | Interest rate band or tier derived from loan pricing           | Categorical   |

### Feature Summary

| Feature Category     | Count  |
| -------------------- | ------ |
| Numerical Features   | 23     |
| Categorical Features | 9      |
| **Total Features**   | **32** |


Key Variables: Property characteristics (e.g. size, rooms, condition, etc.), location details (e.g. city, statezip, etc.), temporal information (e.g. sale date, year built, year renovated), and sale price.


## Key documents
Notebooks shown below:
L01 - A preprocessing notebook and feature engineering
L02 - A notebook on modelling probability of default (PD), delivering scorecard and calculating cutoff rate
L03 - A notebook on modelling loss given default (LGD), exposure at default (EAD) and expected loss (EL)
L04 - A notebook on checking population stability index
