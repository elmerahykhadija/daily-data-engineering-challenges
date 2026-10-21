/*This is the same question as problem #3 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

Effective 15 April 2023, the solution has been updated with a more concise and easy-to-understand approach.

viewership Table
Column Name	Type
user_id	integer
device_type	string ('laptop', 'tablet', 'phone')
view_time	timestamp
*/
with t1 as(
SELECT count(*) as laptop_reviews
FROM viewership
where device_type='laptop'
),
t2 as(
select count(*) as mobile_views
FROM viewership
where device_type!='laptop'
)
select a.laptop_reviews,b.mobile_views
from t1 a 
CROSS join t2 b ;
