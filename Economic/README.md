# FTSE 100 Time-Series Econometrics & Forecasting

A full, end-to-end econometric analysis of the **FTSE 100 index** with peer benchmarks (CAC 40, DAX, SMI) from **1985-01-01 to 2024-12-31**.  
The project demonstrates a professional workflow for financial time-series: data engineering, exploratory analysis, stationarity testing, cointegration & causality, ARIMA forecasting, and volatility modeling with GARCH — all wrapped in clear diagnostics and evaluation.

---

## 📝 Executive Summary
This project provides a **comprehensive econometric assessment** of the FTSE 100 index.  
Key findings include:  
- **Prices are I(1)** (non-stationary), while returns are **I(0)** (stationary).  
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
   - [Correlations](#correlations)  
   - [Stationarity (ADF Tests)](#stationarity-adf-tests)  
   - [Cointegration](#cointegration-englegranger)  
   - [Granger Causality](#granger-causality-δclose-aic-lags)  
   - [ARIMA Model Selection](#arima-model-selection)  
   - [Forecast Evaluation](#forecast-evaluation)  
   - [Volatility (GARCH11)](#volatility-garch11)  
   - [Diagnostics](#diagnostics)  

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
| Series (FTSE 100) | ADF Statistic | p-value | Conclusion |
|-------------------|---------------|---------|------------|
| Close Price       | −1.952        | 0.308   | Non-stationary |
| ΔClose            | −32.764       | 0.000   | Stationary |
| Log Returns       | −15.787 / −37.390 | 0.000 | Stationary |
| Simple Returns    | −16.007 / −37.606 | 0.000 | Stationary |

👉 Levels are **I(1)**; differences/returns are **I(0)**.

---

### Cointegration (Engle–Granger)
| Pair              | EG Stat | p-value | Result |
|-------------------|---------|---------|--------|
| FTSE 100 – DAX    | −3.274  | 0.058   | Not cointegrated (5%) |

---

### Granger Causality (ΔClose, AIC Lags)
| Direction | Lags | p-value | Significance |
|-----------|------|---------|--------------|
| SMI → CAC | 6    | 0.0002  | *** |
| CAC → DAX | 6    | 0.0022  | *** |
| SMI → DAX | 22   | 0.0077  | *** |

---

### ARIMA Model Selection
| Index        | Best ARIMA(p,d,q) | AIC        |
|--------------|-------------------|------------|
| FTSE 100     | (2,1,1)           | 77,295.50  |
| DAX          | (0,1,1)           | 85,006.26  |
| CAC 40       | (0,1,2)           | 76,636.63  |
| SMI          | (2,1,1)           | 80,950.86  |

---

### Forecast Evaluation
| Index        | RMSE ΔClose | MAPE ΔClose | RMSE Price | MAPE Price |
|--------------|-------------|-------------|------------|------------|
| FTSE 100     | 85.23       | 131.18%     | 364.93     | **3.83%** |
| CAC 40       | 93.03       | 99.79%      | 457.34     | 5.00% |
| DAX          | 311.49      | 99.00%      | 2455.63    | 9.65% |
| SMI          | 147.51      | 100.63%     | 785.39     | 5.20% |

> Price-level forecasts achieve **3.8–5.2% MAPE** for FTSE, CAC, SMI; higher error for DAX.

---

### Volatility (GARCH(1,1))
- α₁ ≈ 0.068 – 0.103  
- β₁ ≈ 0.886 – 0.932  
- Persistence (α+β) ≈ **0.99 – 1.00** → **strong volatility clustering**  

Example (FTSE 100):  
- ω = 42.82 (p=0.0016)  
- α₁ = 0.085 (p<0.001)  
- β₁ = 0.907 (p<0.001)  
- ν = 7.38 (Student-t tails)  

---

### Diagnostics
- **Jarque–Bera:** JB stats up to 17,852 → returns are **non-Gaussian**.  
- **Ljung–Box:** post-ARIMA residuals largely whitened.  
- **ARCH LM:** confirmed heteroskedasticity, motivating GARCH.  

---


