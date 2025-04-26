create database customer_churn
use customer_churn
select * from customer_data

--How is the customer base segmented by gender, and what proportion does each gender represent within the overall dataset?
select gender, COUNT(*) as TotalCount,
	CAST(round(count(*)*100.0/(select count(*) from customerdata),2) as decimal(4,2)) as Percentage
from customer_data
group by gender

--What is the distribution of contract types among customers, and how does each contract type contribute to the overall customer base 
--in terms of count and percentage?
select contract,COUNT(*) as TotalCount,
	CAST(round(count(*)*100.0/(select count(*) from customerdata),2) as decimal(4,2)) as Percentage
from customer_data
group by contract

--How does total customer count and revenue contribution vary across different customer status segments,
--and what percentage of the overall revenue does each segment generate?"
select customer_status,COUNT(*) as TotalCount,round(SUM(total_revenue),2) as TotalRevenue,
	cast(round(Sum(total_revenue)*100/(Select sum(total_revenue) from customerdata),2) as decimal(4,2)) as RevPercentage
from customer_data
group by customer_Status

--How is the customer distribution spread across different states, and which states represent the highest proportion of the total customer base?
select State,COUNT(*) as TotalCount,
	CAST(round(COUNT(*)*100/(select count(*) from customerdata),2) as decimal(4,2)) as Percentage
from customer_data
group by state
order by Percentage desc



--DATA EXPLORATION Check nulls
select 
    SUM(case when Customer_ID IS null then 1 else 0 end) AS Customer_ID_Null_Count,
    SUM(case when Gender IS null then 1 else 0 end) AS Gender_Null_Count,
    SUM(case when Age IS null then 1 else 0 end) AS Age_Null_Count,
    SUM(case when Married IS null then 1 else 0 end) AS Married_Null_Count,
    SUM(case when State IS null then 1 else 0 end) AS State_Null_Count,
    SUM(case when Number_of_Referrals IS null then 1 else 0 end) AS Number_of_Referrals_Null_Count,
    SUM(case when Tenure_in_Months IS null then 1 else 0 end) AS Tenure_in_Months_Null_Count,
    SUM(case when Value_Deal IS null then 1 else 0 end) AS Value_Deal_Null_Count,
    SUM(case when Phone_Service IS null then 1 else 0 end) AS Phone_Service_Null_Count,
    SUM(case when Multiple_Lines IS null then 1 else 0 end) AS Multiple_Lines_Null_Count,
	SUM(case when Internet_Service IS null then 1 else 0 end) as Internet_Service_null_count,
    SUM(case when Internet_Type IS null then 1 else 0 end) AS Internet_Type_Null_Count,
    SUM(case when Online_Security IS null then 1 else 0 end) AS Online_Security_Null_Count,
    SUM(case when Online_Backup IS null then 1 else 0 end) AS Online_Backup_Null_Count,
    SUM(case when Device_Protection_Plan IS null then 1 else 0 end) AS Device_Protection_Plan_Null_Count,
    SUM(case when Premium_Support IS null then 1 else 0 end) AS Premium_Support_Null_Count,
    SUM(case when Streaming_TV IS null then 1 else 0 end) AS Streaming_TV_Null_Count,
    SUM(case when Streaming_Movies IS null then 1 else 0 end) AS Streaming_Movies_Null_Count,
    SUM(case when Streaming_Music IS null then 1 else 0 end) AS Streaming_Music_Null_Count,
    SUM(case when Unlimited_Data IS null then 1 else 0 end) AS Unlimited_Data_Null_Count,
    SUM(case when Contract IS null then 1 else 0 end) AS Contract_Null_Count,
    SUM(case when Paperless_Billing IS null then 1 else 0 end) AS Paperless_Billing_Null_Count,
    SUM(case when Payment_Method IS null then 1 else 0 end) AS Payment_Method_Null_Count,
    SUM(case when Monthly_Charge IS null then 1 else 0 end) AS Monthly_Charge_Null_Count,
    SUM(case when Total_Charges IS null then 1 else 0 end) AS Total_Charges_Null_Count,
    SUM(case when Total_Refunds IS null then 1 else 0 end) AS Total_Refunds_Null_Count,
    SUM(case when Total_Extra_Data_Charges IS null then 1 else 0 end ) Total_Extra_Data_Charges_Null_Count,
    SUM(case when Total_Long_Distance_Charges IS null then 1 else 0 end) AS Total_Long_Distance_Charges_Null_Count,
    SUM(case when Total_Revenue IS null then 1 else 0 end) AS Total_Revenue_Null_Count,
    SUM(case when Customer_Status IS null then 1 else 0 end) AS Customer_Status_Null_Count,
    SUM(case when Churn_Category IS null then 1 else 0 end) AS Churn_Category_Null_Count,
    SUM(case when Churn_Reason IS null then 1 else 0 end) AS Churn_Reason_Null_Count
from Customer_Data
select * from Customer_Data

--Check nulls and insert the new data into Customerchurn_data table
select Customer_ID,Gender,Age,Married,State,Number_of_Referrals,Tenure_in_Months,ISNULL(Value_Deal, 'Missing') AS Value_Deal,Phone_Service,
	ISNULL(Multiple_Lines, 'No') As Multiple_Lines,Internet_Service, ISNULL(Internet_Type, 'Missing') AS Internet_Type,
	ISNULL(Online_Security, 'No') AS Online_Security,ISNULL(Online_Backup, 'No') AS Online_Backup,
	ISNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,ISNULL(Premium_Support, 'No') AS Premium_Support,
	ISNULL(Streaming_TV, 'No') AS Streaming_TV,ISNULL(Streaming_Movies, 'No') AS Streaming_Movies,
	ISNULL(Streaming_Music, 'No') AS Streaming_Music,ISNULL(Unlimited_Data, 'No') AS Unlimited_Data,Contract,Paperless_Billing,
	Payment_Method,Monthly_Charge,Total_Charges,Total_Refunds,Total_Extra_Data_Charges,Total_Long_Distance_Charges,Total_Revenue,
	Customer_Status,ISNULL(Churn_Category, 'Others') AS Churn_Category,ISNULL(Churn_Reason , 'Others') AS Churn_Reason
into customerchurn_data from Customer_Data

select * from customerchurn_data

--Creating view for power bi dashboard creation
create view vw_churndata as 
	 select * from customerchurn_data where customer_status in ('Churned','Stayed')

create view vw_joindata as 
	select * from customerchurn_data where customer_status ='Joined'
