-- ============================================
-- Topic: SELECT, FROM, WHERE, DISTINCT, ORDER BY, TOP
-- ============================================

-- Q1: Display the Name and Salary of all employees
SELECT Name, Salary
FROM Employees;

-- Q2: Find all employees who work in the IT department
SELECT *
FROM Employees
WHERE Department = 'IT';

-- Q3: Find employees in Sales whose salary is greater than 47000
SELECT *
FROM Employees
WHERE Department = 'Sales' AND Salary > 47000;

-- Q4: List all unique departments in the company
SELECT DISTINCT Department
FROM Employees;

-- Q5: List all unique combinations of Department and City
SELECT DISTINCT Department, City
FROM Employees;

-- Q6: Display all employees sorted by Salary in descending order
SELECT *
FROM Employees
ORDER BY Salary DESC;

-- Q7: Display all employees sorted by Department (A-Z), then Salary (highest first)
SELECT *
FROM Employees
ORDER BY Department ASC, Salary DESC;

-- Q8: Find the top 3 highest-paid employees
SELECT TOP 3 *
FROM Employees
ORDER BY Salary DESC;

-- Q9: Find the 2 most recently joined employees
SELECT TOP 2 *
FROM Employees
ORDER BY JoinYear DESC;
