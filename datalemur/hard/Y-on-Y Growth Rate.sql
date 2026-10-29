/*This is the same question as problem #32 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.

user_transactions Table:
Column Name	Type
transaction_id	integer
product_id	integer
spend	decimal
transaction_date	datetime*/
with CTE as (
SELECT EXTRACT(year from transaction_date) as year,
       product_id,spend as curr_year_spend, 
       lag(spend) over (PARTITION by product_id order by transaction_date) as prev_year_spend
FROM user_transactions
)
select year,product_id,curr_year_spend,prev_year_spend,
       CASE 
          WHEN prev_year_spend is NULL then NULL
          ELSE round((100.0*(curr_year_spend- prev_year_spend)/prev_year_spend),2)
          end as yoy_rate
FROM CTE 
;