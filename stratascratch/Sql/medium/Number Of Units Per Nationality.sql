/*
Write a query that returns how many different apartment-type units (counted by distinct unit_id) are owned by people under 30, grouped by their nationality. Sort the results by the number of apartments in descending order.

Tables
airbnb_hosts
airbnb_units

*/
with t1 as (
select h.host_id,h.nationality,u.unit_id
from airbnb_hosts h
join airbnb_units u on h.host_id=u.host_id
where h.age<30 and u.unit_type="Apartment"
)
select nationality,count(distinct unit_id) as apartment_count
from t1
group by nationality ;