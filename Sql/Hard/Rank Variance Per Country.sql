/*
Compare the total number of comments made by users in each country during December 2019 and January 2020.
For each month, rank countries by their total number of comments in descending order. Countries with the same total should share the same rank, and the next rank should increase by one (without skipping numbers).
Return the names of the countries whose rank improved from December to January (that is, their rank number became smaller).

Tables
fb_comments_count
fb_active_users
*/
with t1 as (
select c.user_id,EXTRACT(YEAR FROM c.created_at) AS years,EXTRACT(MONTH FROM c.created_at) AS months,c.number_of_comments,u.country
from fb_comments_count c
join fb_active_users u on c.user_id=u.user_id
),
t_2019 as (
select years,months,country,sum(number_of_comments) as total19
from t1 
where (years=2019 and months=12 ) 
group by years,months,country
),
t_2020 as (
select years,months,country,sum(number_of_comments) as total20
from t1 
where (years=2020 and months=1 ) 
group by years,months,country
),
tab as (
select a.country,dense_rank() over (order by a.total19 desc ) as n19 , dense_rank() over (order by b.total20 desc ) as n20
from t_2019 a
join t_2020 b on a.country=b.country
)

select country 
from tab
where n20<n19;