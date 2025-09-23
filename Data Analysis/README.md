# House Price Prediction Project

## Background and Overview  
This project focuses on analyzing and predicting house prices using a dataset from house sales in USA, primarily from 2014. The data includes details on property features such as size, condition, location, and sale prices. The goals of the project are to demonstrate skills and knowledge in data cleaning, exploratory data analysis (EDA), and building relevant predictive models (e.g., linear regression, decision trees, etc.) to estimate house prices using relevant features and drivers. By processing raw data into actionable insights, this project showcases proficiency in Python libraries like Pandas, NumPy, Matplotlib, and Seaborn, while highlighting the ability to derive business-relevant recommendations from data.

The project showcases:  
- Data wrangling and preprocessing from raw housing datasets.  
- Exploratory Data Analysis (EDA) to uncover trends and distributions.  
- Predictive modeling to estimate housing prices.  
- Insight generation for business or real-estate decision-making.  

The work not only builds a model but also evaluates performance and interprets the results for practical use.  

---

## Data Structure Overview  
The analysis is based on a dataset of house sales from King County, WA. The initial raw data (houseprice_raw.csv) contained 18 columns and over 4,600 rows. 
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
| `country`              | Country of the property (here, always "USA").                                                       | object    |
| `statezip`             | U.S. state code ("WA" = Washington) and ZIP code combined                                           | object    |




The cleaned dataset remove outliers using Modified Z-score method have three more column as below which reduce the dataset to 4401 rows for focused analysis (modified Z-score to remove outliers and only keep data between 1%-99% range as it have most number of occurance (house)
| `zip`                  | ZIP code of the property (engineered feature) -> state is in its own column now                     | int64     |
| `price_per_sqft_living`| Sale price per square foot of living area (engineered feature).                                     | float64   |
| `price_bin`            | Price segmentation bin for grouping properties into ranges (engineered feature).                    | float64   |

After a thorough cleaning and feature engineering process, the final dataset (cleaned_price.csv) was used for modeling. Basic info about cleaned dataset are as follow:
- **Cleaned Data (`cleaned_price.csv`)** – 4401 records, 21 columns, with simplified and engineered features:
  - Dropped redundant variables (`street`, `sqft_lot`, etc.).  
  - Added `price_per_sqft_living` (price normalized by house size).  
  - Created `price_bin` for categorical segmentation of price ranges.  
  - Preserved key predictive features such as `bedrooms`, `bathrooms`, `floors`, `view`, `condition`, `city`, `state`, and `zip`.  

---

## Executive Summary  
- **Data Cleaning**: Reduced noise by removing redundant or highly correlated variables.  
- **Exploratory Insights**: Price strongly correlates with `sqft_living` and `city`, but surprisingly `condition` and `view` have minimal effect on price
- **Modeling**: Regression models were applied to predict house prices.  

**Evaluation Results:**  
- **Training Data**  
MAE: 105459.5371
MSE: 24909092053.6957
RMSE: 157826.1450
R²: 0.7403

- **Test Data**  
MAE: 105000.2165
MSE: 27336994553.1909
RMSE: 165339.0291
R²: 0.7593 

**Interpretation**:  
The model explains about **74–76% of price variance** and achieves an average prediction error of around **$105K**, which is reasonable for mid-range homes but less accurate for very high-end properties.  

---

## Insight Deepdive  
1. **Living Space Matters**: `sqft_living` is the single most powerful predictor of house price, explaining a large share of price variation.  
3. **City Effect**: Prices vary substantially across cities, with premium locations such as Bellevue and Redmond outperforming suburban areas.  
4. **Age vs. Renovation**: Renovated houses command higher prices, but very old unrenovated homes tend to underperform despite large lot sizes.  
5. **Price Segmentation**: Using `price_bin` shows clustering of mid-market properties, with only a small fraction in the high-end luxury category.  

---

## Recommendations  
- **For Buyers**:  
  - Focus on living space and renovation quality, as these add measurable value.  
  - For long-term appreciation, properties in cities with sustained demand (e.g., Bellevue, Redmond) are stronger investments.  

- **For Sellers**:  
  - Renovations prior to listing can yield significant ROI, especially for older homes.  
  - Highlight waterfront or unique location features prominently to justify premium pricing.  

- **For Real Estate Agencies**:  
  - Develop pricing tools using sqft and location-based features to quickly provide clients with **evidence-backed pricing ranges**.  
  - Use segmentation (`price_bin`) to tailor marketing strategies to different buyer segments.  

- **For Future Work**:  
  - Incorporate external data (school quality, crime rates, economic indicators) for improved predictive performance.  
  - Apply advanced models (e.g., gradient boosting, XGBoost) to reduce error on luxury homes.  
