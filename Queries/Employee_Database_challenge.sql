-- Deliverable 1 - creating Retirement Titles table
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
ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Creating retiring_titles table
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC;

-- Deliverable 2 Creating Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') and (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Deliverable 3 New queries
--Creating a table with retiring employees by title and department
SELECT ut.emp_no,
ut.title,
di.dept_name
INTO ret_titles_dept
FROM unique_titles as ut
INNER JOIN dept_info as di
ON (ut.emp_no = di.emp_no);

-- Creating a table that contains the count of titles retiring by department
SELECT COUNT(title),
title,
dept_name
INTO ret_titlescount_dept
FROM ret_titles_dept
GROUP BY title, dept_name
ORDER BY count(title) DESC;

-- Deliverable 3 Creating NEW Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility_new
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1964-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

--- Getting the count of mentors by title from both the old and new mentorship  eligibility tables
SELECT COUNT(emp_no),title 
FROM mentorship_eligibility
GROUP BY title;

SELECT COUNT(emp_no),title 
FROM mentorship_eligibility_new
GROUP BY title;



