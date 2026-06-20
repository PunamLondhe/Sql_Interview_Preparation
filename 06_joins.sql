-- ============================================
-- Topic: JOINS
-- ============================================
--Note:
--1. Recombine the data (INNER, LEFT, FULL)
--2. Data Enrichment - Getting extra data (LEFT)
--3. Check existance (INNER, LEFT+WHERE, FULL+WHERE)

-- 1. INNER JOIN
--Returning only matching data
--Order of tables doesnt matters

-- 2. LEFT JOIN
--Return all the data from left table and only matching data from right table
--Order of tables is important

-- 3. RIGHT JOIN
--Returns all the data from right table and only matching data from left table
--Order of tables is important

-- 4. FULL JOIN
--Returns all rows from botha tables

-- 5. SELF JOIN
--A self join is when you join a table to itself.

-- Q1: Display the employee name along with their department name
SELECT 
    E.Name, 
    D.DeptName
FROM Employees E
INNER JOIN Departments D 
ON E.DeptID = D.DeptID;

-- Q2: Display the names of employees who work in the "IT" department
SELECT 
    E.Name
FROM Employees E
INNER JOIN Departments D 
ON E.DeptID = D.DeptID
WHERE D.DeptName = 'IT';

-- Q3: Display employee name, salary, and their department's manager name
SELECT 
    E.Name, 
    E.Salary, 
    D.Manager
FROM Employees E
INNER JOIN Departments D 
ON E.DeptID = D.DeptID;

-- Q4: Display all departments and the employees in them,
-- including departments that have no employees
SELECT 
    D.DeptName, 
    E.Name
FROM Departments D
LEFT JOIN Employees E 
ON D.DeptID = E.DeptID;

-- Q5: Find department(s) that currently have no employees assigned
SELECT 
    D.DeptName
FROM Departments D
LEFT JOIN Employees E 
ON D.DeptID = E.DeptID
WHERE E.EmpID IS NULL;

-- Q6: Display all employees along with their department info,
-- using RIGHT JOIN logic (Departments on the right side stays complete)
SELECT 
    E.Name, 
    D.DeptName
FROM Departments D
RIGHT JOIN Employees E 
ON D.DeptID = E.DeptID;
-- Note: MySQL/SQL Server/PostgreSQL support RIGHT JOIN.
-- The same result can be written as a LEFT JOIN by swapping table order:
-- SELECT E.Name, D.DeptName FROM Employees E LEFT JOIN Departments D ON E.DeptID = D.DeptID;

-- Q7: Find the total salary paid per department, showing department NAME
SELECT 
    D.DeptName, 
    SUM(E.Salary) AS TotalSalary
FROM Employees E
INNER JOIN Departments D 
ON E.DeptID = D.DeptID
GROUP BY D.DeptName;

-- Q8: Find department names where the average salary is greater than 48000
SELECT 
    D.DeptName, 
    AVG(E.Salary) AS AvgSalary
FROM Employees E
INNER JOIN Departments D 
ON E.DeptID = D.DeptID
GROUP BY D.DeptName
HAVING AVG(E.Salary) > 48000;

-- Q9: Display employee name, department name, and salary - sorted by salary descending
SELECT 
    E.Name, 
    D.DeptName, 
    E.Salary
FROM Employees E
INNER JOIN Departments D 
ON E.DeptID = D.DeptID
ORDER BY E.Salary DESC;

-- Q10: Find pairs of employees who work in the same department
-- (self join - avoid pairing an employee with themselves or showing duplicate pairs)
SELECT 
    E1.Name AS Employee1, 
    E2.Name AS Employee2, 
    E1.DeptID
FROM Employees E1
INNER JOIN Employees E2
ON E1.DeptID = E2.DeptID AND E1.EmpID < E2.EmpID
ORDER BY E1.DeptID;

