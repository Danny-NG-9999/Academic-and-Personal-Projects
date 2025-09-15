# Piotroski F-score analysis (JDW.L vs Peer in UK)
This project implements the Piotroski F-Score methodology to evaluate the financial strength of publicly traded companies. The analysis focuses on JD Wetherspoon plc (JDW.L) and benchmarks its performance against peers (DOM.L, MAB.L, SSPG.L) using historical financial statement data from 2021–2024, retrieved via the yfinance library.

The workflow includes downloading and cleaning financial statements, preparing the data, flagging potential issues, and interactively computing the F-Score. Results are then compared across the peer group for context.

The Piotroski F-Score is a 0–9 scale based on nine accounting criteria covering profitability, leverage, liquidity, and operating efficiency:

**Scoring Interpretation**
| **Total Score** | **Meaning**               |
| --------------- | ------------------------- |
| 8–9             | Very strong fundamentals  |
| 7               | Strong                    |
| 6               | Above average             |
| 5               | Neutral / mixed           |
| 4               | Below average             |
| 2–3             | Weak                      |
| 0–1             | Very weak / distress risk |



## Table of Contents
- [Installation Requirements](#installation-requirements)
- [Components of the Piotroski F-Score](#components-of-the-piotroski-f-score)
- [Features](#features)
- [Analysis of Ratios, Scores, and Outcome](#analysis-of-ratios-scores-and-outcome)
- [Disclaimer](#disclaimer)

## Installation Requirements
To use this notebook, you will need to install the following Python libraries.
* **pandas**: This is the primary tool for data manipulation. It allows the project to organize the financial data (like income statements and balance sheets) into easy-to-read tables called DataFrames, making it simple to analyze and calculate metrics.
* **numpy**: A foundational library for numerical computing. It's used here to perform mathematical calculations and to handle missing data points (represented as `NaN`).
* **yfinance**: A powerful tool that provides a direct connection to Yahoo! Finance. This library is crucial as it automatically downloads all the necessary financial statements (income, balance sheet, cash flow) for any company you specify.
* **matplotlib**: A versatile plotting library that creates the charts and visualizations in the notebook. It is used specifically to generate the bar chart comparing the Piotroski F-scores of your target company and its peers.
* **ipywidgets**: This library adds interactivity to your Jupyter Notebook. It creates the dynamic elements, such as dropdown menus, that allow you to select different stock tickers to analyze without having to edit the code.
* **difflib**: A standard Python library used for comparing sequences. In this project, it's used to "fuzzy match" the names of financial line items (e.g., matching "Total Revenue" even if it's slightly misspelled or has a different name in the raw data), making the code more robust.
* **IPython.display**: This module is essential for displaying various outputs directly within the Jupyter Notebook, such as the formatted DataFrames and interactive widgets.
* **plotnine**: This library is included for creating aesthetically pleasing plots based on the "Grammar of Graphics" (similar to R's ggplot2). While it may not be explicitly used in the final version of the code, it offers a powerful alternative for data visualization.

## Components of the Piotroski F-Score
The nine criteria are divided into three main categories: Profitability, Leverage/Liquidity, and Operating Efficiency. Here is a summary of each component and its interpretation:
**F-Score Components**
| **Category**                                  | **Signal**                | **Scoring Rule (1 = Pass, 0 = Fail)**                       | **Interpretation**                                |
| --------------------------------------------- | ------------------------- | ----------------------------------------------------------- | ------------------------------------------------- |
| **Profitability** (4)                         | Return on Assets (ROA)    | 1 if ROA > 0 (Net income ÷ Total Assets positive)           | A company is profitable and has positive earnings.|
|                                               | Operating Cash Flow (CFO) | 1 if CFO > 0                                                | Generated positive cash flow                      |
|                                               | Change in ROA             | 1 if ROA higher than prior year                             | Improving efficiency in using assets 	            |
|                                               | Accruals or CFO > NI)     | 1 if (CFO ÷ Total Assets) > (ROA ÷ Total Assets)            | Earnings quality strong (low accruals)            |
| **Leverage, Liquidity & Source of Funds** (3) | Change in Leverage        | 1 if long-term debt ratio lower than prior year             | Lower financial risk                              |
|                                               | Change in Current Ratio   | 1 if Current Ratio (CA ÷ CL) higher than prior year         | Better short-term liquidity                       |
|                                               | Change in Shares          | 1 if no new shares issued YoY                               | No shareholder dilution                           |
| **Operating Efficiency** (2)                  | Change in Gross Margin    | 1 if Gross Margin higher than prior year                    | Improved cost control / pricing power             |
|                                               | Change in Asset Turnover  | 1 if Asset Turnover (Sales ÷ Assets) higher than prior year | Assets used more efficiently                      |

## Features
1. **Automated Data Retrieval**  
   - Seamlessly downloads yearly financial statements (Income Statement, Balance Sheet, Cash Flow) from **Yahoo Finance** via the `yfinance` library.

2. **Robust Data Handling**  
   - Cleans and structures raw financial data.  
   - Supports **fuzzy string matching** to locate financial line items.  
   - Flags missing, zero, or invalid values for transparency.

3. **Interactive Query Tools**  
   - Jupyter notebook widgets enable dynamic selection of financial statements, on-demand F-Score computation, and quick inspection of null/NaN/zero values.
   - <img width="380" height="116" alt="image" src="https://github.com/user-attachments/assets/5a12537e-ea61-4a5c-abfe-b62a57d974d2" />

4. **Piotroski F-Score Calculation**  
   - Implements the full **nine-criteria Piotroski model**, scoring each year between 0–9 to evaluate financial strength.

5. **Peer Group Analysis**  
   - Benchmarks the target company’s F-Score against selected peers for comparative performance insights.

6. **Data Visualization**  
   - Produces clear and informative charts, including:  
     - **Trend charts** (year-over-year F-Score evolution)  
     - **Peer comparison charts** (average and individual F-Scores)


## Analysis of Ratios, Scores, and Outcome
JD Wetherspoon plc (JDW.L), a UK-based pub and hotel operator, faced significant challenges during 2021-2024 due to COVID-19 recovery, inflation, labor shortages, and rising energy costs in the hospitality sector. This period marks a transition from heavy losses in 2021 (pandemic lockdowns) to profitability recovery by 2022-2024, though with persistent high leverage and liquidity strains. Below, I analyzed key financial ratios, Piotroski F-Scores, and overall performance outcomes based on fiscal years ending July 31 (data sourced from Yahoo Finance and financial databases). All figures are in millions of GBP unless noted; ratios are percentages where applicable.

### 📈 Ratio Analysis for JDW.L (2021–2024)
Ratios highlight trends in profitability, efficiency, liquidity, and leverage.
| Ratio / Metric                  | 2021     | 2022     | 2023     | 2024     | Trend Analysis |
|---------------------------------|----------|----------|----------|----------|----------------|
| **ROA (Return on Assets)**      | -8.72%   | 0.96%    | 3.07%    | 2.56%    | Sharp recovery from 2021 losses to positive ROA by 2022, peaking in 2023 due to cost controls and sales growth. Slight 2024 dip reflects higher interest expenses amid inflation. Overall improvement indicates better asset utilization post-pandemic. |
| **Gross Margin**                | -9.32%   | 5.76%    | 5.76% (est)   | 5.76% (est)    | Negative in 2021 due to impairment charges and low revenue during lockdowns. Steady rise through 2024 shows pricing power and supply chain efficiencies, though still below pre-pandemic ~10–12% levels, pressured by food/beverage costs. |
| **Asset Turnover** *(Revenue / Avg. Total Assets)* | 0.38x    | 0.86x    | 0.99x    | 1.07x    | Low in 2021 from revenue collapse (assets underutilized). Doubled by 2022 as pubs reopened; continued gains in 2023–2024 reflect higher sales efficiency, a positive sign of operational recovery. |
| **Current Ratio**               | 0.27x    | 0.30x    | 0.41x    | 0.35x    | Consistently low (<1.0), typical for retail/hospitality with negative working capital. 2023 peak from better cash position; 2024 dip signals liquidity risks if sales slow, reliant on ongoing financing. |
| **Debt-to-Equity Ratio**        | 5.09x    | 4.37x    | 2.84x    | 2.83x    | Extremely high leverage throughout, reflecting debt-funded expansions. Debt reduction efforts evident but ongoing vulnerability to interest rate hikes. |
| **Inventory Turnover Ratio**    | 31.72    | 53.81    | 57.63    | 67.53    | Steadily rise from 31.72 in 2021 to 67.53 in 2024, showing stronger demand and efficient supply chain management. Higher turnover reduces holding costs and spoilage risk, a positive sign for a pub chain |
| **Days Sales in Inventory (DSI)** | 11.51   | 6.78     | 6.33     | 5.41     | Steadily fell from 11.5 days in 2021 to 5.4 in 2024, meaning JDW.L holds inventory for fewer days before selling → stronger cash flow, and reduced spoilage risk. |
| **Interest Coverage Ratio**     | -1.67    | 0.97     | 1.60     | 2.14     | Improving from negative in 2021 (inability to cover interest) to 2.14 in 2024, showing profitability recovery and reduced financial strain. Still moderate (<3.0) but far healthier post-2021. |
| **Debt Service Coverage Ratio (DSCR)** | -0.42 | 0.91     | 0.40     | 2.02     | Turned positive in 2022 after losses in 2021. By 2024, DSCR = 2.0, meaning operating income covers debt obligations twice over. Reflects strong cash flow, though earlier years show vulnerability. |

### Comparison of JDW.L F-Score to Peer Group
The peer group for JDW.L (J D Wetherspoon plc, a UK pub operator) consists of companies in the hospitality and food/beverage sector: DOM.L (Domino's Pizza Group plc, pizza franchise), MAB.L (Mitchells & Butlers plc, pub and restaurant operator), and SSPG.L (SSP Group plc, travel food and beverage concessions). All are listed on the London Stock Exchange (.L) and face similar challenges like inflation, labor costs, and consumer spending in the post-pandemic recovery.

**Piotroski F-Score Comparison by year (2022–2024)**
<img width="1193" height="638" alt="image" src="https://github.com/user-attachments/assets/5f217dff-75cb-4c4f-8e5a-c28c84d6b378" />

| Ticker   | 2022 | 2023 | 2024 | Trend Analysis |
|---------|-----:|-----:|-----:|----------------|
| **JDW.L** | 8.0 | 8.5 | 5.0 | Led the group in 2022–23, then a sharp drop in 2024 back to mid-range fundamentals — consistent with year-over-year slippage in several Piotroski signals despite still-solid operations. Highest volatility in the set. |
| **DOM.L** | 8.0 | 6.0 | 7.0 | Dip in 2023 then partial recovery in 2024; overall remains a steady, above-average profile with relatively low volatility. |
| **MAB.L** | 7.0 | 5.0 | 7.0 | U-shaped path: weaker 2023 followed by a full rebound to 7 in 2024. |
| **SSPG.L**| 5.0 | 7.0 | 6.0 | Clear improvement into 2023, slight easing in 2024; finishes mid-pack with stable, improving core signals. |


**Average Piotroski F-Score Comparison (2022–2024)**
<img width="994" height="638" alt="image" src="https://github.com/user-attachments/assets/3b5ebc31-86cf-4e6d-8f5f-be517afa0f7c" />

- JDW.L: Best average performer, but fundamentals weakened in 2024 — investors must weigh strong recovery momentum against recent deterioration.
  
- DOM.L: Nearly as strong, but more stable.
  
- MAB.L & SSPG.L: Improving but still lagging peers, indicating slower recovery trajectories.


## Disclaimer
This tool provides financial analysis for practical purposes only. It should not be considered as financial advice. Always conduct your own research and consult with a qualified financial advisor before making investment decisions.
