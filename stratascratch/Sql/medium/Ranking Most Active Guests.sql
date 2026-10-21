"""
Identify the most engaged guests by ranking them according to their overall messaging activity. The most active guest, meaning the one who has exchanged the most messages with hosts, should have the highest rank. If two or more guests have the same number of messages, they should have the same rank. Importantly, the ranking shouldn't skip any numbers, even if many guests share the same rank. Present your results in a clear format, showing the rank, guest identifier, and total number of messages for each guest, ordered from the most to least active.

Table
airbnb_contacts

"""
with t1 as (
select id_guest,sum(n_messages) as total_msgs
from airbnb_contacts
group by id_guest
)
select id_guest,dense_rank() over(order by total_msgs desc ) as ranking,total_msgs
from t1;