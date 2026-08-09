import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Seed for reproducibility
np.random.seed(42)

# Generate 1,000 unique Customer IDs
customer_ids = [f"CUST-{1000 + i}" for i in range(1000)]

# Product Categories
categories = ['Electronics', 'Fashion', 'Home & Kitchen', 'Beauty', 'Sports']

# Generate 10,000 transaction records
num_records = 10000
end_date = datetime(2026, 8, 1)
start_date = end_date - timedelta(days=365)

data = {
    'InvoiceNo': [f"INV-{100000 + i}" for i in range(num_records)],
    'CustomerID': np.random.choice(customer_ids, num_records),
    'OrderDate': [start_date + timedelta(days=int(np.random.randint(0, 365))) for _ in range(num_records)],
    'Category': np.random.choice(categories, num_records, p=[0.2, 0.3, 0.25, 0.15, 0.1]),
    'Quantity': np.random.randint(1, 5, num_records),
    'UnitPrice': np.round(np.random.uniform(10.0, 500.0, num_records), 2),
    'Country': np.random.choice(['India', 'USA', 'UK', 'UAE', 'Canada'], num_records, p=[0.5, 0.2, 0.15, 0.1, 0.05])
}

df = pd.DataFrame(data)
df['TotalAmount'] = df['Quantity'] * df['UnitPrice']

# Save to CSV
df.to_csv('ecommerce_transactions.csv', index=False)
print("SUCCESS: 'ecommerce_transactions.csv' created with 10,000 records!")