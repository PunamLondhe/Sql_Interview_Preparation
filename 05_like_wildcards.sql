-- ============================================
-- Topic: LIKE - Wildcard Pattern Matching
-- Wildcards: % (zero or more characters), _ (exactly one character)
-- ============================================

-- Q1: Find all employees whose name starts with the letter A
SELECT *
FROM Employees
WHERE Name LIKE 'A%';

-- Q2: Find all employees whose name ends with the letter a
SELECT *
FROM Employees
WHERE Name LIKE '%a';

-- Q3: Find all employees whose name contains the letter i anywhere
SELECT *
FROM Employees
WHERE Name LIKE '%i%';

-- Q4: Find all employees whose city starts with "P"
SELECT *
FROM Employees
WHERE City LIKE 'P%';

-- Q5: Find all employees whose name has exactly 5 letters
SELECT *
FROM Employees
WHERE Name LIKE '_____';  -- 5 underscores = 5 characters exactly

-- Q6: Find all employees whose name has "a" as the second letter
SELECT *
FROM Employees
WHERE Name LIKE '_a%';

-- Q7: Find all employees who do NOT have a name starting with "A"
SELECT *
FROM Employees
WHERE Name NOT LIKE 'A%';

-- Q8: Find all employees whose department contains the letter "s" (any case)
SELECT *
FROM Employees
WHERE Department LIKE '%s%';
-- Note: MySQL/SQL Server are case-insensitive for LIKE by default.
-- In PostgreSQL (case-sensitive), use ILIKE instead.

-- Q9: Find all employees whose name starts with "K" or "V"
SELECT *
FROM Employees
WHERE Name LIKE 'K%' OR Name LIKE 'V%';

-- Q10: Find all employees whose city has "e" as the second-last character
SELECT *
FROM Employees
WHERE City LIKE '%e_';
