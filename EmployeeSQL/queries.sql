CREATE TABLE departments(
dept_no VARCHAR(30)PRIMARY KEY NOT NULL,
dept_name VARCHAR(30)NOT NULL);

SELECT* FROM departments;

CREATE TABLE dept_employee(
emp_no INT,
dept_no VARCHAR(30)NOT NULL);

SELECT * FROM dept_employee;

CREATE TABLE dept_manager(
dept_no VARCHAR(30),
emp_no INT);

SELECT * FROM dept_manager;

CREATE TABLE employees(
emp_no INT PRIMARY KEY NOT NULL,
emp_title_id VARCHAR(30) NOT NULL,
birth_date DATE NOT NULL,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
sex VARCHAR(30) NOT NULL,
hire_date DATE NOT NULL);

SELECT * FROM employees;

CREATE TABLE salaries(
emp_no INT,
salary INT);

SELECT * FROM salaries;

CREATE TABLE titles(
title_id VARCHAR,
title VARCHAR);

SELECT * FROM titles;

--List the following details of each employee: employee number, last name, first name, sex, and salary.

ALTER TABLE salaries
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no); 

SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.sex,
	salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.

SELECT employees.first_name,
	employees.last_name,
	employees.hire_date
FROM employees
WHERE hire_date BETWEEN ('1986-01-01') AND ('1987-01-01');

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT departments.dept_no,
	departments.dept_name,
	dept_manager.emp_no,
	employees.last_name,
	employees.first_name
FROM departments
INNER JOIN dept_manager ON
departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT dept_employee.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM dept_employee
INNER JOIN employees ON
dept_employee.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_employee.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees;

SELECT employees.first_name,
employees.last_name,
employees.sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_employee ON
dept_employee.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_employee.dept_no
WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_employee ON
dept_employee.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_employee.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT employees.last_name,
COUNT(employees.last_name) AS "employees last name count"
FROM employees
GROUP BY employees.last_name
ORDER BY "employees last name count" DESC;
