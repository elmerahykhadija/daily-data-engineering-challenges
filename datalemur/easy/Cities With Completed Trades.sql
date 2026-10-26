/*This is the same question as problem #2 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders.

trades Table:
Column Name	Type
order_id	integer
user_id	integer
quantity	integer
status	string ('Completed', 'Cancelled')
date	timestamp
price	decimal (5, 2)

users Table:
Column Name	Type
user_id	integer
city	string
email	string
signup_date	datetime
*/
with OnlyCompleted as(
SELECT t.order_id,u.user_id,u.city 
FROM trades t 
join users u on u.user_id=t.user_id
WHERE status='Completed'
)
SELECT city,count(*) as completed_number
from OnlyCompleted
group by city 
order by completed_number desc
limit 3;
