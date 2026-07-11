# DataCo Global: An End-to-End Data Analysis & Business Intelligence Pipeline

## Project Overview

This project demonstrates a complete End-to-End BI Pipeline for DataCo Global, a simulated multinational retail corporation. The solution spans the entire data lifecycle: from raw data ingestion and transformation using Python, to structured data warehousing in SQL Server, and finally to executive-level intelligence in Power BI.

By transforming over 180,000 denormalized records into a robust Fact Constellation (Galaxy) Schema, this project provides actionable insights into logistics efficiency, profitability leakage, and customer conversion.

## 📊 Executive Performance Summary & Strategic Insights
Between 2015 and 2018, DataCo generated $36.78 million in total revenue while maintaining an approximate 10.8% net profit margin, indicating strong commercial performance and sustained customer demand. The company's revenue was largely driven by the Apparel and Fan Shop departments, which generated the majority of total revenue and demonstrated strong product demand.




The business was primarily supported by the Apparel and Fan Shop departments, with Europe and LATAM acting as its strongest regional revenue contributors. Customer activity was largely driven by the Consumer (≈52%) and Corporate (≈30%) segments, with single-item purchases accounting for the majority of transactions. This purchasing pattern suggests a business characterised by frequent, lower-volume orders rather than bulk purchases, providing valuable context for inventory planning, fulfilment operations, and targeted marketing strategies.

Between 2015 and 2018, DataCo achieved $36.78 million in total revenue with an approximate 10.8% net profit margin,. Revenue was heavily concentrated in the Apparel and Fan Shop departments, while Europe and LATAM served as the company's primary revenue-generating markets. Customer purchasing behaviour was dominated by the Consumer (≈52%) and Corporate (≈30%) segments, with single-item transactions representing the majority of orders, suggesting a business model driven by frequent, low-quantity purchases rather than bulk ordering.


- Department Revenue Concentration: The Fan Shop and Apparel departments serve as the company's primary revenue engines, collectively contributing approximately 70% of total sales. While this confirms strong product-market fit, it also presents a structural concentration risk and highlights a reliance on a limited number of business units.
- Strong Sales Performance in multiple markets globally: Europe and LATAM are the organization's strongest regional growth pillars, each generating over $10 million in sales**. Pacific Asia follows closely, contributing **more than $8 million, establishing a reliable, diversified global revenue pipeline across these three key regions.
- High-Value Customer Segments: Corporate and Consumer customers consistently recorded the highest average order values through predominantly single-item purchases, presenting opportunities for premium product offerings, personalised marketing campaigns, and customer retention initiatives.
- Digital Conversion Performance: Customer conversion reached 22.94% on Thursdays, compared with an average of approximately 9.5% on other weekdays. This near 2.5x uplift identifies Thursday as the most effective day for targeted promotions, product launches, and digital marketing campaigns.


### Key Business Challenges
- Digital Channel Underperformance & Conversion Failure: Despite generating over 443K monthly page views, the e-commerce platform operates as a passive "window shopping" catalog rather than a revenue driver. The web channel contributes only 3.04% of total sales, and traditional non-web channels capture over 97% of revenue across all top-selling product lines. This indicates a severe deficiency in digital acquisition and checkout conversion, rather than a lack of market demand for the products themselves.

- Severe Logistics & Fulfillment Bottlenecks: A systemic supply chain crisis is actively destroying margins, with 54.83% of all shipments arriving late and only 17.84% meeting on-time delivery targets. When orders fall behind schedule, actual transit times average 4.09 days versus an advertised expectation of 2.47 days—nearly doubling wait times. Critically, the data confirms that late deliveries correlate directly with negative profitability, meaning the costs of expediting and penalty fees are entirely eroding margins on affected orders.

- Seasonal Margin Erosion (Q4 Unit-Mix Shift): While gross order volumes remain stable during November and December, total revenue declines significantly. This is driven by a dangerous shift in product composition: customers are substituting high-margin, premium items for low-value, medium-volume goods. This unit-mix compression actively erodes Q4 profitability, signaling that the current holiday promotional strategy is cannibalizing the bottom line.

### Strategic Recommendations

