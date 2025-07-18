# Churn Customers Analysis- SQL 
This project explores customer churn patterns using SQL queries on a banking dataset. The goal is to identify key factors that influence customer retention and exit behavior to help the business take data-driven decisions for reducing churn.

## Objectives
1. Identify key behavioral factors influencing customer churn, such as age, credit score, and account activity.
2. Compare churn rates across customer segments, including geography, product usage, income level, and account balance.
3. Deliver actionable insights to help the business understand where churn is highest and what attributes are most predictive of customer exit.

## Project Structure

1. Database Setup
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

