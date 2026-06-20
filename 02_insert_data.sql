-- ============================================
-- Topic: INSERT INTO - Populating sample data
-- ============================================

-- Inserts 10 sample rows into the Employees table
INSERT INTO Employees (EmpID, Name, DeptID, City, Salary, JoinYear)
VALUES
    (1,  'Aarav',  101, 'Pune',   45000, 2019),
    (2,  'Diya',   102, 'Mumbai', 65000, 2020),
    (3,  'Kabir',  101, 'Pune',   50000, 2021),
    (4,  'Meera',  103, 'Delhi',  40000, 2018),
    (5,  'Rohan',  102, 'Mumbai', 70000, 2022),
    (6,  'Sara',   101, 'Delhi',  48000, 2020),
    (7,  'Vikram', 103, 'Pune',   42000, 2021),
    (8,  'Ishaan', 102, 'Pune',   60000, 2019),
    (9,  'Anika',  101, 'Mumbai', 55000, 2023),
    (10, 'Dev',    103, 'Delhi',  41000, 2020);

SELECT * FROM Employees;

INSERT INTO Departments (DeptID, DeptName, Manager, Location)
VALUES
    (101, 'Sales',   'Rohit Sharma', 'Pune'),
    (102, 'IT',       'Anjali Mehta', 'Mumbai'),
    (103, 'HR',       'Suresh Kumar', 'Delhi'),
    (104, 'Finance',  'Priya Singh',  'Bangalore');

SELECT * FROM Departments;