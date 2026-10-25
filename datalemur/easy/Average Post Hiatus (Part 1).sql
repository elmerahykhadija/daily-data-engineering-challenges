/*Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

p.s. If you've read the Ace the Data Science Interview and liked it, consider writing us a review?

posts Table:
Column Name	Type
user_id	integer
post_id	integer
post_content	text
post_date	timestamp*/
with two_posts2021 as (
select distinct user_id 
from (
  select user_id,post_id,post_content,post_date,count(*) over(partition by user_id) as N 
  from posts
  where EXTRACT(year from post_date)=2021
) as t
where n>=2  
),
t1 as (
select a.user_id,a.post_id,a.post_content,a.post_date
from posts a 
JOIN two_posts2021 b on b.user_id=a.user_id

)
select user_id,max(post_date)::date - min(post_date)::date as days_between
from t1
group by user_id
order by days_between;