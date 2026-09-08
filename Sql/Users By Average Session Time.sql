/*
Calculate each user's average session time, where a session is defined as the time difference between a page_load and a page_exit. Assume each user has only one session per day. If there are multiple page_load or page_exit events on the same day, use only the latest page_load and the earliest page_exit. Only consider sessions where the page_load occurs before the page_exit on the same day. Output the user_id and their average session time.

Table
facebook_web_log
*/
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