Immediate Logistics Overhaul: Audit "Standard Class" and "First Class" shipping partners and introduce strict operational penalties. The current 54.83% late rate is a direct profit killer. Optimize routing to ensure this metric is brought under 20% to stabilize margins.

Protect Q4 Margins: Rethink the Q4 promotional strategy. Shift marketing focus away from driving high-volume, cheap unit sales and instead promote bundled high-margin premium goods to counteract the seasonal revenue drop.

Revitalize Digital Funnel: Allocate specific marketing and advertising budgets to expand the top-of-funnel web acquisition. Optimize digital campaigns to drive traffic on Wednesdays in order to directly capitalize on the proven, high-converting Thursday purchase window.

Capitalize on the Thursday Digital Spike: Launch targeted, digital-only purchase incentives exclusively on Thursdays. Channeling this existing 22.94% high-conversion traffic into finalized web sales will bypass traditional distribution costs and improve e-commerce margins.

Establish a Promotional Discount Cap: Implement strict administrative controls on overlapping promotional codes. Reducing current price reductions by just 1.5% will capture operational leakage and return +$550K straight to the net profit margin.

## The End-to-End Pipeline

The project architecture is divided into three distinct phases, ensuring a seamless flow from raw data to business decisions.

### Phase 1: Python ETL & Data Engineering
The raw DataCo dataset was initially a denormalized flat file. Using Python (Pandas, NumPy, SQLAlchemy), I implemented a comprehensive ETL (Extract, Transform, Load) workflow:
- Data Cleaning: Handled missing values, standardized naming conventions, and corrected data types (e.g., converting Unix timestamps to DateTime).
- Normalization: Deconstructed the flat file into a relational model, creating 8 Dimension tables and 2 Fact tables to eliminate redundancy and improve data integrity.
- Feature Engineering: Designed and generated surrogate key columns (e.g., Shipping_ID, Location_ID, Log_ID, and other entity identifiers) to uniquely represent business entities across the supply chain. These engineered identifiers served as the foundation for decomposing the original denormalized dataset into normalized dimension and fact tables, ensuring referential integrity, minimizing data redundancy, and supporting efficient SQL database development, Entity Relationship Diagram (ERD) construction, analytical querying, and Power BI semantic modelling for executive dashboard reporting.
- Exporting Tables: The cleaned and normalized DataFrames were programmatically exported as structured CSV files using Pandas' to_csv() method, ensuring data integrity and readiness for SQL ingestion.

### Phase 2: SQL Server Data Warehousing & Schema Enforcement
The transition from Python to SQL was a critical step in establishing a production-grade analytical database. Using a dedicated SQL script (Import_DataCo.sql), I implemented the following workflow:
- Database Provisioning: The script initiated by creating the dataco_supply_chain database to host the analytical model.
- Schema Definition (Python to SQL): For each dimension and fact table, CREATE TABLE statements were executed, explicitly defining columns with precise data types (e.g., DECIMAL(15, 10) for financial precision, DATETIME for temporal accuracy, VARCHAR for categorical data). This step ensured that the Python-generated data conformed to a strict relational schema.
- Schema Definition (Python to SQL): Designed SQL schemas for all dimension and fact tables by assigning appropriate data types (e.g., DECIMAL, DATETIME, and VARCHAR) to each column, ensuring data accuracy, relational consistency, and efficient storage. This established a robust database structure to support SQL analysis, business intelligence reporting, and interactive Power BI dashboards.
- Data Ingestion: High-speed LOAD DATA LOCAL INFILE commands were utilized to efficiently import the Python-generated CSVs into their respective SQL tables, ensuring scalability for large datasets.
- Defining Primary Keys: Each dimension table (e.g., DimCustomer, DimProduct) and fact table (FactSales, FactWebTraffic) had its unique identifier explicitly defined as a PRIMARY KEY during table creation, guaranteeing data uniqueness and support efficient data retrieval.
- Defining Foreign Keys & Relationships: Established foreign key relationships between fact and dimension tables (e.g., FactSales.Customer_Id referencing DimCustomer.Customer_Id) to maintain referential integrity, enable accurate table joins, and support efficient analytical querying within the relational database.
- Building the ERD: The Entity Relationship Diagram (ERD) was subsequently built and validated within the SQL environment (MySQL Workbench), visually confirming the integrity of the data model and ensuring efficient query paths for downstream BI tools.

