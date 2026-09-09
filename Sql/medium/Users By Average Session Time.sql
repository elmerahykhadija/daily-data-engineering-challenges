/*
Calculer le temps moyen de session pour chaque utilisateur.
Une session correspond à la différence entre un page_load et un page_exit.
On suppose qu'un utilisateur n'a qu'une seule session par jour.
Si plusieurs événements page_load ou page_exit se produisent le même jour,
on conserve le dernier page_load et le premier page_exit.
On ne considère que les sessions où page_load se produit avant page_exit le même jour.
Sortie: user_id et durée moyenne de session.

Table:
facebook_web_log
*/

/* Version 1 */
WITH pLoad AS (
select user_id,date(timestamp) as jr,max(timestamp) as page_load
from facebook_web_log
where action='page_load'
group by user_id,action,date(timestamp)
),
pExit as (
select user_id,date(timestamp) as jr,min(timestamp) as page_exit
from facebook_web_log
where action='page_exit'
group by user_id,action,date(timestamp)
),
t as (
select l.user_id,TIMESTAMPDIFF(second, l.page_load, e.page_exit)  as session,e.jr
from pLoad l
join pExit e on (l.user_id=e.user_id) and (l.jr=e.jr)
where l.page_load < e.page_exit
)
select  user_id , avg(session) as avg_session_duration
from t
group by user_id;

/* Version 2 */
WITH
t1 AS (
    SELECT
        user_id,
        timestamp,
        action,
        CAST(timestamp AS DATE) AS day_action
    FROM facebook_web_log
    WHERE action LIKE 'page_load' OR action LIKE 'page_exit'
),

t2 AS (
    SELECT
        user_id,
        day_action,
        timestamp,
        action,
        CASE
            WHEN action = 'page_exit' THEN
                ROW_NUMBER() OVER (PARTITION BY user_id, day_action, action ORDER BY timestamp)
            ELSE ROW_NUMBER() OVER (PARTITION BY user_id, day_action, action ORDER BY timestamp DESC)
        END AS rn
    FROM t1
),

t3 AS (
    SELECT
        user_id,
        day_action,
        MAX(
            CASE
                WHEN action = 'page_load' THEN action
            END
        ) AS page_load,
        MAX(
            CASE
                WHEN action = 'page_load' THEN timestamp
            END
        ) AS time_load,
        MAX(CASE
            WHEN action = 'page_exit' THEN action
        END) AS page_exit,
        MAX(CASE
            WHEN action = 'page_exit' THEN timestamp
        END) AS time_exit
    FROM t2
    WHERE rn = 1
    GROUP BY user_id, day_action
),

t4 AS (
    SELECT
        user_id,
        day_action,
        time_exit - time_load AS diff
    FROM t3
    WHERE time_load < time_exit
)

SELECT
    user_id,
    AVG(diff) AS moyenne
FROM t4
GROUP BY user_id
ORDER BY moyenne DESC;
