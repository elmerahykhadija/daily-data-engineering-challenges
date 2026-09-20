/*
Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
Output the host id and the guest id of matched pair.

Tables
airbnb_hosts
airbnb_guests
*/
select distinct h.host_id,g.guest_id
from airbnb_hosts h
join airbnb_guests g on (h.gender=g.gender) and (h.nationality=g.nationality)
 ;