# DataCo Global: An End-to-End Data Analysis & Business Intelligence Pipeline

## Project Overview

This project demonstrates a complete End-to-End BI Pipeline for DataCo Global, a simulated multinational retail corporation. The solution spans the entire data lifecycle: from raw data ingestion and transformation using Python, to structured data warehousing in SQL Server, and finally to executive-level intelligence in Power BI.

By transforming over 180,000 denormalized records into a robust Fact Constellation (Galaxy) Schema, this project provides actionable insights into logistics efficiency, profitability leakage, and customer conversion.

## 📊 Executive Performance Summary & Strategic Insights
Between 2015 and 2018, DataCo generated approximately $36.78 million in total revenue while maintaining an average net profit margin of 10.8%, reflecting strong financial performance and sustained market demand. The company's revenue was largely driven by the Apparel and Fan Shop departments, which generated the majority of total revenue and demonstrated strong product demand. From a regional perspective, Europe and LATAM emerged as the company's most significant markets, contributing the largest share of sales. Customer demand was primarily concentrated within the Consumer (≈52%) and Corporate (≈30%) segments, with single-item orders representing the dominant purchasing behaviour. This purchasing pattern suggests a business characterised by frequent, lower-volume orders rather than bulk purchases, providing valuable context for inventory planning, fulfilment operations, and targeted marketing strategies.

### Insights
- **Good Global Market Penetration:** Europe and LATAM serve as the dominant revenue pillars, each generating over $10 million in sales. Pacific Asia follows closely with $8 million, confirming a strong, diversified global footprint with significant international demand.

- **Core Departmental Revenue Concentration:** The Fan Shop and Apparel departments function as the company's primary commercial engines, collectively contributing approximately 70% of total sales. While this reflects strong customer demand and product performance, it also indicates a high revenue concentration, meaning that disruptions to product availability, supply chain operations, or changes in customer demand within these two departments could have a significant impact on overall business performance.

- **Digital Conversion Performance**: Customer conversion reached 22.94% on Thursdays, compared with an average of approximately 9.5% on other weekdays. This near 2.5x uplift identifies Thursday as the most effective day for targeted promotions, product launches, and digital marketing campaigns.

- **High-Value Customer Segments**: Corporate and Consumer customers consistently recorded the highest average order values through predominantly single-item purchases, presenting opportunities for premium product offerings, personalised marketing campaigns, and customer retention initiatives.

- Demand Growth Does Not Explain Delivery Performance: The monthly trend shows that Monthly order volumes fluctuate throughout the year, yet delivery performance remains largely unchanged. The logistics network demonstrates sufficient scalability to manage higher order volumes. However, the inability to improve delivery performance during lower-demand periods indicates that the underlying issues stem from operational processes rather than capacity constraints. Existing logistics capacity appears sufficient, but execution efficiency is lacking.

- High-Volume Shipments Are More Susceptible to Delays: The fulfillment performance chart shows that late deliveries dominate the largest order volumes and item quantities, while on-time deliveries are concentrated around moderate order sizes. As shipment size increases, the likelihood of delivery delays also increases, suggesting that large or complex orders place greater strain on fulfillment operations. Prioritize high-volume orders for enhanced monitoring and earlier dispatch.

- Delivery Reliability Has a Direct Impact on Profitability: Orders delivered on time consistently achieve the strongest financial performance, while cancelled shipments generate the weakest returns. Although late deliveries still produce positive margins, delivery failures gradually erode profitability. Therefore, Improving delivery reliability offers a direct path to higher profit margins without increasing product prices or sales volume

- Product Price Is Not the Primary Driver of Profitability: Operational execution and discount promotional strategy has a greater influence on realized profitability than product price. Many lower-priced products outperform premium products when delivered reliably.

- Cancelled orders account for only 2,855 orders (approximately 4%), yet they exhibit the lowest adjusted profit margin and the greatest variability in profitability. Investigate cancellation drivers such as:

Inventory shortages
Processing delays
Payment failures
Customer abandonment
Carrier disruptions

Reducing cancellations will immediately improve realized revenue and operational efficiency.


- 
### Key Business Challenges
- **Digital Channel Underperformance & Conversion Failure:** Despite generating over 443K monthly page views, the e-commerce platform operates as a passive "window shopping" catalog rather than a revenue driver. The web channel contributes only 3.04% of total sales, and traditional non-web channels capture over 97% of revenue across all top-selling product lines. This indicates a severe deficiency in digital acquisition and checkout conversion, rather than a lack of market demand for the products themselves.

- **Severe Logistics & Fulfillment Bottlenecks:** Between 2015 and 2017, DataCo fulfilled 65,752 orders, yet delivery performance remained a critical operational weakness. Approximately 54.8% of all shipments were delivered late, while only 17.8% arrived on time, indicating a persistent failure to meet customer delivery expectations. Delayed orders required an average of 4.09 days to arrive compared with the promised 2.0 to 4.0 days transit time. The analysis further shows that late deliveries are directly associated with lower profitability, as additional fulfillment costs, expedited shipping, penalty fees and service recovery efforts erode order margins. Since delivery delays remained consistently high despite stable order volumes, the root cause lies in systemic fulfillment inefficiencies rather than demand fluctuations.

- **Seasonal Margin Erosion (Q4 Unit-Mix Shift):** While gross order volumes remain stable during November and December, total revenue declines significantly. This is driven by a dangerous shift in product composition: customers are substituting high-margin, premium items for low-value, medium-volume goods. This unit-mix compression actively erodes Q4 profitability, signaling that the current holiday promotional strategy is cannibalizing the bottom line.

### Data-driven Recommendations
- **Immediate Logistics Overhaul:** Audit "Standard Class, First Classand Second Class" shipping providers and implement strict carrier penalties or new partnerships. A clear mandate must be set to reduce the 54.83% late delivery rate to below 20% to protect base profitability immediately.
- **Targeted Q4 Margin Defense:** Restructure the holiday marketing strategy to steer traffic away from steep discounting of medium-volume goods. Implement bundled high-margin premium kits to increase Average Order Value (AOV) while maintaining order volume.
- **Revitalize the Digital Acquisition Funnel:** Allocate specific marketing budgets to drive web traffic on Wednesdays in order to systematically exploit the proven, high-converting Thursday purchase window. Simultaneously, audit the checkout process to remove friction points hindering digital sales.
- **Capitalize on the Thursday Peak:** Deploy exclusive, digital-only flash sales and time-sensitive incentives on Thursdays. Channeling the 22.94% high-intent traffic into finalized web sales will reduce reliance on traditional distribution networks and expand overall e-commerce profitability.

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

Author: [Your Name/Portfolio Link]
Role: Senior BI Consultant / Data Engineer / Supply Chain Specialist
Date: July 2026

