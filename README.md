# Predictive-Churn-Analysis-Using-SQL-Power-BI-Machine-Learning
![image](https://github.com/user-attachments/assets/4aada321-721c-4854-bdaf-e30a247d4f10)
# Project Overview:
In a highly competitive customer-driven market, retaining customers is crucial. This project focuses on understanding customer behavior, analyzing churn patterns, and predicting future churners.
We used SQL for deep data extraction and exploration, Power BI for insightful visualization, and Python with machine learning models to predict churn probabilities for newly joined customers.
The project predicts potential future churners among newly joined customers, allowing proactive retention strategies.
# Objectives:
1. Analyze and segment existing customer base by demographics, contract types, revenue contribution, and state-wise distribution using SQL.
2. Perform exploratory data analysis (EDA) to assess data quality and patterns.
3. Build an intuitive and actionable Power BI dashboard for churn analysis.Identify major churn reasons and churn-prone customer segments.
4. Develop and train a predictive machine learning model (Random Forest Classifier) to identify potential churners.
5. Create a second Power BI dashboard highlighting predicted churners among newly joined customers.
6. Visualize insights through intuitive and detailed Power BI dashboards for easy stakeholder communication.
# Queries performed:
# 1.How is the customer base segmented by gender, and what proportion does each gender represent within the overall dataset?
  	select gender, COUNT(*) as TotalCount,
	  CAST(round(count(*)*100.0/(select count(*) from customerdata),2) as decimal(4,2)) as Percentage
  	from customer_data
  	group by gender
# 2.What is the distribution of contract types among customers, and how does each contract type contribute to the overall customer base in terms of count and percentage?
	select contract,COUNT(*) as TotalCount,
	   CAST(round(count(*)*100.0/(select count(*) from customerdata),2) as decimal(4,2)) as Percentage
	from customer_data
	group by contract
 # 3.How does total customer count and revenue contribution vary across different customer status segments and what percentage of the overall revenue does each segment generate?"
	select customer_status,COUNT(*) as TotalCount,round(SUM(total_revenue),2) as TotalRevenue,
	  cast(round(Sum(total_revenue)*100/(Select sum(total_revenue) from customerdata),2) as decimal(4,2)) as RevPercentage
	from customer_data
	group by customer_Status

# 4.How is the customer distribution spread across different states, and which states represent the highest proportion of the total customer base?
	select State,COUNT(*) as TotalCount,
	  CAST(round(COUNT(*)*100/(select count(*) from customerdata),2) as decimal(4,2)) as Percentage
	from customer_data
	group by state
	order by Percentage desc

