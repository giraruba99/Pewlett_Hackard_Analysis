--Deliverable 1: 


--The Number of Retiring Employees by Title
--we'll inner join employee and title table, we'll filter out 6 columns from both
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM retirement_titles;
--table is created sucessfully and expoted to DATA folder

-- Use Dictinct with Orderby to remove duplicate rows
-- to remove duplicates, we need to distict on emp_no, thus:

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title

INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no ASC, to_date DESC;
--table unique_titles created and exported to DATA folder

SELECT * FROM unique_titles;

--Now we are going to find out number of employees nearing retirement, group thme by departments
--since we already filtered our unique tutles per emp_no, we can count either emp_no or title...
--By emp_no
SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;

--By title
SELECT COUNT (ut.title), ut.title
--INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;


-----------------------------------------------------------------

--Deliverable 2:

 
--The Employees Eligible for the Mentorship Program
-- in this query, we are inner joining 3 tables: employees, titles and dep_emp

SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;