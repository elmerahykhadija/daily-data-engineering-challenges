/*
Calculate number of reviews for every business category. Output the category along with the total number of reviews. Order by total reviews in descending order.

Table
yelp_business
*/
SELECT y.categories,SUM(t.review_count) as total
from yelp_business t
join JSON_TABLE(
CONCAT('["',REPLACE(categories,';','","'),'"]'),
"$[*]" COLUMNS(
categories VARCHAR(255) PATH '$'
)
) y 
group by y.categories
order by total desc;