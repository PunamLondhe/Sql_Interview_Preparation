DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    DeptID    INT PRIMARY KEY,
    DeptName  VARCHAR(50) NOT NULL,
    Location  VARCHAR(30)
);

INSERT INTO Departments (DeptID, DeptName, Location) VALUES
(10, 'Sales',       'Mumbai'),
(20, 'Marketing',   'Pune'),
(30, 'IT',          'Bangalore'),
(40, 'HR',          'Mumbai'),
(50, 'Finance',     'Delhi'),
(60, 'Operations',  'Chennai');

CREATE TABLE Employees (
    EmpID     INT PRIMARY KEY,
    Name      VARCHAR(50) NOT NULL,
    DeptID    INT,
    City      VARCHAR(30),
    Salary    DECIMAL(10,2),
    JoinYear  INT,
    ManagerID INT
);

INSERT INTO Employees (EmpID, Name, DeptID, City, Salary, JoinYear, ManagerID) VALUES
(1,  'Asha',    10, 'Mumbai',    90000, 2015, NULL),
(2,  'Bob',     10, 'Mumbai',    40000, 2019, 1),
(3,  'Carol',   10, 'Pune',      40000, 2021, 1),
(4,  'Dinesh',  20, 'Pune',      55000, 2018, 1),
(5,  'Esha',    20, 'Bangalore', 60000, 2022, 4),
(6,  'Farah',   30, 'Bangalore', 70000, 2017, 1),
(7,  'Gopal',   30, 'Chennai',   45000, 2020, 6),
(8,  'Hina',    30, 'Bangalore', 45000, 2023, 6),
(9,  'Imran',   40, 'Mumbai',    50000, 2016, 1),
(10, 'Jaya',    40, 'Delhi',     38000, 2021, 9),
(11, 'Kabir',   NULL, 'Pune',    42000, 2019, NULL),
(12, 'Leena',   99, 'Mumbai',    47000, 2020, 1);


--UNION / UNION ALL
--List all distinct cities where either an employee lives or a department is located 
--(assuming Departments also has a Location column with city names).
SELECT
    City AS EmpCity
FROM Employees
UNION 
SELECT
    Location
FROM Departments

--Combine a list of employee names from Department 10 and Department 20 into a single list, 
--removing duplicates if any employee somehow appears in both.
SELECT
    E.Name
FROM Employees E
WHERE E.DeptID = 10
UNION
SELECT
    E.Name
FROM Employees E
WHERE E.DeptID = 20

--Show the difference between UNION and UNION ALL using a query where you'd expect duplicate rows — write both versions and compare the row counts.
--UNION ALL
SELECT
    City AS EmpCity
FROM Employees
UNION ALL
SELECT
    Location
FROM Departments

--UNION
SELECT
    City AS EmpCity
FROM Employees
UNION 
SELECT
    Location
FROM Departments

--INTERSECT
--Find employees who exist in both a list of "high earners" (salary > 50000) 
--and a list of "senior employees" (joined before 2020) — i.e., people who satisfy both conditions, using INTERSECT instead of AND.
SELECT
    Name,
    Salary,
    JoinYear
FROM Employees
WHERE Salary > 50000
INTERSECT
SELECT
    Name,
    Salary,
    JoinYear
FROM Employees
WHERE JoinYear < 2020

--Find cities that have both an employee living there and a department located there.
SELECT
    City
FROM Employees E
INTERSECT
SELECT
    Location
FROM Departments D

--EXCEPT / MINUS
--Find employees who joined before 2020 but do not earn more than 50000
--(i.e., subtract the high-earners list from the senior-employees list).
--Method 1
SELECT
    *
FROM Employees
WHERE JoinYear < 2020
AND Salary <= 50000

--Method 2
SELECT
    Name,
    JoinYear,
    Salary
FROM Employees
WHERE JoinYear < 2020
EXCEPT
SELECT
    Name,
    JoinYear,
    Salary
FROM Employees
WHERE Salary > 50000

--Find departments that exist in the Departments table but have no corresponding employees — 
--solve this using EXCEPT instead of the anti-join pattern you used earlier 
--(compare the result to your earlier LEFT JOIN ... IS NULL answer — they should match).
--Method 1
SELECT
       D.*,
       E.*
FROM Departments D
LEFT JOIN Employees E
ON E.DeptID = D.DeptID
WHERE E.DeptID IS NULL

--Method 2
SELECT
    DeptID
FROM Departments
EXCEPT
SELECT
    DeptID
FROM Employees

--Mixed / conceptual
--Explain (in your own words, no query needed) why UNION automatically removes duplicate rows but UNION ALL does not, 
--and which one is generally faster to run.
--ANSWER: 
--UNION combines two result sets and removes duplicate rows, because it follows set theory, where a set has no repeated elements. 
--To do this, the database has to sort or hash the combined rows and check for matches, which adds overhead.
--UNION ALL simply appends both result sets together without checking for duplicates, so it skips that extra processing — making it faster.
--As a best practice, I use UNION ALL by default and only use UNION when I specifically need duplicates removed.

--Write a query using EXCEPT to find employees with ManagerID values that don't correspond to any real EmpID in the table 
--(a broken self-reference) — compare this to how you solved a similar "broken reference" problem earlier using a LEFT JOIN.
--Method 1
SELECT
    ManagerID
FROM Employees
EXCEPT
SELECT
    EmpID
FROM Employees

--Method 2
SELECT 
    *
FROM Employees E
LEFT JOIN Employees M
ON E.ManagerID = M.EmpID
WHERE M.EmpID IS NULL
AND E.ManagerID IS NOT NULL

--Combine UNION, INTERSECT, and EXCEPT thinking: if Set A = employees earning above company average, and Set B = employees who joined before 2021, write three separate queries — one for "in A or B," one for "in both A and B," and one for "in A but not B."
SELECT
    Name,
    Salary,
    JoinYear
FROM Employees
WHERE Salary > (SELECT
        AVG(Salary) AS [CompanyAvg]
    FROM Employees)
--UNION
--INTERSECT
EXCEPT
SELECT
    Name,
    Salary,
    Joinyear
FROM Employees
WHERE JoinYear < 2021
