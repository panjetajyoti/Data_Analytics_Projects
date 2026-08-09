import pandas as pd
import numpy as np
from datetime import datetime, timedelta

np.random.seed(42)

num_calls = 5000

channels = ['Phone', 'Chat', 'Email']
topics = ['Billing Issue', 'Technical Support', 'Account Access', 'Cancellation', 'Product Inquiry']
sentiments = ['Very Positive', 'Positive', 'Neutral', 'Negative', 'Very Negative']
centers = ['New York', 'Dallas', 'Chicago', 'Los Angeles']

start_date = datetime(2026, 1, 1)

data = []

for i in range(1, num_calls + 1):
    call_id = f"CALL-{10000 + i}"
    agent_id = f"AGT-{np.random.randint(101, 140)}"
    call_date = (start_date + timedelta(days=int(np.random.randint(0, 180)))).strftime('%Y-%m-%d')
    channel = np.random.choice(channels, p=[0.5, 0.3, 0.2])
    topic = np.random.choice(topics)
    call_center = np.random.choice(centers)
    
    # Performance metrics
    duration_min = round(float(np.random.exponential(scale=6.5)), 2) + 1.0
    csat_score = np.random.choice([1, 2, 3, 4, 5], p=[0.08, 0.12, 0.20, 0.35, 0.25])
    resolved = np.random.choice(['Yes', 'No'], p=[0.82, 0.18])
    sentiment = np.random.choice(sentiments, p=[0.2, 0.3, 0.25, 0.15, 0.10])
    
    data.append({
        'CallID': call_id,
        'AgentID': agent_id,
        'CallDate': call_date,
        'Channel': channel,
        'Topic': topic,
        'CallCenter': call_center,
        'DurationMinutes': duration_min,
        'CSATScore': csat_score,
        'IsResolved': resolved,
        'Sentiment': sentiment
    })

df = pd.DataFrame(data)

# Save to CSV
output_file = 'call_center_data.csv'
df.to_csv(output_file, index=False)

print(f"Data generated successfully: '{output_file}' created with {len(df)} rows!")