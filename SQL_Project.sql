use churn;
-- Checking my data 
SELECT * FROM churn.customers;

-- Obj 1: What is the overall churn rate ?
select count(*) as total_customers,sum(case when exited =1 then 1 else 0 end) as exited_customers,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers;

-- obj 2: Is churn rate higher in specific countries (Geography)?
select geography,count(*) as total, sum(case when exited = 1 then 1 else 0 end) as churned,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers
group by Geography
order by churn_rate_percent desc;

-- Obj 3: Does credit score affect customer churn?
select exited,round(avg(creditscore),2) as avg_credit_score,
count(*) as num_customers
from Customers
group by exited;

-- obj 4: Which age group is most likely to churn?
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
       
-- Obj 5: Is there a relationship between number of products and churn?
select numofproducts,
count(*) as Total,
sum(case when exited = 1 then 1 else 0 end) as churned,
round(sum(case when exited =1 then 1 else 0 end)/count(*)*100,2) as churn_rate_percent
from Customers
group by numofproducts
order by numofproducts ;

-- Obj 6: Does Customer balance impact churn?
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

-- Obj 7: Is there difference in churn between active and inactive members?
select isactivemember,count(*) as Total,sum(case when exited = 1 then 1 else 0 end) as churned
from Customers
group by isactivemember;

-- Obj 8: Is Number of years with Bank related to churn?
select tenue,count(*) as Total,sum(case when exited = 1 then 1 else 0 end) as churned
from Customers
group by tenue
order by churned desc;

-- Obj 9: Does income level affect churn?
SELECT CASE 
    WHEN EstimatedSalary < 50000 THEN 'Low Income'
    WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN 'Mid Income'
    ELSE 'High Income'
  END AS IncomeGroup,
COUNT(*) AS Total,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned
FROM churn.customers
GROUP BY IncomeGroup;

-- 10: What is the average churn rate by geography compared to the overall churn rate?
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


