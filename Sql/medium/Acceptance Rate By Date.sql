"""
A social platform's growth team wants to understand how often friend requests result in accepted connections. For each date when friend requests were sent, calculate the proportion of those requests that were accepted.


A request is considered accepted when a matching acceptance record exists for the same sender and receiver. If no matching acceptance record exists, treat the request as not accepted. The acceptance may occur on any date after the request was sent.


Exclude dates on which none of the requests sent were accepted.


Output the request date and the acceptance rate, sorted by date in ascending order.

Table
fb_friend_requests
"""
WITH requests AS (
    SELECT 
        USER_ID_SENDER,
        USER_ID_RECEIVER,
        case 
            when ACTION='sent' then date
        end as date_sending,
        case 
            when ACTION='accepted' then date
            else null
        end as date_accepting
    FROM fb_friend_requests
),
sent_accept AS (
    SELECT 
        USER_ID_SENDER,USER_ID_RECEIVER,max(date_sending)as date_sending,
        max(date_accepting) as date_accepting
    FROM requests
    group by USER_ID_SENDER,USER_ID_RECEIVER
),
t as (
SELECT date_sending,
case 
    when date_accepting is not null then 1
    else 0
    end as n
from sent_accept
)
select date_sending,avg(n) 
FROM t group by date_sending;