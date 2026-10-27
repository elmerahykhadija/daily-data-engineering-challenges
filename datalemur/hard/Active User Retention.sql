/*This is the same question as problem #23 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".

Hint:

An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.
user_actions Table:
Column Name	Type
user_id	integer
event_id	integer
event_type	string ("sign-in, "like", "comment")
event_date	datetime
*/
with cte as (
SELECT * FROM user_actions
where (event_type ='sign-in' or event_type='like') 
      and 
      ((EXTRACT(month from event_date)=7 or (EXTRACT(month from event_date)=6 )  and EXTRACT(YEAR FROM event_date)=2022) )
),
t2 as (
SELECT distinct user_id,EXTRACT(month from event_date) as months ,
      count(*) over(partition by user_id) as n
from cte 
)
select months,count(*)
from t2
where months=7 and n >1
GROUP by months;