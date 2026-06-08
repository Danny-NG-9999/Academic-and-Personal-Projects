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

## Key documents
Notebooks shown below:
L01 - A preprocessing notebook and feature engineering
L02 - A notebook on modelling probability of default (PD), delivering scorecard and calculating cutoff rate
L03 - A notebook on modelling loss given default (LGD), exposure at default (EAD) and expected loss (EL)
L04 - A notebook on checking population stability index
