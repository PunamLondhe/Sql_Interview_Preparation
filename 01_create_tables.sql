-- ============================================
-- Topic: CREATE TABLE - Data types & constraints
-- ============================================

-- Creates the Employees table used across all practice files in this repo
CREATE TABLE Employees (
    EmpID       INT PRIMARY KEY,
    Name        VARCHAR(50) NOT NULL,
    Department  VARCHAR(30),
    City        VARCHAR(30),
    Salary      DECIMAL(10,2),
    JoinYear    INT
);
