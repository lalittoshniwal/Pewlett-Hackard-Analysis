-- Total list of retiring employees and their employment history
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as ti on e.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY
emp_no asc;

-- List of employees retiring and their current title only
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- Count of retiring employess by title
SELECT
title,
COUNT(*)
INTO retiring_titles
FROM
unique_titles
GROUP BY title
ORDER BY
count DESC;

-- Determine mentorship eligibility
SELECT DISTINCT ON (emp_no) 
	e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN titles ti ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-1-1') AND (e.birth_date BETWEEN '1965-1-1' AND '1965-12-31')
ORDER BY emp_no ASC;

-- Total number of retiring employees
SELECT
SUM(COUNT)
FROM
retiring_titles;

-- Count of mentorship eligible employees
SELECT
COUNT(*)
FROM
mentorship_eligibility;

