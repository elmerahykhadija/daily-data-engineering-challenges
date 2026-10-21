select distinct c.customer_id,c.customer_name
from online_store_customers c
join online_store_orders o on o.customer_id=c.customer_id
where o.amount > 100;