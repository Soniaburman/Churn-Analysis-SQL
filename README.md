# Churn Customers Analysis- SQL 
This project explores customer churn patterns using SQL queries on a banking dataset. The goal is to identify key factors that influence customer retention and exit behavior to help the business take data-driven decisions for reducing churn.

## Objectives
1. Identify key behavioral factors influencing customer churn, such as age, credit score, and account activity.
2. Compare churn rates across customer segments, including geography, product usage, income level, and account balance.
3. Deliver actionable insights to help the business understand where churn is highest and what attributes are most predictive of customer exit.

## Project Structure

* Database creation: Created a database named `churn`.
* Table Creation: A table named `customers` is created to store the churn customers data.
  
- **Database Creation:**  
  Created a database named `churn`.

- **Table Creation:**  
  A table named `customers` was created to store customer churn data.

```sql
-- Create the database
CREATE DATABASE churn;

-- Create the customers table
CREATE TABLE customers (
    RowNumber INT,
    CustomerId BIGINT,
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance NUMERIC(12,2),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary NUMERIC(12,2),
    Exited INT
);
```
**Checking my data** 
```sql
SELECT * FROM churn.customers;
```
**What is the overall churn rate ?**
```sql
select count(*) as total_customers,sum(case when exited =1 then 1 else 0 end) as exited_customers,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers;
```
**Is churn rate higher in specific countries (Geography)?**
```sql
select geography,count(*) as total, sum(case when exited = 1 then 1 else 0 end) as churned,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers
group by Geography
order by churn_rate_percent desc;
```
**Does credit score affect customer churn?**
```sql
select exited,round(avg(creditscore),2) as avg_credit_score,
count(*) as num_customers
from Customers
group by exited;
```
**Which age group is most likely to churn?**
```sql
select case 
       when age< 30 then "under 30"
       when age between 30 and 40 then "30-39"
       when age between 40 and 49 then "40-49"
       else "50+"
       end as age_group,
count(*) as Total,
sum(case when exited = 1 then 1 else 0 end) as churned,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers
group by age_group
order by churn_rate_percent desc;
```
**Is there a relationship between number of products and churn?**
```sql
select numofproducts,
count(*) as Total,
sum(case when exited = 1 then 1 else 0 end) as churned,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers
group by numofproducts
order by numofproducts ;
```
**Does Customer balance impact churn?**
```sql
select case 
       when balance = 0 then 'Zero'
       when balance between 1 and 100000 then 'Low Balance'
       else 'High Balance'
       end as BalanceGroup,
count(*) as Total,
sum(case when exited = 1 then 1 else 0 end) as churned,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers
group by BalanceGroup
order by churn_rate_percent desc;
```
**Is there difference in churn between active and inactive members?**
```sql
select isactivemember,count(*) as Total,sum(case when exited = 1 then 1 else 0 end) as churned
from Customers
group by isactivemember;
```
**Is Number of years with Bank related to churn?**
```sql
select tenure,count(*) as Total,sum(case when exited = 1 then 1 else 0 end) as churned
from Customers
group by tenure
order by churned desc;
```
**Does income level affect churn?**
```sql
SELECT CASE 
    WHEN EstimatedSalary < 50000 THEN 'Low Income'
    WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN 'Mid Income'
    ELSE 'High Income'
  END AS IncomeGroup,
COUNT(*) AS Total,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned
FROM churn.customers
GROUP BY IncomeGroup;
```
**What is the average churn rate by geography compared to the overall churn rate?**
```sql
WITH GeoChurn AS (SELECT Geography,
         COUNT(*) AS TotalCustomers,
         SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers
FROM churn.customers
GROUP BY Geography),
GeoChurnWithRate AS (SELECT *,
         ROUND((ChurnedCustomers * 100.0 / TotalCustomers), 2) AS GeoChurnRate,
         ROUND(AVG(ChurnedCustomers * 100.0 / TotalCustomers) 
               OVER (), 2) AS OverallAvgChurnRate
FROM GeoChurn)
SELECT *
FROM GeoChurnWithRate;
```
## Key Insights
1. Germany had the highest churn rate among all geographies.
2. Customers aged 50 and above were more likely to churn.
3. Customers with multiple products or inactive accounts showed higher exit rates.
4. Low balance customers had the lowest churn, possibly due to lower engagement.


