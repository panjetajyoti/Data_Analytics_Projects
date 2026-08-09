import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Seed for reproducibility
np.random.seed(42)

num_items = 1500

categories = ['Pharmaceuticals', 'Surgical Equipment', 'PPE & Safety', 'Diagnostic Kits', 'Medical Consumables']
locations = ['Warehouse A - Central', 'Warehouse B - North', 'Warehouse C - South', 'Warehouse D - East']
suppliers = ['MedTech Supplies', 'PharmaCare Global', 'Apex Diagnostics', 'BioHealth Corp', 'Global Surgical Ltd']

data = []

start_date = datetime(2026, 1, 1)

for i in range(1, num_items + 1):
    item_id = f"MED-{1000 + i}"
    category = np.random.choice(categories, p=[0.35, 0.20, 0.15, 0.15, 0.15])
    item_name = f"{category} Item #{i}"
    location = np.random.choice(locations)
    supplier = np.random.choice(suppliers)
    
    current_stock = np.random.randint(10, 1000)
    reorder_level = np.random.randint(100, 300)
    unit_cost = round(float(np.random.uniform(5.0, 450.0)), 2)
    lead_time_days = np.random.randint(3, 30)
    monthly_demand = np.random.randint(50, 800)
    
    # Expiry Date generation
    days_to_expire = np.random.randint(-30, 365) # negative means expired
    expiry_date = (start_date + timedelta(days=days_to_expire)).strftime('%Y-%m-%d')
    
    # Stock Status logic
    if current_stock == 0:
        stock_status = 'Out of Stock'
    elif current_stock <= reorder_level:
        stock_status = 'Reorder Needed'
    else:
        stock_status = 'Sufficient'
        
    data.append({
        'ItemID': item_id,
        'ItemName': item_name,
        'Category': category,
        'Location': location,
        'Supplier': supplier,
        'CurrentStock': current_stock,
        'ReorderLevel': reorder_level,
        'UnitCost': unit_cost,
        'TotalStockValue': round(current_stock * unit_cost, 2),
        'MonthlyDemand': monthly_demand,
        'LeadTimeDays': lead_time_days,
        'ExpiryDate': expiry_date,
        'StockStatus': stock_status
    })

df = pd.DataFrame(data)

# Save to CSV directly
output_filename = 'healthcare_inventory_model.csv'
df.to_csv(output_filename, index=False)

print(f"Success! Generated '{output_filename}' with {len(df)} records.")