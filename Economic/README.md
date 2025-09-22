# FTSE 100 Time-Series Econometrics & Forecasting

A full, end-to-end econometric analysis of the **FTSE 100 index** with peer benchmarks (CAC 40, DAX, SMI) from **1985-01-01 to 2024-12-31**.  
The project demonstrates a professional workflow for financial time-series: data engineering, exploratory analysis, stationarity testing, cointegration & causality, ARIMA forecasting, and volatility modeling with GARCH — all wrapped in clear diagnostics and evaluation.

---

## 📝 Executive Summary
This project provides a **comprehensive econometric assessment** of the FTSE 100 index.  
Key findings include:  
- **Strong correlations** exist across European indices, with limited evidence of **cointegration**.  
- **Lead–lag causality** detected (e.g., SMI → CAC, CAC → DAX).  
- **ARIMA(2,1,1)** produced the best FTSE forecasts with **MAPE ≈ 3.8%**.  
- **GARCH(1,1)** confirmed **volatility clustering and persistence** typical of equity markets.  

---

## 📑 Table of Contents
1. [Project Overview](#-project-overview)  
2. [Dataset](#-dataset)  
3. [Methodology](#-methodology)  
4. [Key Results](#-key-results)
   - [Return (FTSE100)](#return-ftse100)
   - [Return distribution versus Peers](#return-distribution-versus-peers)
   - [Rolling 1-year Volatility](#rolling-1-year-volatility)
   - [Correlations](#correlations)  
   - [Stationarity (ADF Tests)](#stationarity-adf-tests)  
   - [Cointegration](#cointegration-englegranger)  
   - [Granger Causality](#granger-causality-δclose-aic-lags)  
   - [ARIMA Model Selection](#arima-model-selection)
   - [ARIMA(2,1,1) Results — FTSE100 (UK)](#arima-2,1,1-results-ftse100-uk)
   - [Volatility (GARCH11) — FTSE100](#volatility-garch11-ftse100)
   - [Forecast Evaluation](#forecast-evaluation)  


---

## 🌍 Project Overview
Financial time series are central to both academic research and applied finance. This project applies **advanced econometric methods** to the **FTSE 100 index**, placing it in context with major European peers (CAC 40, DAX, SMI).  

The objectives were:  
- **Characterize** FTSE 100 dynamics in levels, differences, and returns.  
- **Test** for integration, cointegration, and cross-market dependencies.  
- **Model** short-term dynamics using ARIMA and validate forecast accuracy.  
- **Capture volatility clustering** using GARCH(1,1) models.  
- **Communicate insights** through tables, diagnostics, and professional-quality plots.  

---

💡 Interpretation & Takeaways
- Strong contemporaneous correlation with CAC/DAX/SMI; some lead–lag causality across continental indices but limited cointegration
- ARIMA(2,1,1) for FTSE provides solid forecasts (MAPE ≈ 3.8%).
- GARCH(1,1) confirms volatility clustering & persistence typical of equity indices.

---

## 📦 Dataset
- **Source:** Yahoo Finance (`^FTSE`, plus peers: `^FCHI` CAC 40, `^GDAXI` DAX, `^SSMI` SMI)  
- **Period:** 1985-01-01 → 2024-12-31  
- **Frequency:** Daily 

---

## 🔎 Methodology
1. **Data ingestion & cleaning**: completeness checks, type coercion, date index, NA handling.  
2. **Exploratory analysis**: level/return plots, ACF/PACF, correlation matrix.  
3. **Stationarity tests**: ADF on levels, differences, and returns (AIC & BIC lag selection).  
4. **Long-run relationships**: Engle–Granger cointegration tests.  
5. **Lead–lag dynamics**: pairwise Granger causality on ΔClose.  
6. **Univariate forecasting**: ARIMA orders via information criteria; walk-forward evaluation.  
7. **Volatility modeling**: GARCH(1,1) on returns; persistence & clustering assessment.  
8. **Model diagnostics**: residual ACF/PACF, Ljung–Box, JB normality.  

---

## 📈 Key Results
### Return (FTSE100)
<img width="1990" height="1380" alt="image" src="https://github.com/user-attachments/assets/14e27124-fe3d-4774-9ecd-a8688e556150" />

- The top plot shows simple returns (% change in price from day to day).
- The bottom plot shows log returns, which are mathematically smoother and preferred in financial modeling because they are time-additive.
- Both series look very similar, but log returns slightly compress extreme values, making them more stable for statistical analysis.
- Both charts show that returns are roughly symmetric around zero — positive and negative changes occur with similar frequency.
- There are both positive (market surges) and negative (market crashes) outliers. However, the negative outliers tend to be larger in magnitude — showing that markets “fall faster than they rise” → extreme events happen more often than a normal distribution would predict (fat tails).

### Return distribution versus Peers
<img width="1989" height="1180" alt="image" src="https://github.com/user-attachments/assets/f604de4d-c244-43a7-98ee-d0bcb4771a05" />

- All four indices have fat-tailed, peaked distributions → financial markets are prone to extreme events.
- The mean daily return is very close to zero for all indices (≈0.01–0.02%). The median is also near zero, slightly higher than the mean, showing returns are balanced but small. This reflects the fact that while stock markets rise in the long term, on a daily basis, returns fluctuate randomly around zero.
- Symmetry shows gains and losses are roughly balanced.
- VaR highlights downside risk: Germany (−2.32%) and France (−2.19%) face larger tail losses than the UK (−1.80%) and Switzerland (−1.75%).

### Rolling 1-year Volatility
<img width="1589" height="778" alt="image" src="https://github.com/user-attachments/assets/2680bffa-e404-4e50-b24a-3d4a4871a77a" />

- Crises line up in time. Peaks appear around the same dates for all indices, showing global or regional shocks move European markets together.
- Mean reversion. After each spike, volatility gradually sinks back toward a lower “normal” level.
- DAX (Germany): Consistently the most volatile of the four. Peaks tend to be the highest (e.g., ~3% daily vol in crisis years).
- CAC 40 (France): High as well, often just below DAX, with very similar timing of spikes.
- FTSE 100 (UK): Moderate volatility overall; noticeable extra bump around 2016 (Brexit) and again in 2020–2022.
- SMI (Switzerland): Lowest and most stable of the group.

### Correlations
<img width="963" height="823" alt="image" src="https://github.com/user-attachments/assets/22197e69-16da-4f95-a0f9-c68ab4875a9b" />

- Correlations are high across the board (≈0.78–0.89) → European markets tend to move together.
- SMI (Switzerland) shows the lowest average correlations with others (~0.78–0.81), making it the best diversifier within this group—but benefits are still limited.

---

### Stationarity (ADF Tests)
| # | Series             | Variant         | ADF stat (AIC) | p-value (AIC) | Lags (AIC) | Nobs (AIC) | Classification (AIC)         | ADF stat (BIC) | p-value (BIC) | Lags (BIC) | Nobs (BIC) | Classification (BIC)         |
|---|--------------------|-----------------|----------------|---------------|------------|------------|-------------------------------|----------------|---------------|------------|------------|-------------------------------|
| 1 | CAC 40 (France)    | Close Prices    | -1.644         | 0.460         | 6          | 6918       | Non-stationary (unit root)    | -1.799         | 0.381         | 0          | 6924       | Non-stationary (unit root)    |
| 2 | CAC 40 (France)    | ΔClose Prices   | -35.861        | 0.000         | 5          | 6918       | Stationary                    | -84.457        | 0.000         | 0          | 6923       | Stationary                    |
| 3 | DAX (Germany)      | Close Prices    | 0.270          | 0.976         | 0          | 6924       | Non-stationary (unit root)    | 0.270          | 0.976         | 0          | 6924       | Non-stationary (unit root)    |
| 4 | DAX (Germany)      | ΔClose Prices   | -83.884        | 0.000         | 0          | 6923       | Stationary                    | -83.884        | 0.000         | 0          | 6923       | Stationary                    |
| 5 | FTSE 100 (UK)      | Close Prices    | -1.952         | 0.308         | 7          | 6917       | Non-stationary (unit root)    | -2.219         | 0.200         | 0          | 6924       | Non-stationary (unit root)    |
| 6 | FTSE 100 (UK)      | ΔClose Prices   | -32.764        | 0.000         | 6          | 6917       | Stationary                    | -51.448        | 0.000         | 2          | 6921       | Stationary                    |
| 7 | SMI (Switzerland)  | Close Prices    | -1.259         | 0.648         | 6          | 6918       | Non-stationary (unit root)    | -1.384         | 0.590         | 0          | 6924       | Non-stationary (unit root)    |
| 8 | SMI (Switzerland)  | ΔClose Prices   | -36.201        | 0.000         | 5          | 6918       | Stationary                    | -81.430        | 0.000         | 0          | 6923       | Stationary                    |

---

### Cointegration (Engle–Granger)
| Pair              | EG Stat | p-value | Result |
|-------------------|---------|---------|--------|
| FTSE 100 – DAX    | −3.274  | 0.058   | Not cointegrated (5%) |

---

### Granger Causality (ΔClose, AIC Lags)
<img width="664" height="570" alt="image" src="https://github.com/user-attachments/assets/7135de47-827f-49f2-98c5-2727d55495f4" />

| Cause            | Effect          | Lag | Min p-value | Significance | All p-values                                                                 |
|------------------|-----------------|-----|-------------|--------------|----------------------------------------------------------------------------|
| SMI (Switzerland) | CAC 40 (France) | 6   | 0.0002      | ***          | [0.0212, 0.0002, 0.0005, 0.0003, 0.0007, 0.0013]                           |
| CAC 40 (France)  | DAX (Germany)   | 6   | 0.0022      | ***          | [0.0022, 0.0061, 0.0054, 0.0163, 0.0063, 0.0095]                           |
| SMI (Switzerland) | DAX (Germany)   | 22  | 0.0077      | ***          | [0.7691, 0.0224, 0.054, 0.0963, 0.1475, 0.2174]                            |
| DAX (Germany)    | SMI (Switzerland)| 22  | 0.0355      | **           | [0.3735, 0.0506, 0.0509, 0.09, 0.1022, 0.0767]                             |
| SMI (Switzerland) | FTSE 100 (UK)   | 6   | 0.0381      | **           | [0.71, 0.1854, 0.0685, 0.085, 0.0381, 0.0425]                              |
| FTSE 100 (UK)    | CAC 40 (France) | 6   | 0.0400      | **           | [0.0692, 0.0834, 0.04, 0.044, 0.057, 0.0737]                               |
| CAC 40 (France)  | FTSE 100 (UK)   | 6   | 0.0660      | *            | [0.1237, 0.1452, 0.066, 0.1135, 0.16, 0.1546]                              |
| DAX (Germany)    | CAC 40 (France) | 6   | 0.0712      | *            | [0.0902, 0.2244, 0.3861, 0.5107, 0.3024, 0.0712]                           |
| CAC 40 (France)  | SMI (Switzerland)| 6   | 0.1023      |              | [0.4655, 0.1469, 0.1023, 0.1218, 0.2951, 0.3554]                           |
| DAX (Germany)    | FTSE 100 (UK)   | 6   | 0.1112      |              | [0.5652, 0.1798, 0.1779, 0.3126, 0.2658, 0.1112]                           |
| FTSE 100 (UK)    | DAX (Germany)   | 6   | 0.1325      |              | [0.6616, 0.341, 0.1325, 0.2524, 0.2701, 0.3071]                            |
| FTSE 100 (UK)    | SMI (Switzerland)| 6   | 0.1915      |              | [0.7366, 0.6256, 0.1915, 0.3466, 0.43, 0.576]                              |

Strongest causal drivers:
- SMI (Switzerland) → CAC 40 (France) (p = 0.000) ***
- SMI (Switzerland) → FTSE 100 (UK) (p = 0.038) **
- SMI (Switzerland) → DAX (Germany) (p = 0.008) ***
👉 The Swiss index acts as an early mover, providing predictive signals for France, the UK, and Germany.

CAC 40 (France) as a transmitter:
- CAC 40 → DAX (p = 0.002) ***
- CAC 40 → FTSE 100 (p = 0.040) **
👉 The French index also plays a central role, especially influencing Germany.

DAX (Germany):
- DAX → SMI (p = 0.035) **
- DAX → CAC 40 (p = 0.071) * (weaker evidence)
👉 The German index both receives signals (from CAC, SMI) and feeds back (to SMI, weakly to CAC).

FTSE 100 (UK):
- FTSE 100 → CAC 40 (p = 0.040) **
- No strong predictive influence on Germany or Switzerland.
👉 The UK shows limited spillovers, more of a follower than a leader.

---

### ARIMA Model Selection
| Index        | Best ARIMA(p,d,q) | AIC        |
|--------------|-------------------|------------|
| FTSE 100     | (2,1,1)           | 77,295.50  |
| DAX          | (0,1,1)           | 85,006.26  |
| CAC 40       | (0,1,2)           | 76,636.63  |
| SMI          | (2,1,1)           | 80,950.86  |

### ARIMA(2,1,1) Results — FTSE100 (UK)
<img width="1389" height="985" alt="image" src="https://github.com/user-attachments/assets/04377c37-41fa-4ed0-a783-f0357714d2b2" />

<img width="503" height="306" alt="image" src="https://github.com/user-attachments/assets/8f6779ce-4e4f-46a8-9dec-6f541c6b0e0f" />

| Parameter | Estimate | Significance       | Interpretation                                                               |
| --------- | -------- | ------------------ | ---------------------------------------------------------------------------- |
| AR(1)     | –0.019   | Significant        | Slight negative short-term autocorrelation.                                  |
| AR(2)     | –0.036   | Significant        | Weak additional negative dependence at lag 2.                                |
| MA(1)     | +0.985   | Highly significant | Strong moving-average component — shocks carry forward into the next period. |
| Sigma²    | 4,124    | Significant        | High variance of shocks, consistent with daily equity market volatility.     |

- Observed vs Fitted: The fitted values track the mean dynamics of FTSE 100 differences but fail to capture extreme spikes, as expected in financial data.
- Residuals over Time: Residuals are centered around zero but show clear volatility clustering (e.g., during 2008 and 2020 crises).
- ACF of Residuals: No significant autocorrelations remain — the ARIMA model has successfully whitened the residuals.
- QQ Plot: Residuals deviate from the normal distribution in the tails, confirming fat-tailed behavior typical of financial returns.

The ARIMA(2,1,1) model captures the trend and short-term structure of FTSE 100 returns, but the risk dynamics (volatility and tail behavior) demand more advanced models such as GARCH or fat-tailed distributions for a complete picture.

---

### Volatility (GARCH(1,1)) - FTSE100

<img width="1389" height="985" alt="image" src="https://github.com/user-attachments/assets/b8d920e7-6983-42c6-92b3-37c0b93b9732" />

<img width="521" height="407" alt="image" src="https://github.com/user-attachments/assets/7405ae22-81c3-4960-834c-fbe1b47b0fc3" />


| Component         | Estimate | Significance       | Interpretation                                                                   |
| ----------------- | -------- | ------------------ | -------------------------------------------------------------------------------- |
| μ (mean)          | 2.52     | Significant        | Small positive drift in daily returns.                                           |
| ω (constant)      | 42.83    | Significant        | Baseline variance level.                                                         |
| α₁ (ARCH)         | 0.085    | Highly significant | Sensitivity to recent shocks; large moves increase volatility next day.          |
| β₁ (GARCH)        | 0.907    | Highly significant | Strong persistence — volatility today depends heavily on yesterday’s volatility. |
| α₁ + β₁           | 0.992    | —                  | Very close to 1 → shocks decay slowly, volatility is highly persistent.          |
| ν (df, Student-t) | 7.38     | Highly significant | Fat tails; extreme returns occur more often than under normal distribution.      |

- ΔClose vs Conditional Volatility: The fitted volatility (red) rises during crisis periods (2008, 2020, 2022), capturing volatility clustering well.
- Standardized Residuals: Residuals appear roughly white noise, centered around zero, with no visible autocorrelation.
- ACF of Standardized Residuals: Autocorrelations are insignificant, confirming the model has removed linear dependence.
- QQ Plot of Standardized Residuals: The bulk of points follow the theoretical line, but tails are heavier than Gaussian — consistent with the Student-t assumption.

The GARCH(1,1) model effectively captures the time-varying volatility of the FTSE 100.
- Volatility is persistent: once markets become volatile, they tend to stay volatile for some time (α+β ≈ 0.99).
- Shocks to returns (α₁ = 0.085) feed strongly into volatility, reflecting the impact of crises.
- The Student-t distribution parameter (ν ≈ 7.4) confirms fat tails: extreme market moves are more frequent than under normality.

---
### Forecast Evaluation
| Index        | RMSE ΔClose | MAPE ΔClose | RMSE Price | MAPE Price |
|--------------|-------------|-------------|------------|------------|
| FTSE 100     | 85.23       | 131.18%     | 364.93     | **3.83%** |
| CAC 40       | 93.03       | 99.79%      | 457.34     | 5.00% |
| DAX          | 311.49      | 99.00%      | 2455.63    | 9.65% |
| SMI          | 147.51      | 100.63%     | 785.39     | 5.20% |

> Price-level forecasts achieve **3.8–5.2% MAPE** for FTSE, CAC, SMI; higher error for DAX.

