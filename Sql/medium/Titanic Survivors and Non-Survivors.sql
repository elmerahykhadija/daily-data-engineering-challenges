/*
Make a report showing the number of survivors and non-survivors by passenger class. Classes are categorized based on the pclass value as:


•	First class: pclass = 1
•	Second class: pclass = 2
•	Third class: pclass = 3


Output one row per survival status, with a column for the number of passengers in each class.

Table
titanic
*/
with t1 as (
select survived,
case when pclass=1  then 1  
else 0 end as First_class,
case when pclass=2 then 1 
else 0  end as Second_class,
case when pclass=3 then 1 
else 0 end as third_class
from titanic
)
select survived,sum(First_class) as First_class,sum(Second_class) as Second_class,sum(third_class) as third_class
from t1 
group by survived
;