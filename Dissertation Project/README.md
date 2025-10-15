# ✈️ Airport Activity and Regional Productivity in the United Kingdom: An Empirical Study of Connectivity, Freight Operations, and Economic Growth (1998–2023)

## 📄 Project Overview
This research presents a rigorous econometric analysis of the relationship between airport activity and regional economic productivity across the United Kingdom. Using a balanced panel dataset of 12 UK ITL1 regions from 1998 to 2023, the study examines how passenger and freight volumes, alongside aircraft movements, influence regional Gross Value Added (GVA) per head—a key productivity indicator.

The UK's aviation sector is often cited as a catalyst for regional development, yet empirical evidence at the sub-national level remains scarce. This study fills that gap by applying advanced panel data techniques—including Panel Vector Autoregression (PVAR) and Granger causality tests—to uncover dynamic and bidirectional relationships between airport throughput and economic performance. 

The research is positioned within the context of the UK’s Levelling Up agenda, providing evidence-based insights to inform infrastructure investment, regional policy, and aviation strategy. By moving beyond aggregate national statistics, this analysis offers a granular understanding of how airports function as economic enablers—or constraints—within their regional contexts.

**🎯 Research Motivation and Objectives**
The research pursues following interrelated objectives:
1. Quantify the relationship between airport activity and regional productivity at the ITL1 level.
2. Determine Granger causality: Assess whether the relationship is unidirectional (airports drive productivity) or bidirectional (productive regions also attract more airport activity).

**🔬 Hypotheses**
The empirical framework tests two central hypotheses:
- H1: Regions with higher airport activity (passenger throughput, freight tonnage, aircraft movements) experience stronger productivity growth, all else being equal.
- H2: A bidirectional relationship exists between airport activity and regional productivity — i.e., airport growth not only stimulates productivity but is also driven by economic performance.

**💻 Software & Tools Used**
- Microsoft Excel
- Microsoft Word
- R Studio
- GitHub

**📊 Supporting Resources**
- Dataset: [UK Civil Aviation Authority (CAA)](https://www.caa.co.uk/data-and-analysis/uk-aviation-market/airports/uk-airport-data/) & [Office for National Statistics (ONS)](https://www.ons.gov.uk/economy/grossdomesticproductgdp/bulletins/regionaleconomicactivitybygrossdomesticproductuk/1998to2023)
- Code: R Studio scripts for PVAR, unit root tests, and Granger causality

## Data Structure & Initial Check
The dataset forms a balanced panel of 12 ITL1 regions observed annually from 1998 to 2023 (N=12, T=26, total observations=312). It integrates economic productivity metrics with aviation activity indicators, focusing on the top three airports per region to capture dominant regional contributions (smaller airports contribute <2% and are excluded to avoid noise).

**Data Sources**
- Regional Productivity: Sourced from the Office for National Statistics (ONS) Regional Accounts, using Gross Value Added (GVA) per head as the primary measure.
- Airport Activity: Data on passenger volumes, cargo throughput, and air transport movements (ATMs) sourced from the UK Civil Aviation Authority (CAA).
- Control Variables: Population density data from ONS Regional Accounts.

**Data Structure**
- Panel Dataset: The study uses a balanced panel dataset comprising 12 UK ITL1 regions, observed annually from 1998 to 2023.
- Variables:
    - Dependent: GVA per head (regional productivity).
    - Independent: Passenger volumes, cargo throughput, ATMs.
    - Control: Population density.

**Initial Data Checks**
- Logarithmic Transformation: All variables were transformed into natural logarithms to stabilize variance and allow for elasticity interpretation.
- Stationarity Tests: Im-Pesaran-Shin (IPS) tests were conducted to ensure stationarity, with non-stationary variables first-differenced.
- Lag Length Selection: Optimal lag lengths were determined using Akaike Information Criterion (AIC) and Schwarz Bayesian Criterion (SC).

**Regional and Airport Coverage**
The analysis covers all 12 ITL1 regions, with major hubs including:
- London Heathrow (LHR), Gatwick (LGW), Stansted (STN)
- Manchester (MAN), Edinburgh (EDI), Birmingham (BHX)
- Bristol (BRS), Glasgow (GLA), Newcastle (NCL)

| **Top 3 Airports by Share of Regional Passenger Volume**                                                                            | **Top 3 Airports by Share of Freight Transported via Cargo Aircraft**                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| <img width="933" height="1212" alt="image" src="https://github.com/user-attachments/assets/580276fc-7854-4031-9b37-a23ded664660" /> | <img width="933" height="1212" alt="image" src="https://github.com/user-attachments/assets/c674166d-7210-45d1-bff7-b216d43acb99" /> |


## Methodological Framework
The study employs a multi-stage econometric approach to assess the dynamic interplay between airport activity and regional productivity:




## Analytical Value

By integrating econometric rigour with applied policy insight, this project contributes to three domains:

Empirical Economics: Provides UK-specific, long-term evidence on the connectivity–productivity nexus at the regional level.

Infrastructure Strategy: Clarifies whether airports should be treated as policy instruments for regional development or as responsive assets to existing productivity.

Investment Planning: Informs public sector infrastructure policy (e.g., the Levelling Up agenda) and private capital allocation in transport-linked growth corridors.

## Core Insight

The findings reveal a time-lagged, asymmetric relationship:

Passenger throughput stimulates productivity after short-term adjustment costs, indicating airports act as medium-term enablers of growth.

Freight movement, conversely, is demand-led, expanding in response to prior productivity gains — reflecting the UK’s service-based economy.

Aircraft movements (ATMs) — as a measure of network frequency and reliability — emerge as the most consistent driver of regional productivity.
