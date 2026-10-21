/*
Top Cool Votes

Find the review_text that received the highest number of  cool votes.
Output the business name along with the review text with the highest number of cool votes.

Table
yelp_reviews
*/
with t1 as(
select business_name,review_text,sum(cool) as total_sum
from yelp_reviews
group by review_id,review_text
order by sum(cool) desc,business_name
)
select business_name,review_text
from t1
where total_sum=( select max(total_sum) from t1);
