"""
Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.

DataFrames
customers
orders

"""
# Import your libraries
import pandas as pd
df=customers.merge(orders,left_on="id",right_on="cust_id",how="inner")[["id_x","first_name","total_order_cost"]]
output=df.groupby(["id_x","first_name"]).agg(
    {"total_order_cost":"sum"}
    ).reset_index().sort_values("first_name")
# Start writing code
output