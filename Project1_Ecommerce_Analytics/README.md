# 🛒 Project 1: E-Commerce Customer Churn, RFM & Loyalty Analytics

An end-to-end analytics project designed to analyze customer purchasing behavior, calculate RFM (Recency, Frequency, Monetary) scores, identify churn risks, and provide executive KPI reporting for an e-commerce platform.

---

## 📸 Dashboard Overview

![E-Commerce Customer Analytics Dashboard](dashboard_screenshot.png)

---

## 🎯 Business Problem & Objectives

* **Revenue & Sales Performance:** Track overall revenue ($6.35M), total orders (10K), and distinct active customers (1K).
* **Category Insights:** Identify top-performing product lines (Fashion & Home & Kitchen leading sales).
* **Geographic Distribution:** Analyze country-level revenue distribution (India leading total sales share).
* **Retention & Churn Analytics:** Segment customers based on purchase history using SQL-based RFM logic to detect high-value vs. churn-risk accounts.

---

## 🛠️ Tech Stack & Workflow

1. **Python (`data_generator.py`):** Generated synthetic transactional e-commerce dataset containing timestamps, customer IDs, product categories, and order totals.
2. **SQL (`rfm_churn_analysis.sql`):** Aggregated metrics using Window Functions, CTEs, and conditional scoring logic for RFM segmentation and churn flags.
3. **Power BI (`Customer_Loyalty_Analytics.pbix`):** Built dynamic DAX measures (`Total Orders`, `Total Customers`), interactive slicers, and visual KPI cards.

---

## 📊 Key Executive Metrics Summary

* **Total Revenue:** $6.35 Million
* **Total Customer Base:** 1,000 Unique Customers
* **Total Orders Processed:** 10,000 Transactions
* **Top Category:** Fashion ($1.9M+)
