import pyodbc
import pandas as pd


def get_connection():
    conn_str = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER;"
        "DATABASE=;"
        "UID=;"
        "PWD=******;"
        "TrustServerCertificate=yes;"
    )

    return pyodbc.connect(conn_str)


def run_query(query, params=None):
    conn = get_connection()
    try:
        df = pd.read_sql(query, conn, params=params)
    finally:
        conn.close()

    return df
