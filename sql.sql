================= create 
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


==================  insert

INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employees (emp_id, emp_name, salary, dept_id) VALUES
(101, 'Alice Johnson', 5000.00, 1),
(102, 'Bob Smith', 4500.00, 1),
(103, 'Charlie Brown', 4000.00, 2),
(104, 'David White', 4800.00, 3),
(105, 'Eve Black', 5200.00, 1);
=========================== queries
a) Retrieve All Employees with Their Departments
SELECT e.emp_id, e.emp_name, e.salary, d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;
------
b) Find Employees in the 'IT' Department
SELECT emp_name, salary
FROM Employees
WHERE dept_id = (SELECT dept_id FROM Departments WHERE dept_name = 'IT');
-------
Get the Highest Paid Employee in Each Department
SELECT d.dept_name, e.emp_name, e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE (e.salary, e.dept_id) IN (
    SELECT MAX(salary), dept_id FROM Employees GROUP BY dept_id
);

d) Count Employees in Each Department
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

e) Increase Salary by 10% for Employees in IT
UPDATE Employees
SET salary = salary * 1.10
WHERE dept_id = (SELECT dept_id FROM Departments WHERE dept_name = 'IT');
f) Delete Employees with Salary Below 4000
DELETE FROM Employees
WHERE salary < 4000;
