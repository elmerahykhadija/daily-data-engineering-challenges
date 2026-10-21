/*
Monthly Percentage Difference
Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.

Table
sf_transactions
*/
with t1 as(
select to_char(created_at,'YYYY-MM') AS date, sum(value) as total
from sf_transactions
group by to_char(created_at,'YYYY-MM')
),
t2 as (
select date,lag(date) over( order by date ) as previus,total 
from t1
),
t3 as(
select a.date,a.total,a.previus,b.total as previus_total
from t2 a
left join t1 b on a.previus=b.date
)
select date ,100.0*(total-previus_total)/previus_total
from t3;