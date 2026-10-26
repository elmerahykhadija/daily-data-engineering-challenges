/*This is the same question as problem #11 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

transactions Table:
Column Name	Type
user_id	integer
spend	decimal
transaction_date	timestamp*/
select user_id,spend,transaction_date
from (
SELECT user_id,spend,transaction_date,row_number() over (PARTITION BY user_id order by transaction_date) as ordering
FROM transactions
) as cte 
where ordering=3;