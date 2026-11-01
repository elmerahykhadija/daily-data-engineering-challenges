/*This is the same question as problem #10 in the SQL Chapter of  Ace the Data Science Interview!

Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

Notes:
- A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time. 
- In this case, we want to determine how the tweet count for each user changes over a 3-day period.

*Effective April 7th, 2023, the problem statement, solution and hints for this question have been revised.*

tweets Table:
Column Name	Type
user_id	integer
tweet_date	timestamp
tweet_count	integer

tweets Example Input:
user_id	tweet_date	tweet_count
111	06/01/2022 00:00:00	2
111	06/02/2022 00:00:00	1
111	06/03/2022 00:00:00	3
111	06/04/2022 00:00:00	4
111	06/05/2022 00:00:00	5

Example Output:
user_id	tweet_date	rolling_avg_3d
111	06/01/2022 00:00:00	2.00
111	06/02/2022 00:00:00	1.50
111	06/03/2022 00:00:00	2.00
111	06/04/2022 00:00:00	2.67
111	06/05/2022 00:00:00	4.00

The dataset you are querying against may have different input & output - this is just an example!*/
with 
t1 as (
select user_id,tweet_date,tweet_count,
lag(tweet_count)over(partition by user_id order by tweet_date)as p1
from tweets
),
t2 as (
select user_id,tweet_date,tweet_count,p1,
lag(p1)over(partition by user_id order by tweet_date)as p2
from t1
),
t3 as (
select user_id,tweet_date,
case 
when p1 is NULL and p2 is  null then 1.0
when p1 is not null and p2 is null then 2.0
when p1 is not null and p2 is not null then 3.0
end as diviseur
 ,
case 
when tweet_count is NULL THEN 0
else tweet_count
end ,
case 
when p1 is NULL THEN 0
else p1
end,
case 
when p2 is NULL THEN 0
else p2
end
from t2
)
select user_id,tweet_date,round((tweet_count+p1+p2)/diviseur,2)
from t3;
