/*CREATE TABLE employees (
  id INT  PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  gender VARCHAR(10) NOT NULL,
  salary INT NOT NULL,
  department VARCHAR(50) NOT NULL
);


INSERT INTO employees (id,name, gender, salary, department) VALUES
(1,'Ramesh Gupta', 'Male', 55000, 'Sales'),
(2,'Priya Sharma', 'Female', 65000, 'Marketing'),
(3,'Sanjay Singh', 'Male', 75000, 'Sales'),
(4,'Anjali Verma', 'Female', 45000, 'Finance'),
(5,'Rajesh Sharma', 'Male', 80000, 'Marketing'),
(6,'Smita Patel', 'Female', 60000, 'HR'),
(7,'Vikram Yadav', 'Male', 90000, 'Sales'),
(8,'Neha Sharma', 'Female', 55000, 'Marketing'),
(9,'Rahul Singh', 'Male', 70000, 'Finance'),
(10,'Sonali Gupta', 'Female', 50000, 'Sales');

*/

/*1. Write a query to find the average salary of male and female employees in each department.
*/

SELECT department, gender, AVG(salary) AS avg_salary
FROM employees
GROUP BY department, gender;

/*
2. Write a query to find the name and salary of the employee with the highest salary in each department.
Solution Query:*/

SELECT department, name, salary
FROM employees
WHERE (department, salary) IN (
  SELECT department, MAX(salary)
  FROM employees
  GROUP BY department
);

/*
3. Write a query to find the names of employees who earn more than the average salary in their department.
Solution Query:
*/


SELECT name, salary, department
FROM employees
WHERE salary > (
  SELECT AVG(salary)
  FROM employees AS e2
  WHERE e2.department = employees. Department
);


/*
4. Find the top 3 highest paid employees in each department.
Solution Query:
*/

SELECT e.department, e.name, e.salary
FROM employees e
WHERE (
  SELECT COUNT(*) 
  FROM employees 
  WHERE department = e.department AND salary > e.salary
) < 3;


/*5. Find the names of employees who have a salary greater than the average salary of their department.
Solution Query:
*/

SELECT e.name
FROM employees e
JOIN (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
) AS dept_avg ON e.department = dept_avg.department
WHERE e.salary > dept_avg.avg_salary;

/*
6. Find the department(s) with the highest paid employee(s).
*/

WITH max_salary AS (
  SELECT department, MAX(salary) AS highest_salary
  FROM employees
  GROUP BY department
)
SELECT m.department, e.name, e.salary
FROM employees e
JOIN max_salary m ON e.department = m.department AND e.salary = m.highest_salary;


