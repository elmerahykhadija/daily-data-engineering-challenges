/*
Find all possible varieties which occur in either of the winemag datasets.
Output unique variety values only.
Sort records based on the variety in ascending order.

Tables
winemag_p1
winemag_p2
*/
select variety
from (
    (select distinct variety from winemag_p1)
    union 
    (select distinct variety from winemag_p2)) as t1
order by variety;