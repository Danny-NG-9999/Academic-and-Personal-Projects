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
5. [Graphs](#-graphs)  
6. [Repository Structure](#-repository-structure)  
7. [How to Reproduce](#-how-to-reproduce)  
8. [Interpretation & Takeaways](#-interpretation--takeaways)  
9. [Skills Demonstrated](#-skills-demonstrated)  
10. [License](#-license)  
11. [Project Summary](#-project-summary)  
12. [Contact](#-contact)  

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

### Correlations
| Pair                  | Correlation | p-value | Significance |
|------------------------|-------------|---------|--------------|
| FTSE 100 – CAC 40      | **0.858**   | 0.000   | *** |
| FTSE 100 – DAX         | **0.797**   | 0.000   | *** |
| FTSE 100 – SMI         | **0.781**   | 0.000   | *** |

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

## 📊 Graphs
Recommended figures (from notebook, save under `/figs/`):  
- `ftse_levels.png` – FTSE 100 level (1985–2024)  
- `ftse_returns.png` – Returns distribution & volatility clustering  
- `acf_pacf.png` – ACF/PACF of returns  
- `arima_forecast.png` – ARIMA forecast vs actual  
- `garch_volatility.png` – Conditional volatility from GARCH  

