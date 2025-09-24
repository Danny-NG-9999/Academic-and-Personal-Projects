# House Price Prediction Project

## 📖 Background and Overview  
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
- [Data Structure Overview](#data-structure-overview)  
- [Methodology](#methodology)  
- [Executive Summary](#executive-summary)  
- [🔍Insight Deepdive](#🔍insight-deepdive)  
- [Visualization](#visualization)  
- [Recommendations](#recommendations)

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

## 📊 Executive Summary   
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

---

✅ **Key Takeaway**: Housing prices are primarily driven by **living space, location, and selective renovations**, with geographic and market nuances significantly shaping ROI. Stakeholders should adopt **location-specific strategies**—focusing on premium upgrades in affluent markets while prioritizing affordability in mid- and lower-tier segments.  

---
## Visualization 
### Distribution of Housing Prices per Sqft (Living Area after cleaning)
House prices were right-skewed, with most properties concentrated under $1M ($400 per living sqft), but a few luxury homes significantly increased variance.
<img width="1315" height="605" alt="image" src="https://github.com/user-attachments/assets/eb24d394-901d-4563-837b-749cf938a6f4" />

### Correlation Analysis
<img width="1398" height="1270" alt="image" src="https://github.com/user-attachments/assets/f3c18e0d-822a-4491-b961-5f645cb7fb4a" />
Key variables strongly correlated with price with high signifcant:
- Living area size (Square footage of living space was the most important determinant of price)
- Number of Bathrooms and Bedrooms
- View
Weaker correlation with high significant
- Waterfront
- Condition of the house

### Categorical Insights (Renovation Premium)

<img width="1390" height="745" alt="image" src="https://github.com/user-attachments/assets/ac073199-9847-4feb-bd7c-e2ef9c438165" />

The effect of renovation on negative for most, especially more urban city, where there is significant p-value (they tend to have most negative renovation premium too)
Renovation premiums vary widely by city

Some cities (e.g., Normandy Park, Maple Valley, Mercer Island) show positive renovation premiums of +10–13%. Renovations are rewarded by the market there.

Other cities (e.g., SeaTac, Tukwila, Kirkland) show negative premiums of –20% to –28%. Renovated houses are actually valued lower than comparable non-renovated ones.

Significance matters

Significant (blue dots): In cities like Seattle, Kenmore, Covington, Bellevue, Renton, Kirkland, Tukwila, SeaTac, the renovation premiums (mostly negative) are statistically significant. That means the discount effect is real and consistent.

Not significant (gray dots): In some cities, premiums (positive or negative) are not statistically different from zero — suggesting renovations don’t have a clear measurable impact there.

Geographic divergence

Newer and Wealthier markets (e.g., Mercer Island) show positive returns on renovations. Buyers are willing to pay extra for updated homes in premium neighborhoods.

In contrast, lower-value or more saturated markets (e.g., SeaTac, Tukwila) penalize renovated homes — possibly because buyers prioritize affordability over upgrades, or renovations can’t offset other negative location factors.


**Impact of House Age on Renovation Premium**

<img width="1189" height="832" alt="image" src="https://github.com/user-attachments/assets/2cec5f83-221d-4c83-a4ab-ba44117f961f" />

Negative Relationship:
The regression line slopes downward — meaning as the age difference increases (renovated homes are much older compared to non-renovated homes), the renovation premium decreases.
Premium Exists for Newer Renovations:
When renovated homes are not significantly older (or even newer) compared to non-renovated homes, the renovation premium is closer to 0% or slightly positive. This suggests buyers are willing to pay extra for relatively recent renovations.
Penalty for Older Renovated Homes:
When renovated homes are much older, buyers tend to discount them — in some cases, the premium turns negative (renovated homes are valued less than non-renovated ones). This may reflect structural aging or that renovations can’t fully compensate for being an older property.
High Variability Across Cities:
The wide spread of points (and the broad confidence interval) indicates city-level differences in how renovations are valued. Renovation premium is not consistent everywhere.


**Average house price by city**
<img width="1589" height="1234" alt="image" src="https://github.com/user-attachments/assets/986c2bb0-6dc4-47ba-b56f-f99d14147493" />
Top 3 most expensive cities:

Medina, Clyde Hill, Mercer Island → Luxury markets with extremely high housing costs, driven by location desirability, amenities, and possibly proximity to high-income employers (e.g., tech hubs).

Top 3 cheapest cities:

Algona, Pacific, Skykomish → Affordable housing markets, possibly due to distance from economic centers, smaller populations, or less demand.

Middle-tier clustering

Many cities fall in the $500K–$700K range, suggesting a fairly balanced mid-market.

Cities like Bellevue, Sammamish, etc are above this mid-tier, aligning with their status as highly desirable residential areas.

### Predicted vs. Actual Price distribution plot shows most predictions cluster closely around the diagonal line, indicating good performance.
<img width="1189" height="590" alt="image" src="https://github.com/user-attachments/assets/fc25ff51-95a3-4e0e-96ab-4cf9fc169e37" />

- The model’s predicted price of ~$495K is well-supported by the actual market distribution, reinforcing that the model captures key value drivers for comparable properties.
- The predicted price (~$495K) falls near the center of the actual price distribution, meaning the model’s estimate is consistent with observed comparable home sales.
- This increases confidence in the model’s accuracy for this property type.


Feature importance analysis highlights sqft_living, bathrooms, view, and waterfront as top predictors.
---
## Recommendations  
- **For Buyers**:  
  - Focus on living space and properties with recent renovation with good renovation quality, as these add measurable value.  
  - For long-term appreciation, properties in cities with sustained demand are strong investments.
  - Affordability varies dramatically; location choice has the single largest impact on housing cost. Buyers priced out of premium areas may find mid-market alternatives within commuting distance.
 
    
- For Homeowners:
  - Renovating older homes may not guarantee a positive price premium. Renovations are more valuable when done on relatively newer or middle-aged homes.
  - Renovation adds value in select markets (e.g., Mercer Island, Normandy Park), but in other cities (e.g., SeaTac, Tukwila), it may not pay off financially.

- **For Sellers**:  
  - Renovations prior to listing can yield significant ROI, especially for recently renovate homes.
  - Renovations may yield the best returns in areas where housing stock is not significantly aged compared to the market average.

- **For Future Work**:  
  - Incorporate external data (school quality, crime rates, economic indicators) for improved predictive performance.  
  - Apply advanced models (e.g., gradient boosting, XGBoost) to reduce error on luxury homes.
  - Incorporate external economic indicators (interest rates, employment, regional development).
  - Experiment with non-linear models (e.g., XGBoost, Random Forests) for better performance.
  - Perform hyperparameter tuning and cross-validation to avoid overfitting and improve generalization.



This project is open for contributions—feel free to fork and enhance!
