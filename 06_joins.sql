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

-- 6. LEFT ANTI JOIN
--Returns the row from left that has NO MATCH in right

-- 7. RIGHT ANTI JOIN
--Returns the row from right that has NO Match in Left

-- 8. FULL ANTI JOIN
--Retruns only rows that dont match in either tables

-- 9. CROSS JOIN - Cartersion Join
--Combine every row from left with every row from right

--*********************************************************************

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

--------------------------MIXED--------------------------------------
--1.List all employees along with their department names.
SELECT
    E.Name,
    D.DeptName
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID

--2.Show all departments and the employees in each (include departments with no employees).
SELECT
    D.DeptName,
    E.Name
FROM Departments D
LEFT JOIN Employees E
ON E.DeptID = D.DeptID
ORDER BY D.DeptName ASC

--3.Show all employees and their department names, including employees not assigned to any department.
SELECT
    E.Name,
    D.DeptName
FROM Employees E
LEFT JOIN Departments D
ON E.DeptID = D.DeptID

--4.List every possible combination of employee and department (cross join) — just to see what it produces.
SELECT
    *
FROM Employees
CROSS JOIN Departments

--5.Find employees who do not belong to any department.
SELECT
    *
FROM Employees E
LEFT JOIN Departments D
ON E.DeptID = D.DeptID
WHERE D.DeptID IS NULL

--6.Find departments that have no employees.
SELECT 
    *
FROM Departments D
LEFT JOIN Employees E
ON D.DeptID = E.DeptID
WHERE E.DeptID IS NULL

--7.List each employee along with their manager's name (self join on manager_id).
SELECT 
    E.Name,
    D.DeptName
FROM Employees E
LEFT JOIN Departments D
ON E.DeptID = D.DeptID

--8.Find the number of employees in each department, including departments with zero employees.
SELECT 
    D.DeptID,
    COUNT(E.EmpID) AS [TotalEmp]
FROM Departments D
LEFT JOIN Employees E
ON E.DeptID = D.DeptID
GROUP BY D.DeptID

--9.List employees who earn more than the average salary of their own department.
SELECT
    Name,
    Salary,
    DeptID
FROM (
    SELECT
        E.Name,
        E.Salary,
        E.DeptID,
        AVG(E.Salary) OVER (PARTITION BY E.DeptID) AS [AvgSalary]
    FROM Employees E
    )t
WHERE Salary > AvgSalary

--10.Find pairs of employees who work in the same department (avoid showing the same pair twice, e.g., (A,B) and (B,A)).
SELECT
   E1.Name AS Employee1,
   E2.Name AS Employee2,
   E1.DeptID
FROM Employees E1
INNER JOIN Employees E2
ON E1.DeptID = E2.DeptID AND E1.EmpID < E2.EmpID

--11.List departments where the average salary is higher than the company-wide average salary.
SELECT
    DeptID,
    AvgSalaryPerDept,
    AvgSalaryByCompany
FROM (
    SELECT
        DeptID,
        AVG(Salary) OVER (PARTITION BY E.DeptID) AS [AvgSalaryPerDept],
        AVG(Salary) OVER () AS [AvgSalaryByCompany]
    FROM Employees E
    )t
WHERE AvgSalaryPerDept > AvgSalaryByCompany

--12.Find employees who earn more than their manager.
SELECT
    E.EmpID,
    E.Name AS Employee,
    E.Salary AS EmpSalary,
    M.ManagerID,
    M.Name AS Manager,
    M.Salary AS ManagerSalary
FROM Employees E
INNER JOIN Employees M
ON E.ManagerID = M.EmpID
WHERE E.Salary > M.Salary

--13.List all employees, their department name, and their manager's name in a single query (two joins: one regular, one self join).
SELECT
    E.Name,
    D.DeptName,
    M.Name AS Manager
FROM Employees E
LEFT JOIN Employees M
ON E.EmpID = M.ManagerID
LEFT JOIN Departments D
ON E.DeptID = D.DeptID

