# DataCo Global: An End-to-End Data Analysis & Business Intelligence Pipeline

## Executive Summary

This project demonstrates a complete End-to-End BI Pipeline for DataCo Global, a simulated multinational retail corporation. The solution spans the entire data lifecycle: from raw data ingestion and transformation using Python, to structured data warehousing in SQL Server, and finally to executive-level intelligence in Power BI.

By transforming over 180,000 denormalized records into a robust Fact Constellation (Galaxy) Schema, this project provides actionable insights into logistics efficiency, profitability leakage, and customer conversion.

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







## Dashboard Insights & Business Impact
| Dashboard Page | Strategic Focus | Business Value |
| --- | --- | --- |
| **Sales & Profitability** | Financial health and growth momentum. | Identifies high-margin regions vs. high-volume/low-profit zones to optimize pricing. |
| **Web Traffic & Conversion** | Customer journey and digital funnel. | Correlates web activity with sales to optimize marketing spend and predict demand. |
| **Operations & Logistics** | Delivery efficiency and risk management. | Pinpoints root causes of late deliveries (e.g., Standard Class shipping bottlenecks). |
| **Inventory Management** | Stock optimization and category health. | Highlights slow-moving inventory to trigger markdown strategies and improve turnover. |

Dashboard Page
Strategic Focus
Business Value
Sales & Profitability
Financial health and growth momentum.
Identifies high-margin regions vs. high-volume/low-profit zones to optimize pricing.
Web Traffic & Conversion
Customer journey and digital funnel.
Correlates web activity with sales to optimize marketing spend and predict demand.
Operations & Logistics
Delivery efficiency and risk management.
Pinpoints root causes of late deliveries (e.g., Standard Class shipping bottlenecks).
Inventory Management
Stock optimization and category health.
Highlights slow-moving inventory to trigger markdown strategies and improve turnover.







4. Technical Stack

•
ETL & Engineering: Python (Pandas, NumPy, SQLAlchemy)

•
Database & Warehousing: SQL Server / MySQL (T-SQL, Schema Design, PK/FK Constraints)

•
Business Intelligence: Microsoft Power BI (DAX, Power Query, UI/UX)

•
Environment: Jupyter Notebooks, SQL Server Management Studio / MySQL Workbench




5. Strategic Recommendations

1.
Logistics: Renegotiate carrier contracts for "Standard Class" in regions showing >15% delay risk, leveraging the granular shipping data.

2.
Marketing: Align web promotion spend with the "Consumer" segment in Western Europe, which shows the highest conversion-to-profit ratio.

3.
Inventory: Implement automated replenishment for "Apparel" categories while liquidating slow-moving "Electronics" stock identified in the Inventory view.

4.
Customer Experience: Optimize the web-to-order funnel by addressing high-drop-off points identified in the FactWebTraffic logs.


