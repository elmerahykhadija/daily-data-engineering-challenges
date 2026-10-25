/*Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

Assumption:

No two users have sent the same number of messages in August 2022.
messages Table:
Column Name	Type
message_id	integer
sender_id	integer
receiver_id	integer
content	varchar
sent_date	datetime
*/
with onlyaugust22 as (
SELECT *
FROM messages
where EXTRACT(MONTH from sent_date)=8 and EXTRACT(year from sent_date)=2022
),
t1 as(
SELECT DISTINCT sender_id,count(*) over (PARTITION by sender_id) as n
from onlyaugust22
order by n desc
)
select * from t1 limit 2;