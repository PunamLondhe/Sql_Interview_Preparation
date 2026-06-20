-- ============================================
-- Topic: GROUP BY, HAVING, Aggregate Functions
-- ============================================

-- Q1: Find the total salary paid out per department
SELECT 
	Department, 
	SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;

-- Q2: Find the number of employees in each city
SELECT 
	City, 
	COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City;

-- Q3: Find the average salary in each department
SELECT 
	Department, 
	AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

-- Q4: Find departments where the total salary paid exceeds 130000
SELECT 
	Department, 
	SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 130000;

-- Q5: Find cities that have more than 2 employees
SELECT 
	City, 
	COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
HAVING COUNT(*) > 2;

-- Q6 (Medium): Average salary per department, only for employees who joined
-- after 2019, showing only departments where the average exceeds 48000
SELECT 
	Department, 
	AVG(Salary) AS AvgSalary
FROM Employees
WHERE JoinYear > 2019
GROUP BY Department
HAVING AVG(Salary) > 48000;

-- Q7 (Medium): Total salary per city, excluding the HR department,
-- showing only cities where the total exceeds 90000
SELECT 
	City, 
	SUM(Salary) AS TotalSalary
FROM Employees
WHERE Department <> 'HR'
GROUP BY City
HAVING SUM(Salary) > 90000;

-- Q8 (Medium): Departments with more than 2 employees,
-- considering only employees earning above 40000
SELECT 
	Department, 
	COUNT(*) AS NumEmployees
FROM Employees
WHERE Salary > 40000
GROUP BY Department
HAVING COUNT(*) > 2;

-- Q9 (Combined): Top 3 cities with the highest average salary,
-- considering only Sales/IT employees, only cities with more than 1 employee
SELECT TOP 3 
	City, 
	AVG(Salary) AS AvgSalary
FROM Employees
WHERE Department IN ('Sales', 'IT')
GROUP BY City
HAVING COUNT(*) > 1
ORDER BY AvgSalary DESC;
