/*Calculate the percentage of users who are both from the US and have an 'open' status, as indicated in the fb_active_users table.

Table
fb_active_users
*/
with t1 as ( 
select user_id,
case 
    when (status='open') and (country='USA') then 1
    else 0 
    end as n
from fb_active_users
) 
select 100.0*SUM("n") /(select count(*) from fb_active_users) as us_active_share
from t1;