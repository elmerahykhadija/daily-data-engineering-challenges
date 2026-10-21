/*Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

pages Table:
Column Name	Type
page_id	integer
page_name	varchar

page_likes Table:
Column Name	Type
user_id	integer
page_id	integer
liked_date	datetime
*/
with t1 as (
SELECT a.page_id,b.liked_date
FROM pages a
left join page_likes b on a.page_id=b.page_id
),
t2 as (
select page_id,
case 
  when liked_date is null then 0
  else 1
  end as n
from t1
),
t3 as(
select page_id,sum(n) as somme
from t2
group by page_id
)
SELECT page_id
from t3 
where somme=0
order by page_id;