--14.Find department(s) with the highest number of employees.
SELECT
    E.DeptId,
    COUNT(E.EmpID) AS [HighestNoOfEmployees]
FROM Departments D
LEFT JOIN Employees E
ON D.DeptID = E.DeptID
GROUP BY E.DeptID
ORDER BY [HighestNoOfEmployees] DESC


--********************************************************************************
--1.LEFT ANTI JOIN
--Find employees who are not assigned to any department.
SELECT
    *
FROM Employees E
LEFT JOIN Departments D
ON E.DeptID = D.DeptID
WHERE D.DeptID IS NULL

--Find employees whose DeptID does not exist in the Departments table at all (i.e., a broken/invalid reference).
SELECT
    *
FROM Employees E
LEFT JOIN Departments D
ON E.DeptID = D.DeptID
WHERE D.DeptID IS NULL
AND E.DeptID IS NOT NULL

--2. RIGHT ANTI JOIN
--Find departments that currently have zero employees.
SELECT
    D.*,
    E.*
FROM Employees E
RIGHT JOIN Departments D
ON E.DeptID = D.DeptID
WHERE E.DeptID IS NULL

--Find departments that have never had any employee join in the year 2020 or later.
SELECT
    D.DeptID,
    D.DeptName
FROM Departments D
LEFT JOIN Employees E
ON D.DeptID = E.DeptID
GROUP BY D.DeptID, D.DeptName
HAVING MAX(E.JoinYear) < 2020 OR MAX(E.JoinYear) IS NULL

--3. FULL ANI JOIN
--Find all "unmatched" records between Employees and Departments — either employees with no valid department, 
--or departments with no employees — in a single result set.
SELECT
    E.*,
    D.*
FROM Employees E
FULL JOIN Departments D
ON E.DeptID = D.DeptID
WHERE E.DeptID IS NULL OR D.DeptID IS NULL

--Find employee DeptIDs and department DeptIDs that don't have a corresponding match on the other side, 
--showing which side each unmatched ID came from.
SELECT
    E.DeptID,
    D.DeptID,
        CASE
            WHEN D.DeptID IS NULL THEN 'Employee'
            WHEN E.DeptID IS NULL THEN 'Department'
        END AS Source
FROM Employees E
FULL JOIN Departments D
ON E.DeptID = D.DeptID
WHERE E.DeptID IS NULL OR D.DeptID IS NULL

--4. CROSS JOIN
--Generate every possible employee-department combination, to see how many total pairings exist 
--(this becomes useful when, say, assigning every employee a "training session" per department).
SELECT
    E.*,
    D.*
FROM Employees E
CROSS JOIN Departments D

--List all combinations of cities and departments — even ones that don't currently exist together — to plan possible future office openings.
SELECT
    E.City,
    D.DeptName
FROM Employees E
CROSS JOIN Departments D

--5.SELF JOIN
--List each employee alongside any other employee who reports to the same manager (peers).
SELECT
    E.Name AS Employee1,
    M.Name AS Employee2,
    M.ManagerID
FROM Employees E
INNER JOIN Employees M
ON E.ManagerID = M.ManagerID
AND E.EmpID < M.EmpID

--Find pairs of employees who joined in the same JoinYear.
SELECT
    E1.Name As Employee1,
    E2.Name AS Employee2,
    E1.JoinYear
FROM Employees E1
INNER JOIN Employees E2
ON E1.JoinYear = E2.JoinYear
AND E1.EmpID < E2.EmpID

--List each manager along with the count of employees reporting directly to them.
SELECT
    M.EmpID,
    M.Name AS Manager,
    COUNT(E.EmpID) AS NoOfEmp
FROM Employees E
INNER JOIN Employees M
ON E.ManagerID = M.EmpID
GROUP BY M.EmpID, M.Name

--Find employees who earn the same salary as another employee in the company (excluding comparing themselves to themselves).
SELECT
    E1.Name AS Employee1,
    E2.Name AS Employee2
FROM Employees E1
INNER JOIN Employees E2
ON E1.Salary = E2.Salary
AND E1.EmpID < E2.EmpID