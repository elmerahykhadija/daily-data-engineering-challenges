/*
Find all the users who were active for 3 consecutive days or more.

Table
sf_events
*/
with
t_next1 as (
select user_id,record_date as day1,lead(record_date)over (order by record_date) as next1
from sf_events
),
t_next2 as (
select user_id,day1,next1,lead(next1) over (order by next1) as next2
from t_next1
)
select user_id 
from t_next2
where next1-day1=1 and next2-next1=1;