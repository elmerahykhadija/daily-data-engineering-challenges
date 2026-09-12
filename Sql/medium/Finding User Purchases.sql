"""
Identify returning active users by finding users who made a second purchase within 1 to 7 days after their first purchase. Ignore same-day purchases. Output a list of these user_ids.

Table
amazon_transactions
"""
with t1 as (
select user_id, min(created_at) over (partition by user_id) as first_purchase,lead(created_at) over(partition by user_id order by created_at) as next_purchases
from amazon_transactions
), 
t2 as (
select user_id,first_purchase, next_purchases, row_number() over (partition by user_id order by next_purchases) as n
from t1
where next_purchases is not null 
),
t3 as (
select user_id,first_purchase, next_purchases,DATEDIFF(next_purchases,first_purchase) as diff
from t2
where n=1
)
select user_id
from t3
where diff  between 1 and 7;
