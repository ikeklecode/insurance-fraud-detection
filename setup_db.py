import pandas as pd
import sqlite3

df = pd.read_csv(r'/Users/ilyeshaddane/Desktop/insurance-fraud-detection/data/carclaims.csv')

# link sqlite db
conn = sqlite3.connect('data/insurance.db')

# claim le db
df.to_sql('claims', conn, if_exists='replace', index=False)