### Phase 3: Power BI Intelligence & Visualization
The SQL Server database served as the live source for the Power BI dashboard suite:
- Data Connectivity: Power BI was connected directly to the MySQL WorkBench Server instance, importing the structured tables into the Power BI semantic model.
- Semantic Modeling: The relationships defined in SQL were replicated and validated within Power BI's data model, ensuring consistent filtering and cross-highlighting behavior across all reports.
- DAX Implementation: Advanced DAX measures were developed for time-intelligence (YoY/MoM growth), profitability ratios, and conditional formatting logic, enriching the analytical capabilities of the dashboard.
- UI/UX Design: A 4-page executive dashboard was designed, focusing on Sales, Web Traffic, Operations, and Inventory, providing intuitive navigation and clear communication of insights.

## Data Modeling (Fact Constellation Schema)
The architecture utilizes a Galaxy Schema to support complex analysis across sales, logistics, and web engagement through shared dimensions.

| Table Name        | Strategic Role                  | Business Value |
| ----------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `FactSales`       | Sales & Order Transactions      | Stores transactional sales data, including revenue, quantity, discounts, and market information, enabling comprehensive sales, profitability, and operational analysis. |
| `FactWebTraffic`  | Web Traffic & Customer Activity | Records website activity and links customer interactions to completed orders, enabling analysis of customer engagement, conversion behaviour, and the relationship between online activity and sales outcomes. |
| `DimCustomer`     | Customer Information            | Contains customer demographic and location attributes, enabling customer segmentation, geographic analysis, and purchasing behaviour analysis. |
| `DimProduct`      | Product Information             | Stores product details, pricing, and category information, supporting product performance, pricing, and product portfolio analysis. |
| `DimCategory`     | Product Classification          | Organises products into business categories, enabling category-level sales and product mix analysis. |
| `DimDepartment`   | Department Classification       | Groups products by department to evaluate departmental sales and operational performance. |
| `DimLocation`     | Geographic Information          | Stores regional and market information, supporting geographic sales analysis, regional performance monitoring, and market comparisons. |
| `DimShipping`     | Shipping & Delivery Information | Captures shipping methods and delivery performance, enabling analysis of shipping efficiency, delivery delays, and logistics operations. |
| `DimOrderDetails` | Order Information               | Stores order-level attributes such as payment type, order status, and order date, supporting order lifecycle and transaction analysis. |
| `DimDate`         | Time Dimension                  | Provides a standardized date hierarchy for analysing business performance across days, months, quarters, and years, enabling trend and seasonality analysis. |

## Dashboard Insights & Business Impact
| Dashboard Page | Strategic Focus | Business Value |
| --- | --- | --- |
| **Sales & Profitability** | Financial health and growth momentum. | Identifies high-margin regions vs. high-volume/low-profit zones to optimize pricing. |
| **Web Traffic & Conversion** | Customer journey and digital funnel. | Correlates web activity with sales to optimize marketing spend and predict demand. |
| **Operations & Logistics** | Delivery efficiency and risk management. | Pinpoints root causes of late deliveries (e.g., Standard Class shipping bottlenecks). |
| **Inventory Management** | Stock optimization and category health. | Highlights slow-moving inventory to trigger markdown strategies and improve turnover. |


## Technical Stack
- ETL & Engineering: Python (Pandas, NumPy, SQLAlchemy)
- Database & Warehousing: MySQL Workbench (Schema Design, PK/FK Constraints)
- Business Intelligence: Microsoft Power BI (DAX, Power Query, UI/UX)

## Strategic Recommendations

1.
Logistics: Renegotiate carrier contracts for "Standard Class" in regions showing >15% delay risk, leveraging the granular shipping data.

2.
Marketing: Align web promotion spend with the "Consumer" segment in Western Europe, which shows the highest conversion-to-profit ratio.

3.
Inventory: Implement automated replenishment for "Apparel" categories while liquidating slow-moving "Electronics" stock identified in the Inventory view.

4.
Customer Experience: Optimize the web-to-order funnel by addressing high-drop-off points identified in the FactWebTraffic logs.


