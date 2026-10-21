/*Find the processed rate of tickets for each type. The processed rate is defined as the number of processed tickets divided by the total number of tickets for that type. Round this result to two decimal places.

Table
facebook_complaints
*/
with cte as (
select distinct type,sum(processed) over (partition by type) as prs,count(*) over(partition by type) as total
from facebook_complaints
)
select type,prs/total
from cte;