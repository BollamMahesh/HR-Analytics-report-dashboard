# HR Analytics &  Retention Pipeline
Technical Architecture & Workflow
This project was built utilizing a three-tier data pipeline architecture:

Phase 1: Data Preparation & EDA (Python)

Utilized Pandas for data wrangling, handling null values, and dropping zero-variance columns.

Conducted Exploratory Data Analysis (EDA) using Seaborn and Matplotlib to generate distribution histograms and correlation matrices.

Phase 2: Database Engineering (SQL Server)

Designed a relational database schema, assigning primary keys and strict data types.

Engineered advanced T-SQL queries utilizing Common Table Expressions (CTEs) and Conditional Aggregation to extract departmental metrics.

Created a highly optimized "Master View" to serve as the single source of truth for the BI layer.

Phase 3: Business Intelligence (Power BI)

Normalized the flat SQL view into a highly efficient Star Schema (Fact and Dimension tables) using Power Query.

Authored advanced DAX measures to calculate KPIs and dynamically group data (e.g., Age Bins).

Developed a custom algorithm to generate an Attrition Risk Flag (High/Medium/Low), visualized through an interactive matrix with conditional formatting.
