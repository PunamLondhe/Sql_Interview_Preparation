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

-- Departments table
CREATE TABLE Departments (
    DeptID    INT PRIMARY KEY,
    DeptName  VARCHAR(30) NOT NULL,
    Manager   VARCHAR(50),
    Location  VARCHAR(30)
);