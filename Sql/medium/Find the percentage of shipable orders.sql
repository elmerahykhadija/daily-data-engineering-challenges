/*
Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.

Tables
orders
customers
*/
with t1 as (
select o.id , c.address,
case when c.address is null then 0
else 1
end as n
from orders o
join customers c on c.id=o.cust_id)
select 100.0*sum(n)/count(*) 
from t1;