"""
A company wants to review compensation only for workers who have an official job title on record, since pay can't be properly benchmarked against a role that isn't documented. Find the job titles of the workers with the highest salary among those who have a matching record in the title table. If multiple workers share the highest salary, include all of their job titles.


Output the job title(s), sorted alphabetically.

Tables
worker
title
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import max
df=worker.join(
   title,
   worker["worker_id"]==title["worker_ref_id"],
    how="inner"
    )
maximum=df.select(max("salary")).first()[0]
df=df.filter(df["salary"]==maximum)


df=df.select("worker_title")
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()