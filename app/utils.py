from joblib import load
from datetime import datetime, timedelta

import pandas as pd
import pyodbc

def pull_data(date, city, forecast_type, store, prediction_type):
    
    conn_str = (
        r'DRIVER={ODBC Driver 17 for SQL Server};'
        r'SERVER=...;'  
        r'DATABASE=Retail;'  
        r'UID=...;'  
        r'PWD=...'  
    )
        
    conn = pyodbc.connect(conn_str)
    
   # Convert date to string
    date_string = date.dt.strftime('%Y-%m-%d').values[0]
    
    # Determine table
    if (forecast_type == 'daily') & (prediction_type == 'sales'):
        query = f"SELECT * FROM FT_DAILY_SALES AS F JOIN FT_STORE AS S ON F.store_id = S.store_id WHERE S.city_id = '{city}' AND F.store_id = '{store}' AND date = '{date_string}' "
    elif (forecast_type == 'daily') & (prediction_type == 'revenue'):
        query = f"SELECT * FROM FT_DAILY_REVENUE AS F JOIN FT_STORE AS S ON F.store_id = S.store_id WHERE S.city_id = '{city}' AND F.store_id = '{store}' AND date = '{date_string}' " 
    elif (forecast_type == 'weekly') & (prediction_type == 'sales'):
        query = f"SELECT * FROM FT_WEEKLY_SALES AS F JOIN FT_STORE AS S ON F.store_id = S.store_id WHERE S.city_id = '{city}' AND F.store_id = '{store}' AND date = '{date_string}' "
    elif (forecast_type == 'weekly') & (prediction_type == 'revenue'):
        query = f"SELECT * FROM FT_WEEKLY_REVENUE AS F JOIN FT_STORE AS S ON F.store_id = S.store_id WHERE S.city_id = '{city}' AND F.store_id = '{store}' AND date = '{date_string}'"
    
    print("Date is: ", date_string)
    
    df = pd.read_sql_query(query, conn)
    df = df.iloc[-1:]
    
    print("DATABASE RETURNED: \n", df.head())

    return df


def load_models():
    models = {
        'sales_C014_daily': load('models/model_daily_c14_sales.joblib'),
        'revenue_C014_daily': load('models/model_daily_c14_rev.joblib'),
        
        'sales_C022_daily': load('models/model_daily_c22_sales.joblib'),
        'revenue_C022_daily': load('models/model_daily_c22_rev.joblib'),
        
        'sales_C024_daily': load('models/model_daily_c24_sales.joblib'),
        'revenue_C024_daily': load('models/model_daily_c24_rev.joblib'),
        
        'sales_C031_daily': load('models/model_daily_c31_sales.joblib'),
        'revenue_C031_daily': load('models/model_daily_c31_rev.joblib'),
        
        'sales_C014_weekly': load('models/model_weekly_c14_sales.joblib'),
        'revenue_C014_weekly': load('models/model_weekly_c14_rev.joblib'),
        
        'sales_C022_weekly': load('models/model_weekly_c22_sales.joblib'),
        'revenue_C022_weekly': load('models/model_weekly_c22_rev.joblib'),
        
        'sales_C024_weekly': load('models/model_weekly_c24_sales.joblib'),
        'revenue_C024_weekly': load('models/model_weekly_c24_rev.joblib'),
        
        'sales_C031_weekly': load('models/model_weekly_c31_sales.joblib'),
        'revenue_C031_weekly': load('models/model_weekly_c31_rev.joblib')
    }

    return models

def preprocess_input(input_data):
    # Convert the input data into dataframe format
    df = pd.DataFrame([input_data])

    # Extract the necessary information for model selection
    city = df['city_id'][0]
    forecast_type = df['forecast_type'][0]
    prediction_type = df['prediction_type'][0]
    
    df['store_id'] = df['store_id'].str.replace('S', '').astype(int)
    store = df['store_id'][0]
    
    # Remove the unnecessary columns from the input data
    df = df.drop(['city_id', 'forecast_type', 'prediction_type'], axis=1)

    # Convert the 'date' column to datetime
    df['date'] = pd.to_datetime(df['date'], format="%Y-%m-%d")

    # Get the data of the previous day or week
    if forecast_type == 'daily':
        previous_date = df['date'] - pd.DateOffset(days=1)
    elif forecast_type == 'weekly':
        previous_date = df['date'] - pd.DateOffset(weeks=1)

    # Extract features from the database and process
    df_prev = pull_data(previous_date, city, forecast_type, store, prediction_type)
    
    df_prev = rename_duplicates(df_prev)
    df_prev = df_prev.drop('store_size', axis=1)
    df_prev = clean_data(df_prev)
    
    print("PROCESSED DATA: \n", df_prev)
    
    return df_prev, city, forecast_type, prediction_type

def clean_data(df):
    
    # Setting the index to date
    df = df.set_index('date')
    df.index = pd.to_datetime(df.index)
    df.sort_index(inplace=True)
    
    # Dropping object datatype columns
    object_columns = df.dtypes[df.dtypes == 'object'].index
    df.drop(object_columns, axis=1, inplace=True)
    
    df.dropna(inplace=True)
    return df

def rename_duplicates(df):
    # Rename duplicate columns
    cols=pd.Series(df.columns)
    for dup in df.columns[df.columns.duplicated(keep=False)]: 
        cols[df.columns.get_loc(dup)] = ([dup + '.' + str(d_idx) 
                                        if d_idx != 0 
                                        else dup 
                                        for d_idx in range(df.columns.get_loc(dup).sum())]
                                        )

    df.columns = cols
    return df

