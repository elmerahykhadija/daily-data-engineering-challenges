/*Make the friends network symmetric.
For example, if 0 and 1 are friends, have the output contain both 0 and 1 under 1 and 0 respectively.

Table
google_friends_network*/

(select user_id as u1,friend_id as u2
from google_friends_network)
union 
(select friend_id as u1,user_id as u2
from google_friends_network)
;