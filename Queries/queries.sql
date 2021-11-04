--just to begin, we are looking for employees nearing retirement by just looking their birth date
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';
--now we need to narrow down retirement eligibility by puting hiring date (1985-1988)
--retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--it is very big data and we need to know the number of rows, thus
--Number of employees retiring is:
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--we found 41,380 number of employees retiring in the age range
--now we can export the new table, first rerun the code
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--from this query, we can write SELECT INTO query
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--let's check what the new table looks like
SELECT * FROM retirement_info;


----------------------------------------------------------------
--since we need to receate the retirment_info table to include emp_no, lets first drop it
DROP TABLE retirement_info;
--lets creat retirment_info table that inludes emp_no
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--lets check if we created the correct table
SELECT * From retirement_info;
--lets join Departments & Manager table using inner join
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;
--some employees might already has left long time ago, thus we need to LEFT JOING retirement info 
--join retirement_info and dept_emp
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;
--for better readability and clearer query, lets use alias(short names for table names)
--example:
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
From retirement_info as ri
LEFT JOIN dept_emp as de
On ri.emp_no =de.emp_no;
--we can also do LEFT JOIN on retirement_info and dept_emp
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
From retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
-- let's check our new table
SELECT * From current_emp;
--using COUNT, GROUP BY, and ORDER
--lets join the new tbale (current_emp) with dep_emp, and use the new functions
--Employee count by deparment number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;
--to get an ascending or descening order, use ORDER BY function
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
--let's create a new table holding those filted data
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
--let's check our new table
SELECT * From dept_count;
--Now we are going to check: Employee retirement informations, Managment retirees and departments
--Employee information:
--let's check what the salary table got
SELECT * FROM salaries
ORDER BY to_date DESC;
--let's filter employees with date of birth and date of hire
--we are also joining 3 tables with inner join: employees, salaries and dep_emp
SELECT e.emp_no, 
	e.first_name, 
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--but we also nee to specify to_date to 9999-01-01
SELECT e.emp_no, 
	e.first_name, 
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
--lets check our new table
SELECT * FROM emp_info;
--Now we need to know who is retiring from managments... then the company can train new managers
--le'ts list managers per thier respective departments
SELECT dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no =d.dept_no)
	INNER JOIN current_emp As ce
		ON (dm.emp_no = ce.emp_no);
--now let's find out department retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_no
INTO dept_info
FROM current_emp As ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments As d
ON (de.dept_no = d.dept_no);
--the two queries above answered most of our questions but created two questions too:
--why are only 5 active managers in 9 departments
--why are some managers appearing twice
--lets create a tailored table then