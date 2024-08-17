import pandas as pd
import psycopg2 as psy2

#df = pd.read_csv("/Users/leonupshaw/Desktop/Coffee_Data/coffeesales.csv")
def psql_upload(file_path):
    df = file_path
    conn = psy2.connect(
        dbname= "leonupshaw",
        user= "leonupshaw",
        password= "",
        host= "localhost",
        port="5432"
    )
    cur = conn.cursor()

    createTable ="""
        CREATE TABLE IF NOT EXISTS coffee_sales(
            date DATE,
            cash_type TEXT,
            card VARCHAR,
            money NUMERIC,
            coffee_name TEXT
    )"""

    cur.execute(createTable)

    with open(df, 'r') as f:
        cur.copy_expert("COPY coffee_sales FROM STDIN WITH CSV HEADER", f)
    conn.commit()
    cur.close()
    conn.close()
    print("Uploaded to PSQL successfully")