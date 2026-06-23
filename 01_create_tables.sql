-- ============================================
-- Topic: CREATE TABLE - Data types & constraints
-- ============================================

-- Creates the Employees table used across all practice files in this repo
DROP TABLE Employees;

CREATE TABLE Employees (
    EmpID    INT PRIMARY KEY,
    Name     VARCHAR(50) NOT NULL,
    DeptID   INT,
    City     VARCHAR(30),
    Salary   DECIMAL(10,2),
    JoinYear INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

ALTER TABLE Employees
ADD ManagerID INT NULL;

ALTER TABLE Employees
ADD FOREIGN KEY (ManagerID) REFERENCES Employees(EmpID);

UPDATE Employees SET ManagerID = 1 WHERE EmpID = 2;
UPDATE Employees SET ManagerID = 1 WHERE EmpID = 3;
UPDATE Employees SET ManagerID = 2 WHERE EmpID = 4;
UPDATE Employees SET ManagerID = 2 WHERE EmpID = 5;
UPDATE Employees SET ManagerID = 2 WHERE EmpID = 6;
UPDATE Employees SET ManagerID = 3 WHERE EmpID = 7;
UPDATE Employees SET ManagerID = 4 WHERE EmpID = 8;
UPDATE Employees SET ManagerID = 5 WHERE EmpID = 9;
UPDATE Employees SET ManagerID = 5 WHERE EmpID = 10;


-- Departments table
CREATE TABLE Departments (
    DeptID    INT PRIMARY KEY,
    DeptName  VARCHAR(30) NOT NULL,
    Manager   VARCHAR(50),
    Location  VARCHAR(30)
);