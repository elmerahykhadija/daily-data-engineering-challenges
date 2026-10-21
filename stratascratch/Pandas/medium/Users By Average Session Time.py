"""
Calculate each user's average session time, where a session is defined as the time difference between a page_load and a page_exit. Assume each user has only one session per day. If there are multiple page_load or page_exit events on the same day, use only the latest page_load and the earliest page_exit. Only consider sessions where the page_load occurs before the page_exit on the same day. Output the user_id and their average session time.

DataFrame
facebook_web_log

"""
# Import your libraries
import pandas as pd
#df for page exit
df_page_exit=(
    facebook_web_log[facebook_web_log["action"]=="page_exit"].groupby(["user_id",facebook_web_log["timestamp"].dt.date])
        .agg(page_exit=("timestamp","min"))
        .reset_index()
        .rename(columns={"timestamp":"jr"})
)
df_page_load=(
       facebook_web_log[facebook_web_log["action"]=="page_load"]
       .groupby(["user_id",facebook_web_log["timestamp"].dt.date])
       .agg(page_load=("timestamp","max"))
       .reset_index()
       .rename(columns={"timestamp":"jr"})
)
df=(
    df_page_load.merge(df_page_exit,on=["user_id","jr"],how="inner")
)
df=df[df["page_load"]<df["page_exit"]]
df["session"]=df["page_exit"]-df["page_load"]
df=df.groupby("user_id").agg(avg_session_duration=("session","mean")).reset_index()

df.head()