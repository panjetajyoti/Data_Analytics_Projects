import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Seed for reproducibility
np.random.seed(42)

# Config
num_records = 5000
departments = ['IT', 'Marketing', 'Sales', 'HR', 'Finance', 'Operations']
expense_types = ['Travel', 'Software License', 'Client Dinner', 'Office Supplies', 'Consulting']
vendors = ['AWS', 'Salesforce', 'Uber', 'Delta Airlines', 'Staples', 'McKinsey', 'Hotel Marriot', 'Unknown Vendor']

# Generate Synthetic Expense Data
start_date = datetime(2025, 1, 1)
dates = [start_date + timedelta(days=int(np.random.randint(0, 365))) for _ in range(num_records)]

data = {
    'ExpenseID': [f'EXP-{100000 + i}' for i in range(num_records)],
    'EmployeeID': [f'EMP-{np.random.randint(101, 150)}' for _ in range(num_records)],
    'Department': np.random.choice(departments, num_records, p=[0.2, 0.25, 0.25, 0.1, 0.1, 0.1]),
    'ExpenseType': np.random.choice(expense_types, num_records),
    'Vendor': np.random.choice(vendors, num_records),
    'Amount': np.random.exponential(scale=250, size=num_records).round(2) + 10,
    'ExpenseDate': [d.strftime('%Y-%m-%d') for d in dates],
    'ApprovalStatus': np.random.choice(['Approved', 'Pending', 'Rejected'], num_records, p=[0.85, 0.10, 0.05])
}

df = pd.DataFrame(data)

# Inject Anomalies (High-risk policy violations for auditing logic)
# 1. Duplicates
df = pd.concat([df, df.iloc[:25]], ignore_index=True)

# 2. Extreme Outliers (Policy Violation > $10,000)
df.loc[100, 'Amount'] = 15400.00
df.loc[250, 'Amount'] = 22000.00
df.loc[500, 'Amount'] = 18500.00

# Save to CSV
df.to_csv('financial_expenses_data.csv', index=False)
print("Data generated successfully: 'financial_expenses_data.csv' created with 5,025 rows!")