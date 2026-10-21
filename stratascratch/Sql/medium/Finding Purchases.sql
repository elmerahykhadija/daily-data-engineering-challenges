/*
Identify returning active users by finding users who made a repeat purchase within 7 days or less of their previous transaction, excluding same-day purchases. Output a list of these user_id.

Table
amazon_transactions
*/
with t1 as (
select user_id,item,created_at,count(*) over (partition by user_id )as n ,lag(created_at) over(partition by user_id order by created_at)previous_date
from amazon_transactions
),
t2 as (
select  user_id,DATEDIFF(created_at,previous_date) as diff
from t1
where previous_date is not null 

)
select distinct user_id 
from t2
where diff between 1 and 7

;