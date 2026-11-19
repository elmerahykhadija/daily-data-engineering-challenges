"""
Find the number of inspections for each risk category by inspection type
A city health department wants to see how inspection outcomes break down by risk level for each type of inspection it runs. Each inspection can have multiple violation records, and each record carries its own risk category (or none). For each inspection, take the highest-severity risk category among its records — ranked High Risk > Moderate Risk > Low Risk > no risk category — and count that inspection once, under its inspection type, in the corresponding risk category.


If none of an inspection's records have a risk category, count that inspection under its own no-risk-category bucket.


Output the inspection type, the count of inspections in each risk category (no risk category, low risk, moderate risk, high risk) as separate columns, and the total number of inspections for that inspection type, sorted by the total number of inspections per inspection type in descending order.

Table
sf_restaurant_health_violations

"""
import pyspark
from pyspark.sql.functions import count,when,col,sum,max
from pyspark.sql.window import Window
df1=sf_restaurant_health_violations.withColumn(
    "counting",when(col("risk_category")=="High Risk",3).when(col("risk_category")=="Moderate Risk",2).when(col("risk_category").isNull(),0).otherwise(1)
    )
df1=df1.groupBy(["inspection_id","inspection_type"]).agg(
    max(col("counting")).alias("maxi")
    )
df=df1.withColumns(
    {
    "high_risk_results" : when(col("maxi")==3,1).otherwise(0),
    "medium_risk_results":when(col("maxi")==2,1).otherwise(0),
    "low_risk_results":when(col("maxi")==1,1).otherwise(0),
    "no_risk_results":when(col("maxi")==0,1).otherwise(0)
    }
)
df=df.select(["inspection_type","high_risk_results","medium_risk_results","low_risk_results","no_risk_results"])
df=df.groupBy("inspection_type").agg(
    sum("high_risk_results").alias("high_risk_results"),
    sum("medium_risk_results").alias("medium_risk_results"),
    sum("low_risk_results").alias("low_risk_results"),
    sum("no_risk_results").alias("no_risk_results")
    )
df=df.withColumn(
    "total_inspections",col("high_risk_results")+col("medium_risk_results")+col("low_risk_results")+col("no_risk_results")
    )
df=df.orderBy(col("total_inspections").desc())
df.toPandas()