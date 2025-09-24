# House Price Prediction Project

## 🧩 Background and Overview  
This project presents a comprehensive analysis and predictive modeling of residential real estate prices in King County, Washington (USA, 2014). The dataset includes property attributes such as size, condition, location, and sale prices. The aim is to transform raw housing data into actionable insights and accurate price predictions, demonstrating full-stack data science and machine learning capabilities.

**Objectives**
- Develop a robust predictive model for housing prices using property features and location data.
- Identify the key drivers of property values and uncover market patterns.
- Provide data-driven recommendations for buyers, sellers, investors, and policymakers.
- Showcase learning and proficiency in the data analysis workflow:
  - Data cleaning and preprocessing
  - Feature engineering
  - Exploratory data analysis (EDA)
  - Predictive modeling and evaluation
  - Business insights and recommendations

**Technical Stack**
- **Programming & Analysis:** Python, Jupyter Notebooks
- **Libraries:** Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn

This project aims to practice and demonstrate the ability to apply statistical analysis, machine learning, and business reasoning to real-world that are both technically sound and practically valuable.

## 📌 Table of Contents  
- [🗂 Data Structure Overview](#-data-structure-overview)  
- [🔧 Methodology](#-methodology)  
- [📖 Executive Summary](#-executive-summary)  
- [🔍 Insights Deepdive](#-insights-deepdive)  
- [📊 Visualization](#-visualization)  
- [✅ Recommendations](#-recommendations)  
- [📌 Conclusion](#-conclusion)  

---

## 🗂 Data Structure Overview  
**Original Dataset**
- **Source:** Kaggle dataset (Washington house sales data in 2014)
- **Initial Size:** ~4,600+ records with 18 columns
- **Key Variables:** Property characteristics (e.g. size, rooms, condition, etc.), location details (e.g. city, statezip, etc.), temporal information (e.g. sale date, year built, year renovated), and sale price.


| **Column**             | **Meaning**                                                                                         | **Data type** |
|-------------------------|-----------------------------------------------------------------------------------------------------|-----------|
| `date`                 | The date when the house was sold.                                                                   | object    |
| `price`                | Sale price of the house (target variable for prediction).                                           | float64   |
| `bedrooms`             | Number of bedrooms in the house.                                                                    | float64   |
| `bathrooms`            | Number of bathrooms in the house (fractions allowed, e.g., 2.25 means 2 full + 1 quarter bathroom). | float64   |
| `sqft_living`          | Living space of the house (in square feet).                                                         | int64     |
| `sqft_lot`             | Lot size (land area the house sits on, in square feet).                                             | int64     |
| `floors`               | Number of floors (levels) in the house.                                                             | float64   |
| `waterfront`           | Binary variable (0 = no waterfront view, 1 = waterfront property).                                  | int64     |
| `view`                 | An index from 0 to 4 indicating the quality of the view (0 = none, 4 = excellent).                  | int64     |
| `condition`            | Condition of the house, scaled 1–5 (1 = poor, 5 = excellent).                                       | int64     |
| `sqft_above`           | Square feet of house **above ground** (excluding basement).                                         | int64     |
| `sqft_basement`        | Square feet of the **basement**.                                                                    | int64     |
| `yr_built`             | Year the house was originally built.                                                                | int64     |
| `yr_renovated`         | Year the house was last renovated (0 = never renovated).                                            | int64     |
| `street`               | Street address of the property.                                                                     | object    |
| `city`                 | City where the house is located.                                                                    | object    |
| `country`              | Country of the property                                                                             | object    |
| `statezip`             | U.S. state code ("WA" = Washington) and ZIP code combined                                           | object    |

**Cleaned Dataset**
Following rigorous cleaning, outlier removal using the Modified Z-score method (retaining data within the 1%-99% range to focus on the most representative samples), and feature engineering, the dataset was refined to 4,401 rows. This process introduced three additional columns for enhanced analysis:

| **Column**              | **Description**                                                                 | **Data Type** |
|--------------------------|---------------------------------------------------------------------------------|---------------|
| `zip`                   | ZIP code of the property (extracted from `statezip` for granular location analysis) | int64        |
| `price_per_sqft_living` | Sale price per square foot of living area (normalized price feature)             | float64       |
| `price_bin`             | Price segmentation bin for grouping properties into ranges (e.g., low, mid, high) | float64       |

**Final Data Structure**
The cleaned final dataset was expanded to 43 columns after transforming categorical variables (e.g., city) into dummy variables for modeling. Redundant features such as street and sqft_lot were dropped to streamline modeling prediction.

| **Feature Category**     | **Key Variables**                     | **Description**                                                                  |
|---------------------------|---------------------------------------|---------------------------------------------------------------------------------|
| Core Property Features    | `sqft_living`, `bedrooms`, `bathrooms`, `floors` | Structural characteristics with strong predictive power              |
| Quality Indicators        | `waterfront`, `view`, `condition`    | Property quality metrics (`view`: 0–4 scale, `condition`: 1–5 scale)             |
| Temporal Features         | `yr_built`, `yr_renovated`           | Age of the property and renovation history                                       |
| Location Data             | Dummy variables for `city`           | Geographic segmentation for regional market effects                              |
| Target Variable           | `price`                              | House sale price (prediction target)                                             |

Data Quality Enhancements Taken:
- Removed outliers using Modified Z-score method (retaining 1%-99% range)
- Eliminated redundant variables (street, sqft_lot)
- Handled missing values and duplicates
- Final Dataset: 4,401 records with 43 columns optimized for modeling

---
## 🔧 Methodology  
1. **Data Preprocessing**
   - Imported the raw dataset from Kaggle
   - Removed missing/duplicate records.  
   - Outlier detection using Modified Z-score. (Retaining the core within the 1%-99% range to minimize noise values while preserving data integrity)
   - Feature engineering: `price_per_sqft_living`, `price_bin`.  

2. **Exploratory Data Analysis (EDA)**  
   - Distribution and correlation analysis 
   - Categorical comparisons (renovation impact, city-level price variation).  
   - Geographic segmentation by city and ZIP code.  

3. **Modeling**  
   - Split the data into training and test sets (e.g., 80/20 ratio) and trained models to predict price based on selected features
   - Prediction models (Decision Tree, Lasso & Linear Regression).  
   - Evaluation metrics: **R², MAE, MSE, RMSE**.  
   - Cross-validation to ensure stability and avoid overfitting.  

---

## 📖 Executive Summary   
This project developed a **high-performing predictive model** for housing prices in King County, achieving an **R² of 0.76** on test data. The model demonstrates strong practical utility with a **mean absolute error (MAE) of ~$105K**, offering reliable accuracy for mid-range properties while highlighting market dynamics that drive valuation.  

**🔑 Key Achievements**  
- **Data Quality**: Transformed 4,600 raw records into a*clean, analysis-ready dataset of 4,401 entries through systematic preprocessing, outlier removal, and feature engineering.  
- **Exploratory Insights**:  
  - Strongest predictor: `sqft_living` (~0.70 correlation with price).
  - Additional drivers: `city`, `bathrooms`, `bedrooms`, and `view` (~0.37–0.57 correlation with price).
  - `condition` and `waterfront` showed unexpectedly limited influence.

- **Model Performance**: Regression models explained **74–76% of price variance** with minimal overfitting (consistent training and test results).  
- **Actionable Insights**: Identified significant variation in **renovation ROI across cities**, providing location-specific guidance for investment.  
- **Business Value**: Delivered evidence-based intelligence to support **investment, pricing, and renovation strategies**.

**📈 Performance Metrics**  

| Metric        | Training       | Testing        | Interpretation                                   |
|---------------|---------------|---------------|--------------------------------------------------|
| **R² Score**  | 0.74          | 0.76          | Explains ~76% of price variance                  |
| **MAE**       | $105,460      | $105,000      | Avg. error per prediction                        |
| **RMSE**      | $157,826      | $165,339      | Larger errors concentrated in luxury properties  |

- Cross-validation using K-Fold and ShuffleSplit confirmed stability (train R² ~0.72, test R² ~0.71).
- **Key predictors**: `sqft_living`, `city`, `bathrooms`, `bedrooms` and `view`.  

✅ Overall, this baseline model provides **robust, generalizable predictions** and sets the stage for further improvements using advanced methods (e.g., XGBoost, Random Forests, geospatial features).  

---

## 🔍 Insights Deepdive
This analysis highlights the **primary drivers of housing prices** in King County and reveals how property characteristics, renovations, and geography interact to shape market values.  

<details>
<summary>📌 Core Value Drivers</summary>

- **Living Space Dominance**: `sqft_living` is the strongest predictor (~0.70 correlation), confirming that larger homes consistently command higher prices.  
- **Bathroom Premium**: Each additional bathroom adds more value than an extra bedroom, reflecting higher marginal utility.  
- **View Quality**: Properties with desirable views capture notable premiums, though they represent fewer than 10% of listings..  
- **Condition & Waterfront**:  Both exert weaker-than-expected influence, suggesting subjectivity in ratings or undervaluation of these features. 

</details>

<details>
<summary>🌍 Geographic Segmentation</summary>

- **Premium Markets**: Cities like **Medina, Clyde Hill, Mercer Island** command 2–3× county averages, driven by location desirability and affluence.  
- **Mid-Tier Clusters**: The majority of cities fall in the **$400K–$700K range**, representing stable mid-market housing.  
- **Affordable Segments**: Cities like **Algona, Pacific, Skykomish** provide entry-level affordability but with limited growth potential.  

</details>

<details>
<summary>🛠 Renovation ROI</summary>

- **Positive ROI**: Affluent areas such as **Mercer Island, Normandy Park, Maple Valley** yield **+10–13% price premiums** for renovated homes.  
- **Negative ROI**: More saturated or affordability-driven markets like **SeaTac, Tukwila, Kirkland** show **–20% to –28% discounts** for renovated homes.  
- **Age Effect**: Renovations on **newer or mid-aged homes** generate stronger returns, while older properties may not recoup renovation costs.  

</details>

<details>
<summary>📊 Price Segmentation</summary>

- Most homes cluster in the **mid-market (<$1M)**, with luxury properties driving distribution skewness.  
- Renovations and premium features are more valued in high-demand markets but provide limited returns in lower-value areas.  

</details>


✅ **Key Takeaway**: Housing prices are primarily driven by **living space, location, and selective renovations**, with geographic and market nuances significantly shaping ROI. Stakeholders should adopt location-specific strategies — focusing on premium upgrades in affluent markets while prioritizing affordability in mid- and lower-tier segments.  

---
## 📊 Visualization 
### Average House Price by City
<img width="1589" height="1234" alt="image" src="https://github.com/user-attachments/assets/986c2bb0-6dc4-47ba-b56f-f99d14147493" />

- **Top-End Markets**: Medina, Clyde Hill, and Mercer Island lead with average prices well above $1M–$1.7M, reflecting luxury, exclusivity, and proximity to economic hubs.
- **Mid-Market Cluster**: Most cities fall in the $500K–$700K range, forming the county’s core residential market.
- **Affordable Markets**: Algona, Pacific, and Skykomish are the most affordable, averaging below $300K, highlighting entry-level opportunities.
- **Geographic Inequality**: Significant spread between the most expensive and cheapest cities (>5× difference), underscoring sharp location-driven segmentation.


### Distribution of Housing Prices per Square Foot (Living Area)
<img width="1315" height="605" alt="image" src="https://github.com/user-attachments/assets/eb24d394-901d-4563-837b-749cf938a6f4" />

- **Right-Skewed Price Distribution**: House prices predominantly cluster in the $200–$300 per sqft range, with most homes valued under $600,000.
- **Median vs. Mean**: Median price ($243 per sqft) is slightly below the mean ($256 per sqft), reflecting skewness driven by a small luxury segment.
- **Luxury Outliers**: High-end properties ($400+ per sqft, $1M+) create a long right tail, increasing variance.
- **Outlier Removal**: Prices below $109 and above $500 per sqft were excluded using the Modified Z-score method to focus on the core market.


### Correlation Heatmap Analysis
<img width="1398" height="1270" alt="image" src="https://github.com/user-attachments/assets/f3c18e0d-822a-4491-b961-5f645cb7fb4a" />

- **Living Area**: Strongest predictor of price (0.74 correlation) → larger homes drive higher values.
- **Bathrooms & Bedrooms**: Both positively correlated with price (0.57 and 0.38 respectively), with bathrooms showing stronger influence.
- **View**: Moderate correlation with price (0.37) → scenic properties add measurable value.
- **Waterfront**: Positive but weaker correlation (0.15) → premium exists, but relatively rare in dataset.
- **Condition**: Very weak correlation with price (~0.05) → likely due to subjective ratings and the fact that buyers prioritize location and size. In premium markets (e.g., Mercer Island), even homes in average condition still command high prices.

### Renovation Premiums by City

<img width="1390" height="745" alt="image" src="https://github.com/user-attachments/assets/ac073199-9847-4feb-bd7c-e2ef9c438165" />

- **Positive ROI**: Renovations add **+10–13% premium** in more affluent areas (e.g., Normandy Park, Maple Valley, Mercer Island).  
- **Negative ROI**: Markets like **SeaTac, Tukwila, Kirkland** penalize renovations with **–20% to –28% discounts**.  
- **Statistical Significance**:  
  - **Blue dots** = significant impact (consistent effect).  
  - **Gray dots** = no clear measurable effect.  
- **Geographic Divergence**: Renovation ROI varies sharply by location — profitable in affluent markets where buyers value upgrades, but often negative in lower-value or saturated areas, where affordability outweighs improvements.

### Impact of House Age on Renovation Premium

<img width="1189" height="832" alt="image" src="https://github.com/user-attachments/assets/2cec5f83-221d-4c83-a4ab-ba44117f961f" />

- **Negative Trend**: Renovation premium decreases as the age gap increases — older renovated homes capture less value uplift.
- **Younger Renovations Pay Off**: When renovated homes are similar in age (or newer) compared to non-renovated ones, premiums are slightly positive.
- **Older Renovations Penalized**: Large positive age differences (older renovated homes) often result in negative premiums, suggesting buyers discount them.
- **High Variability**: Considerable spread across cities indicates renovation ROI is not consistent and depends on local market dynamics.

### Predictive Accuracy
<img width="1189" height="590" alt="image" src="https://github.com/user-attachments/assets/fc25ff51-95a3-4e0e-96ab-4cf9fc169e37" />

- **Model Validation**: The predicted price of $494,983 aligns well with the actual market distribution for comparable homes, confirming model reliability
- **Market Concentration**: Most actual sales cluster between $450K-$550K, indicating the prediction falls within the high-probability price range
- **Reasonable Variance**: The spread shows typical market variability of ±$50K around the predicted value, which is expected for real estate pricing
- **Segment Accuracy**: The model performs well for mid-range Seattle properties (3BR, 2BA, ~1500 sqft), suggesting strong predictive power for this market segment
- **Confidence Benchmark**: The prediction sits near the distribution peak, indicating high confidence in this valuation estimate

---
## ✅ Recommendations  
<details>
<summary>🏡 For Buyers</summary>

- Prioritize **living space and bathrooms** over peripheral features, as these drive the strongest value.  
- Target **recent, high-quality renovations** in premium or high-demand markets for long-term appreciation.  
- Explore **mid-market commuter-friendly cities** (e.g., Bellevue, Redmond) for a balance of affordability and ROI.  

</details>

<details>
<summary>🔨 For Homeowners</summary>

- Focus renovations on **newer or middle-aged homes** to maximize returns.  
- Renovations add measurable value in premium markets (e.g., Mercer Island, Normandy Park) but may yield negative ROI in affordability-driven areas (e.g., SeaTac, Tukwila).  
- Avoid over-investing in older properties where upgrades cannot offset structural age.  

</details>

<details>
<summary>📈 For Sellers</summary>

- Highlight **living space, bathrooms, and recent renovations** in listings to capture buyer attention.  
- Leverage **location-driven premiums** (e.g., waterfront, urban hotspots) in pricing strategies.  
- Use predictive model outputs as a **baseline for competitive, data-backed pricing**.  

</details>

<details>
<summary>🔬 For Future Model Enhancements</summary>

- **Expand features**: integrate school quality, crime rates, transport access, and neighborhood amenities.  
- **Advance algorithms**: adopt gradient boosting (XGBoost, LightGBM) and random forests for better luxury home predictions.  
- **Add temporal and geospatial dynamics**: incorporate time-series trends and proximity to jobs, amenities, and transport hubs.  
- **Refine accuracy**: apply hyperparameter tuning and cross-validation to improve generalization.  

</details>

---

## 📌 Conclusion  

This project highlights the effectiveness of **systematic data analysis in real estate valuation**, combining predictive accuracy with actionable market insights.  
- The predictive model provides a **robust baseline for pricing decisions**, explaining ~76% of price variance.  
- Insights reveal **unexpected market dynamics**, particularly the **location-dependent ROI of renovations**.  
- Findings deliver **immediate value** to buyers, sellers, investors, and policymakers, while offering a scalable framework for continuous improvement.  

Future enhancements can integrate **richer datasets** (e.g., schools, crime, transport) and **advanced algorithms** (e.g., XGBoost, geospatial models) to further improve accuracy, especially in luxury segments.  

🚀 **This project is open for contributions** — feel free to fork, enhance, and extend!  

