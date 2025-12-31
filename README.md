# Discount-Illusion
Discount Illusion Analysis
When Revenue Growth Lies

📌 Project Overview
This project analyzes how aggressive discounting can create a false perception of business growth. While sales may appear strong, excessive discounts often erode profit margins, leading to misleading performance indicators.
The goal of this project is to identify products, categories, and regions where high revenue is driven primarily by discounts rather than healthy profitability.

🎯 Business Problem
Many organizations rely heavily on revenue as a success metric. However:
High sales do not always imply high profitability
Discounts can inflate revenue while silently damaging margins

This project answers:
Are we truly growing, or are discounts hiding poor performance?
At what discount levels does profitability start to collapse?
Which products and regions represent discount-driven revenue illusion?

🛠️ Tools & Technologies
SQL – Core analysis and metric computation
Python (Pandas, Matplotlib, Seaborn) – Exploratory Data Analysis & validation
Tableau – Interactive dashboards and business storytelling

📂 Dataset
Retail Superstore Dataset
Key fields used:
Sales
Profit
Discount
Category / Sub-Category
Region

🔍 Project Workflow

1.SQL Analysis
Calculated key business metrics:
Total Sales
Total Profit
Profit Margin
Average Discount
Created discount buckets to identify profit breakpoints

Identified:
High-sales but low/negative profit products
Categories dependent on discounting
Regions with misleading revenue performance

2.Python Validation
Recreated discount buckets in Python for consistency
Validated SQL findings using:
Summary tables
Scatter plots (Discount vs Profit)
Box plots (Profit by Discount Bucket)
Confirmed that higher discounts increase profit volatility and losses

3.Tableau Dashboards
Built two dashboards for executive decision-making:

1️⃣ Discount Illusion – Revenue vs Reality
Sales vs Profit scatter
Profit Margin by Discount Bucket
Key KPI cards

2️⃣ Discount Risk & Profit Leakage
High-sales, loss-making products
Category × Region profit heatmap

📈 Key Insights
Revenue remains strong at higher discount levels, but profit margins deteriorate sharply
Medium to high discounts introduce significant profit volatility
Certain products and regions appear successful in sales but consistently underperform in profitability
Discount-driven growth can mislead strategic decision-making

🧠 Final Conclusion
Revenue alone is an incomplete performance metric. This analysis demonstrates that aggressive discounting can inflate sales figures while masking underlying profit erosion, creating a discount illusion. Sustainable growth requires balancing sales incentives with profitability discipline.
