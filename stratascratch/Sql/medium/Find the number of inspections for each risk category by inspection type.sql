/*
A city health department wants to see how inspection outcomes break down by risk level for each type of inspection it runs. Each inspection can have multiple violation records, and each record carries its own risk category (or none). For each inspection, take the highest-severity risk category among its records — ranked High Risk > Moderate Risk > Low Risk > no risk category — and count that inspection once, under its inspection type, in the corresponding risk category.


If none of an inspection's records have a risk category, count that inspection under its own no-risk-category bucket.


Output the inspection type, the count of inspections in each risk category (no risk category, low risk, moderate risk, high risk) as separate columns, and the total number of inspections for that inspection type, sorted by the total number of inspections per inspection type in descending order.

Table
sf_restaurant_health_violations

*/
with 
t1 as (
select inspection_id,inspection_type,
min(case when risk_category="High Risk" then 1
when risk_category="Moderate Risk" then 2
when risk_category="Low Risk" then 3
else 4
end) as n 
from sf_restaurant_health_violations
group by inspection_id,inspection_type
),

risk_columns as (
select inspection_type,
case when n=3 then 1 
else 0
end as low_risk,
case when n=2 then 1 
else 0
end as moderate_risk,
case when n=4 then 1 
else 0
end as no_risk,
case when n=1 then 1 
else 0
end as high_risk
from t1
)
select inspection_type,sum(low_risk) as low_risk,sum(moderate_risk) as moderate_risk,sum(high_risk) as high_risk,sum(no_risk) as no_risk,sum(low_risk)+sum(moderate_risk)+sum(high_risk)+sum(no_risk)as total
from risk_columns
group by inspection_type
order by total desc ;

