# IMDB-Insights-A-Data-Warehouse-Project

### Introduction:

The project aims to analyze and visualize data from IMDB using a combination of tools including Alteryx, Talend, MySQL, Tableau, and Power BI. 

The deliverables include profiling data and analysis reports generated using Alteryx, a mapping document detailing source-to-target mappings, data modeling with a Type 2 Movie Titles Dimension table, ETL mappings designed in Talend with metadata-based connections, contexts, and environments, as well as SQL scripts for data manipulation and visualization. 

The project encompasses trend analysis, genre analysis, performance metrics, and director success metrics to derive insights such as average movie runtime changes, correlation between movie ratings and release years, genre popularity trends, correlation between runtime and gross earnings, and identification of successful directors based on ratings and gross earnings. 

The final output is visualized through dashboards created in Tableau and Power BI, providing actionable insights for stakeholders.

### Architecture Diagram

![Architecture Diagram](https://github.com/vikash-singh-prac/IMDB-Insights-A-Data-Warehouse-Project/assets/58064949/650a62a9-31a9-48b1-be65-9dda0d95276f)



- Data Profiling and Analysis: Conducted profiling, processing, and analysis of the the below datasets using Alteryx to derive insights on data.

MySQL database tables:

	imdb_name_basics
	imdb_title_akas
	imdb_title_basics
	imdb_title_crew
	imdb_title_principals
	imdb_title_ratings

 TSV file: Numbers.tsv

SCD2 JSON files:

	new_name_basics.json
	new_title_basics.json	
	
	

• Dimensional Data Modeling: Developed an extensive dimensional data model comprising 10 dimensions and 2 facts using ER/Studio, resulting in the generation of DDL scripts. 


• Data Integration and Pipeline Orchestration: Implemented a seamless end-to-end data pipeline through Talend, overseeing the staging, cleansing, transformation, loading, and integration of over 600,000 records into respective dimensions and facts within MySQL and Azure PostgreSQL databases. 

• SQL Queries and Visualization: Created SQL queries for data sanity checks and utilized Tableau and Power BI to design impactful visualizations. These visualizations offered profound insights into inspection trends over time, success rates of inspections, evolving inspection outcomes, and more.

### Dimension Model:

<img width="577" alt="Dimensional_Model" src="https://github.com/vikash-singh-prac/IMDB-Insights-A-Data-Warehouse-Project/assets/58064949/d8805ec0-8037-4b85-bcb5-22a3353b0ef3">

### Talend Jobs:

#### Dimension Title Basics:

![image](https://github.com/vikash-singh-prac/IMDB-Insights-A-Data-Warehouse-Project/assets/58064949/d1783a66-cac3-4302-9d93-e9cb6df20d70)

#### Dimension Title and Genre:

![image](https://github.com/vikash-singh-prac/IMDB-Insights-A-Data-Warehouse-Project/assets/58064949/f370fa67-40a1-4916-8ce3-ae6dd8def7fc)


#### Dimension Title and Director:

![image](https://github.com/vikash-singh-prac/IMDB-Insights-A-Data-Warehouse-Project/assets/58064949/c3dd44d5-6a6c-4ab7-ae71-0479a8b5c2ac)

#### Dimemsion Date:

![image](https://github.com/vikash-singh-prac/IMDB-Insights-A-Data-Warehouse-Project/assets/58064949/07187a42-c696-48f1-9b61-65ea820d5a34)

#### Fact Movies Numbers:

![image](https://github.com/vikash-singh-prac/IMDB-Insights-A-Data-Warehouse-Project/assets/58064949/211ff86d-ef35-414f-932e-f575df818e45)


### Alteryx:

Alteryx is a powerful data analytics platform that offers a wide range of capabilities, including data profiling. 

#### Why Alteryx:

- Data Preparation: Alteryx provides intuitive drag-and-drop tools for data preparation, allowing users to quickly clean, blend, and enrich data from various sources.
- Profiling Tools: Alteryx offers built-in profiling tools that enable users to analyze the structure, quality, and distribution of their data. 
- Data Quality Assessment: With Alteryx, users can perform comprehensive data quality assessments by examining data completeness, consistency, and accuracy.
- Automated Workflows: Alteryx enables users to create automated workflows for data profiling, allowing them to schedule and run profiling tasks on a regular basis.

### Talend:

Talend is a widely-used open-source integration platform that facilitates data integration, data management, and data quality tasks across various systems. It provides a unified platform for designing, deploying, and managing data integration processes in organizations.

#### Why Talend:

- Data Integration: Talend allows users to integrate data from different sources and formats, including databases, cloud applications, flat files, and more. It provides a graphical interface for designing integration workflows, making it easier for users to visualize and implement data pipelines.
- Data Quality: Ensuring data quality is crucial for decision-making and analysis. Talend offers features for data profiling, cleansing, and enrichment, helping users identify and rectify data inconsistencies, errors, and duplicates.
- Connectivity: Talend supports connectivity with a wide range of systems and technologies, including relational databases, big data platforms, cloud services (such as AWS, Azure, and Google Cloud), ERP systems, CRM systems, and many others.
- Scalability: It can handle both small-scale data integration projects and large-scale enterprise-level deployments, ensuring flexibility and performance.
- Open Source: Talend is built on open-source technologies, which means users have access to the source code and can customize it to suit their specific requirements.

Overall, Talend simplifies the complexities of data integration and management, enabling organizations to streamline their data workflows, improve data quality, and derive actionable insights from their data assets. Its open-source nature, scalability, and ease of use make it a preferred choice for businesses looking to harness the power of their data.

