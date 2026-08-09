# 🏥 Project 3: Healthcare Supply Chain & Inventory Optimization System

An advanced inventory auditing and supply chain optimization project designed for hospital networks to monitor stockout risks, track expiring pharmaceutical batches, and automate reorder thresholds.

---

## 🎯 Key Objectives & Business Impact

* **Stockout Prevention:** Automated tracking of items below minimum threshold reorder levels.
* **Waste Reduction:** Early detection of expired and near-expiry medical inventory to reduce write-offs.
* **Capital Optimization:** Category-wise stock valuation analysis for efficient procurement planning.

---

## 🛠️ Tech Stack & Workflow

1. **Python (`generate_healthcare_data.py`):** Generated realistic healthcare inventory dataset (1,500 SKU records) with supply lead times and expiry dates.
2. **Excel (`healthcare_inventory_model.xlsx`):** Built structured inventory dataset with product categorization, stock levels, unit costs, and reorder alerts.
3. **SQL (`healthcare_supply_chain.sql`):** Created inventory optimization queries, stockout risk aggregation logic, and expired batch audit models.

---

## 📊 Key Summary Metrics

* **Total SKUs Audited:** 1,500 Items
* **Categories:** Pharmaceuticals, Surgical Equipment, PPE & Safety, Diagnostic Kits, Medical Consumables
* **Locations Monitored:** Central, North, South, and East Warehouses
* **Key Risk Flags:** Reorder Threshold Alerts, Stockout Exposure, Expired Batch Audits
