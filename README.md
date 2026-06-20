# SQL Practice & Interview Prep

This repository contains my SQL practice queries, organized by topic, as I prepare for interviews. Each file focuses on one concept and includes the question written as a comment directly above the query that answers it.

## Sample Schema

All queries in this repo run against a single `Employees` table.

| Column     | Type          | Description        |
|------------|---------------|---------------------|
| EmpID      | INT           | Primary key         |
| Name       | VARCHAR(50)   | Employee name       |
| Department | VARCHAR(30)   | Department name     |
| City       | VARCHAR(30)   | Employee's city     |
| Salary     | DECIMAL(10,2) | Monthly salary      |
| JoinYear   | INT           | Year of joining     |

Sample data:

| EmpID | Name   | Department | City   | Salary | JoinYear |
|-------|--------|------------|--------|--------|----------|
| 1     | Aarav  | Sales      | Pune   | 45000  | 2019     |
| 2     | Diya   | IT         | Mumbai | 65000  | 2020     |
| 3     | Kabir  | Sales      | Pune   | 50000  | 2021     |
| 4     | Meera  | HR         | Delhi  | 40000  | 2018     |
| 5     | Rohan  | IT         | Mumbai | 70000  | 2022     |
| 6     | Sara   | Sales      | Delhi  | 48000  | 2020     |
| 7     | Vikram | HR         | Pune   | 42000  | 2021     |
| 8     | Ishaan | IT         | Pune   | 60000  | 2019     |
| 9     | Anika  | Sales      | Mumbai | 55000  | 2023     |
| 10    | Dev    | HR         | Delhi  | 41000  | 2020     |

See `01_create_tables.sql` and `02_insert_data.sql` for the full setup script.

> **Note on dialect:** These queries use `TOP` (SQL Server / MS Access syntax) to limit rows. If you're running this on MySQL, PostgreSQL, or SQLite, replace `TOP n` with `LIMIT n` at the end of the query instead.

## Topics Covered

| File                       | Topic                                                   |
|-----------------------------|----------------------------------------------------------|
| `01_create_tables.sql`      | Table creation, data types, constraints                  |
| `02_insert_data.sql`        | Inserting sample data                                    |
| `03_select_where.sql`       | SELECT, FROM, WHERE, DISTINCT, ORDER BY, TOP             |
| `04_group_by_having.sql`    | GROUP BY, HAVING, aggregate functions (SUM, COUNT, AVG)  |
| `05_like_wildcards.sql`     | LIKE, wildcard pattern matching (%, _)                   |

## Sample Query

```sql
-- Find departments where total salary paid exceeds 130000
SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 130000;
```

## About

I'm building this repo while learning SQL for interview preparation. Each file is meant to demonstrate not just syntax, but how I break down a question into a working query. I'll keep committing new topics as I learn them.
