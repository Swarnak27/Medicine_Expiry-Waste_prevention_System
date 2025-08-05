# Medicine Waste & Expiry Tracker for Pharmacies

This project helps local pharmacies track medicine batches, manage stocks across multiple branches, and identify medicine wastage due to expiry. It is built using **MySQL** and includes realistic sample data and queries for analysis and reporting.

## Problem Statement

Pharmacies often accumulate expired or unused medicine batches due to poor tracking systems. This leads to financial losses and environmental hazards. This SQL-based system aims to:

- Identify upcoming or past expiry medicines.
- Track available vs. wasted quantities.
- Optimize stock distribution across branches.
- Reduce wastage and improve operational efficiency.

---

## Database Schema

The system uses the following tables:

1. **Medicines** - Stores details about medicines.
2. **Batches** - Tracks batch-level info including expiry and received dates.
3. **Branches** - Represents pharmacy branches.
4. **Stock** - Tracks medicine quantity per batch per branch.
5. **Waste_Log** - Stores records of wasted medicines with reasons.

---

## 🛠Technologies Used

- **Database**: MySQL
- **Tool**: MySQL Workbench
- **Language**: SQL

---

## Key SQL Concepts Used

- Joins (INNER JOIN)
- Subqueries (Scalar & Correlated)
- Group By, Having
- Special operators (`LIKE`, `BETWEEN`, `IN`)
- Aggregate functions (`SUM`, `AVG`)
- Set Operators (`UNION`)
- Sorting, Filtering, and Limiting Results

---

## Sample Queries

- Medicines with batches expiring before the average expiry date.
- Branch-wise stock availability.
- Total quantity wasted vs. available.
- Union of medicine names in stock and waste logs.
- Identify medicine wastage by reason and batch.

---

## Project Files

- `create_tables.sql` – Contains schema and table creation queries.
- `insert_data.sql` – Sample data insertions for testing.
- `queries.sql` – Real-world use case queries for analysis.
- `README.md` – Project overview and documentation.



