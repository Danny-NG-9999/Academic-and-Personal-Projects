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

---
## 📚 Table of Contents
1. [Data Structure & Initial Check](#data-structure--initial-check)  
7. [Methodological Framework](#methodological-framework)  
8. [Executive Summary and Key Takeaways](#executive-summary-and-key-takeaways)  
9. [Deep Dive Analysis](#deep-dive-analysis)  
   - [Passenger Activity and Regional Productivity](#passenger-activity-and-regional-productivity-a-time-dependent-relationship)  
   - [Freight Activity and Productivity](#freight-activity-and-productivity-a-demand-driven-relationship)  
   - [Granger Causality Analysis](#granger-causality-analysis)  
   - [Impulse Response Analysis](#impulse-response-analysis)  
   - [Regional Heterogeneity and Policy Implications](#regional-heterogeneity-and-policy-implications)  
10. [Data Limitations and Measurement Challenges](#data-limitations-and-measurement-challenges)  
11. [Conclusion](#conclusion)  
12. [Acknowledgements & Support](#acknowledgements--support)

---
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

---
## Methodological Framework
The study employs a multi-stage econometric approach to assess the dynamic interplay between airport activity and regional productivity:

| **Stage**                     | **Method**                               | **Purpose**                                                                        |
|-------------------------------|------------------------------------------|------------------------------------------------------------------------------------|
| **Stationarity Testing**      | Im-Pesaran-Shin (IPS) Test               | Verify variable stationarity; apply first-differencing where needed                |
| **Lag Selection**             | Akaike (AIC) & Schwarz (SC) Criteria     | Determine optimal lag length for PVAR models                                       |
| **Dynamic Modeling**          | Panel Vector Autoregression (PVAR)       | Capture bidirectional and lagged effects between airport activity and productivity |
| **Causality Testing**         | Dumitrescu-Hurlin Panel Granger Test     | Establish predictive causality between variables                                   |
| **Impulse Response Analysis** | Impulse Response Functions (IRFs)        | Visualize dynamic responses to shocks over time                                    |

**Model Specification:**

$$\begin{cases}
Y_{it} = \alpha_Y + \sum \beta_k Y_{i,t-k} + \sum \gamma_k X_{i,t-k} + \sum \sigma_k Z_{i,t-k} + \varepsilon^Y_{it} \\
X_{it} = \alpha_X + \sum \theta_k X_{i,t-k} + \sum \phi_k Y_{i,t-k} + \sum \sigma_k Z_{i,t-k} + \varepsilon^X_{it}
\end{cases}$$

Where:
- \( Y_{it} \): GVA per head (productivity)  
- \( X_{it} \): Passenger or freight volume  
- \( Z_{it} \): Control variables (e.g., ATMs, population density)

---
## Executive Summary and Key Takeaways
This study examines how airport activity influences regional productivity across the UK (1998–2023), using a Panel Vector Autoregression (PVAR) framework and Granger causality tests to capture dynamic, bidirectional effects between passenger volumes, freight throughput, aircraft movements (ATMs), and GVA per head.

**1. ✈️ Passenger Activity**
- Passenger volumes Granger-cause productivity (Z = 23.143, p < 0.001), confirming airports’ role as productivity driver.
- Short-term adjustment costs (–0.0335, p < 0.001): Increased passenger volumes initially reduce productivity (adjustment costs, congestion).
- Medium-term gains (+0.0183, p < 0.01): Positive effects emerge after 1–2 years as regions absorb connectivity benefits.
- Key Driver: Aircraft movements (ATMs) are more impactful than passenger volume alone.

**2. 📦 Freight Activity**
- Freight volumes do not cause productivity (p = 0.6999); instead, productivity drives freight growth (Z = 3.382, p < 0.01) after roughly two years. This reflects the UK’s service-based economy, where freight responds to rising output rather than creating it, reinforcing that air cargo growth follows economic momentum.
- No direct productivity impact: Freight volumes do not Granger-cause productivity.
- Demand-driven: Freight expands in response to prior productivity growth (lag ≈ 2 years).
- UK-specific context: Unlike manufacturing-heavy economies (e.g., U.S.), UK freight is a supporting actor, not a growth driver.

**3. 🔁 Bidirectional Relationships**
- Passenger → Productivity: Yes (Granger-causal)
- Productivity → Passenger: No
- Freight → Productivity: No
- Productivity → Freight: Yes (Granger-causal)

**4. 🧭 Policy Implications**
- Invest in flight frequency and network reliability over pure passenger capacity.
- View airports as connectivity enablers, not standalone growth engines.
- Align freight infrastructure with already productive regions—don’t use it to stimulate growth.
- For major hubs, emphasize efficiency and sustainability; for emerging regions, enhance route diversity.

**⚠️ Data Considerations:**
- This study uses annual ITL1-level data, which may miss short-term fluctuations or local variations within regions. The productivity measure (GVA per head) includes all residents, not just workers, and air transport movements (ATMs) serve as a proxy for connectivity but don’t capture the diversity of routes. Future work could benefit from more detailed, employment-focused productivity data and finer-grained geographic analysisures.

In summary, Airports in the UK are connectivity catalysts—not automatic growth engines. Their economic value emerges when operational quality and network design align with regional industrial strengths, turning air mobility into sustained productivity gains.

---
## Deep Dive Analysis
### Passenger Activity and Regional Productivity: A Time-Dependent Relationship
<img width="953" height="347" alt="image" src="https://github.com/user-attachments/assets/abc5c9e3-836d-46f8-a829-08c1dbd366af" />

#### Short-Term Adjustment Costs
The initial negative impact of passenger volume increases on regional productivity (coefficient = -0.0335, p < 0.001) reveals critical structural challenges that regions face when absorbing sudden growth in air traffic. This phenomenon can be attributed to several interconnected factors:
- Infrastructure Strain and Congestion Effects: Sudden increases in passenger volumes create immediate pressure on regional infrastructure systems. Road networks around airports experience heightened congestion, public transport systems face capacity constraints, and local services (including hospitality and retail) may struggle to scale operations efficiently. This infrastructure strain translates into reduced labor productivity as commute times increase and logistical efficiency declines.
- Resource Diversion and Opportunity Costs: Regions responding to passenger growth often divert public and private resources toward accommodating aviation expansion rather than investing in more core productive capacities. Local governments may prioritize airport-related infrastructure over education, technology adoption, or business development programs that yield more direct productivity benefits. This resource reallocation could potentially creates an implicit opportunity cost that manifests in short-term productivity declines.
- Labor Market Distortions: Rapid aviation growth can create wage inflation in service sectors (hospitality, retail, ground transport) without corresponding productivity gains. This "baumol's cost disease" effect pulls labor away from more productive manufacturing and knowledge-intensive sectors, creating a temporary misallocation of human capital that depresses overall regional productivity.

#### Medium-Term Productivity Gains: The Connectivity Dividend
The positive and statistically significant coefficient at the second lag (0.0183, p < 0.01) demonstrates that once initial adjustment costs are absorbed, regions begin to capture substantial economic benefits:
- Knowledge Spillovers and Business Network Effects: Increased passenger connectivity facilitates more frequent face-to-face business interactions, enabling knowledge transfer, partnership formation, and innovation diffusion. The two-year lag aligns with typical business cycle timelines for relationship building, contract negotiation, and project implementation. Regions with robust airport connectivity attract knowledge-intensive firms that value global access, creating clustering effects that boost productivity.
- Labor Market Specialization and Skill Upgrading: Enhanced air connectivity allows regions to specialize in high-value activities that rely on global talent mobility. Companies can more easily recruit international specialists, and local workers gain exposure to global best practices. This specialization effect typically materializes over 18-24 months as firms reorganize operations and workers acquire new skills.
- Investment Attraction and Market Access: Improved passenger access signals regional competitiveness to international investors. The two-year lag corresponds to typical foreign direct investment timelines—from initial site selection through operational establishment. Regions become more attractive for headquarters functions, regional offices, and high-value service operations that depend on executive mobility.

#### The Critical Role of Aircraft Movements (ATMs)
The strong positive relationship between aircraft movements and productivity (coefficient = 0.0691, p < 0.001) underscores that connectivity quality matters more than passenger volume alone:
- Network Reliability and Business Confidence: Frequent flight schedules reduce business travel uncertainty, enabling more efficient planning and reducing the time cost of connectivity. Companies value reliable, high-frequency connections more than sheer passenger capacity because they support just-in-time business operations and reduce the risk of missed opportunities.
- Route Diversity and Economic Complexity: Regions with diverse flight connections (multiple destinations, frequent departures) develop more complex economic ecosystems. This diversity facilitates cross-industry innovation and reduces dependence on single markets or industries. The ATM metric captures this qualitative dimension of connectivity better than passenger volume alone.
- Hub Status and Global Integration: Airports with high ATM volumes often function as regional hubs, attracting ancillary services like logistics, aviation-related manufacturing, and business tourism. These spillover effects create employment multipliers and productivity enhancements that extend beyond direct aviation impacts.

### Freight Activity and Productivity: A Demand-Driven Relationship
<img width="940" height="372" alt="image" src="https://github.com/user-attachments/assets/3957d60b-4063-40a8-90a7-b035132c3993" />

#### The Absence of Direct Productivity Impact
The statistically insignificant relationship between freight volumes and productivity growth challenges conventional infrastructure-led development assumptions:
- Service Economy Context: The UK's economic structure, dominated by services (approximately 80%-82% of GDP), generates different logistical needs than manufacturing-heavy economies. Service outputs (consulting, finance, software) typically travel digitally or via passenger aircraft rather than dedicated cargo planes, limiting the productivity impact of freight expansion.
- Limited Backward Linkages: Unlike manufacturing sectors where air freight supports just-in-time production systems, service-dominated economies have weaker backward linkages between cargo capacity and productive efficiency. Most high-value UK service exports don't rely on dedicated air cargo, explaining the weak causal relationship.
- Infrastructure Mismatch: Investments in freight capacity may not align with the specific needs of knowledge-intensive service sectors. The productivity benefits of air cargo are most pronounced in high-tech manufacturing, pharmaceuticals, and perishable goods—sectors that represent a smaller share of UK regional economies outside specific clusters.

#### Productivity-Driven Freight Demand
The strong causal relationship from productivity to freight volumes (Z = 3.382, p < 0.01) with a two-year lag reveals important dynamics about regional economic evolution:
- Firm Upgrading and Product Complexity: Productivity growth often accompanies shifts toward higher-value, time-sensitive products. Companies transitioning from domestic to international markets, or from standardized to customized offerings, increasingly depend on air freight for components distribution and finished product delivery.
- Regional Specialization and Niche Development: Productive regions often develop specialized economic niches that generate specific freight demands. For example, regions with strong life sciences sectors may develop needs for temperature-sensitive pharmaceutical shipments, while technology hubs may require rapid component logistics.

#### The Self-Sustaining Nature of Freight Flows
The high persistence coefficient for freight volumes (0.7760, p < 0.001) indicates strong path dependency in cargo operations:
- Network Effects and Critical Mass: Air cargo operations benefit from density economies—higher volumes enable more frequent services, better utilization rates, and lower per-unit costs. This creates virtuous cycles where established freight routes become increasingly efficient and competitive.
- Institutional Knowledge and Relationship Capital: Regions with established freight operations develop specialized expertise in logistics management, customs procedures, and supply chain optimization. This institutional knowledge represents valuable intangible capital that sustains freight activity through economic cycles.

### Granger Causality analysis
<img width="1100" height="300" alt="image" src="https://github.com/user-attachments/assets/5a9b41ea-ebf0-4f8a-959f-faebe7e24a2c" />

1. Passenger Volumes and Productivity
- Passenger Volumes → GVA per Head: The test shows strong evidence of Granger causality from passenger volumes to regional productivity (Z = 23.143, p < 0.001). This indicates that past passenger activity significantly improves the prediction of future GVA per head. The result aligns with the PVAR findings, which identified a time-dependent effect: a short-term negative impact (lag 1: -0.0335, p<0.001) due to adjustment costs (e.g., congestion, infrastructure strain), followed by positive medium-term gains (lag 2: 0.0183, p<0.01) from enhanced connectivity, trade, and investment.
- GVA per Head → Passenger Volumes: No significant Granger causality was found in the reverse direction (p = 0.6986). This suggests that regional productivity growth does not predictably drive increases in passenger traffic. This asymmetry contrasts with the theoretical expectation of a bidirectional feedback loop, where productive regions might attract more travelers. Instead, passenger demand appears driven by external factors like flight frequency (ATMs: 1.3006, p<0.001) and network effects, as confirmed by PVAR.

Interpretation: The unidirectional causality from passenger volumes to productivity underscores airports’ role as catalysts for economic growth through connectivity. Regions with higher passenger throughput (e.g., London with Heathrow, Gatwick) benefit from knowledge spillovers, business travel, and tourism, which enhance productivity over time. However, the lack of reverse causality suggests that economic prosperity alone does not automatically boost passenger traffic, emphasizing the importance of airline network strategies and infrastructure quality.

2. Freight Throughput and Productivity
- Freight Volumes → GVA per Head: The test finds no evidence of Granger causality from freight volumes to productivity (p = 0.6999). This indicates that past freight activity does not significantly improve predictions of regional GVA per head, consistent with PVAR results showing insignificant coefficients for freight lags in the productivity equation.
- GVA per Head → Freight Volumes: Productivity strongly Granger-causes freight throughput (Z = 3.382, p < 0.01), with a lagged effect (lag 2: 8.1449, p<0.05 in PVAR). This suggests that regions with higher economic output generate increased demand for air cargo, likely due to expanded trade and logistics needs, but with a delay reflecting supply chain adjustments.

Interpretation: The freight results highlight a demand-driven dynamic, contrasting with passenger activity. In the UK’s service-oriented economy, freight volumes respond to economic growth rather than independently driving it, unlike in manufacturing-heavy contexts like the US (Gorlorwulu, 2002). The two-year lag suggests that firms take time to scale logistics operations in response to productivity gains, reinforcing the need for aligned infrastructure planning.

### Impulse Response Analysis
<img width="901" height="659" alt="image" src="https://github.com/user-attachments/assets/a8ca8862-4c64-4bcf-9536-ced6c5a843cd" />

The IRF results provide crucial insights into the temporal structure of airport-productivity relationships:

- Productivity Response Decay: The quick fade-out of productivity responses to passenger shocks suggests that the economic benefits of air connectivity require continuous reinforcement. One-time improvements in connectivity yield temporary gains unless supported by ongoing investments in complementary assets and infrastructure
- Asymmetric Adjustment Patterns: The different response patterns for passenger and freight shocks highlight the fundamentally different economic roles these activities play in regional development ecosystems.

### Regional Heterogeneity and Policy Implications
#### High-Density Region Challenges
The negative relationship between population density and productivity response (coefficient = -1.3083, p < 0.01) reveals important constraints:
- Congestion Externalities: Dense urban regions face capacity constraints that limit their ability to absorb additional aviation-related activity without negative spillovers. Air and surface transport systems operate near capacity, creating diminishing returns to additional airport investment.
- Land Use Competition: High-density regions face intense competition for land between aviation infrastructure, housing, commercial development, and green space. This competition drives up costs and reduces the net benefits of airport expansion.
- Environmental and Social Constraints: Dense regions typically face stricter environmental regulations and community opposition to aviation growth, creating additional barriers to capturing productivity benefits from airport activity.

#### Regional Development Implications
The findings suggest different strategic approaches for various regional contexts:
- Established Hub Regions (e.g., London, Manchester): Focus should shift from capacity expansion to quality enhancement—improving reliability, increasing frequency, and optimizing ground access. Productivity gains will come from better utilization of existing infrastructure rather than physical expansion.
- Emerging Connectivity Regions (e.g., Bristol, Newcastle): These regions stand to gain the most from strategic aviation investments, particularly those that enhance frequency and route diversity. The analysis suggests they are below the congestion threshold where diminishing returns set in.
- Peripheral Regions: May benefit more from targeted connectivity improvements than broad passenger volume increases. The focus should be on specific routes that connect regional specialization with relevant international markets.

---
## Data Limitations and Measurement Challenges
Several constraints shaped the analysis and interpretation:
- Aggregation Effects: ITL1 regional aggregation may mask important sub-regional variations, particularly in large diverse regions like the South East or Scotland.
- Service Sector Measurement: GVA per head may not fully capture productivity in knowledge-intensive service sectors that benefit most from air connectivity.
- Connectivity Quality: While ATMs provide a proxy for connectivity quality, more nuanced metrics (route diversity, frequency, reliability) would enhance future analysis.
- Employment Denominator Limitations: The use of resident population rather than employed workers may slightly distort productivity measurements, particularly in regions with high commuter flows or demographic variations.

This comprehensive deep dive reveals that airports function as complex economic catalysts whose impacts depend critically on regional context, connectivity quality, and complementary investments. The findings challenge simplistic "build it and they will come" approaches to aviation infrastructure and highlight the importance of strategic, evidence-based aviation policy aligned with regional economic realities.

---
## Conclusion
This study demonstrates that the economic contribution of UK airports is neither uniform nor automatic. Passenger activity supports regional productivity, but with a lag and contingent on flight frequency—not just volume. Freight, by contrast, is a demand-driven outcome of productivity growth, not a cause.

**Future Research Directions:**
- Higher-Frequency Data: Use quarterly or monthly data to capture short-term fluctuations and seasonal patterns.
- Smaller Regional Airports: Expand the dataset to include smaller airports to assess their contribution to local economies.
- Sector-Specific Analysis: Incorporate sector-specific productivity data to identify which industries benefit most from improved air connectivity.
- Quality of Connectivity: Examine the relative importance of long-haul versus short-haul services and their economic impact.

---
## Acknowledgements & Support
**Author:** [Daniel (Viet) Nguyen](https://github.com/Danny-NG-9999)

**Copyright:** © 2025 Daniel (Viet) Nguyen. All rights reserved.  

If you found this project useful or insightful, please **consider giving it a ⭐ on GitHub** — your support helps me continue creating open-source projects and sharing knowledge! 🙏🙏🙏

