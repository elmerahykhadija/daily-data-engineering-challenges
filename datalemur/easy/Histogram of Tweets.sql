/*Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.*/
with t1 as (
SELECT user_id,count(*)  as tweet_bucket
FROM tweets
where EXTRACT(year from tweet_date)=2022
group by user_id
)
select tweet_bucket,count(*) as user_num
from t1
group by tweet_bucket;