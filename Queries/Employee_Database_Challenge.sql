-- Using the ERD you created in this module as a reference and your knowledge of SQL queries, create a Retirement Titles table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955. 
-- Because some employees may have multiple titles in the database—for example, due to promotions—you’ll need to use the DISTINCT ON statement to create a table that contains the most recent title of each employee. 
-- Then, use the COUNT() function to create a final table that has the number of retirement-age employees by most recent job title.--Joining Employees and Titles tables
SELECT employees.emp_no,
	   employees.birth_date,
	   employees.first_name,
	   employees.last_name,
	   titles.title,
	   titles.from_date,
       titles.to_date
INTO employees_titles	   
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- Retrieve the title, from_date, and to_date columns from the Titles table.
-- Create a new table using the INTO clause.
-- Join both tables on the primary key
-- Filter the data on the to_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
-- Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
Retrieve the title, from_date, and to_date columns from the Titles table.
Create a new table using the INTO clause.
Join both tables on the primary key.
Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
SELECT DISTINCT ON (employees.emp_no)
	   employees.emp_no,
	   employees.first_name,
	   employees.last_name,
	   titles.title,
	   titles.from_date,
       titles.to_date
INTO retirement_titles	   
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
ORDER BY employees.emp_no, titles.title DESC;


-- Retirement Titles count by Job Title
SELECT COUNT(rt.emp_no), t.title
INTO retirement_title_count
FROM retirement_titles as rt
LEFT JOIN titles as t
ON (rt.emp_no = t.emp_no)
GROUP BY t.title
ORDER BY t.title;


-- Create a Unique Titles table using the INTO clause.
-- Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e. to_date) of the most recent title.
SELECT retirement_titles.emp_no,
       retirement_titles.first_name, 
	   retirement_titles.last_name,
	   retirement_titles.title
INTO unique_titles
FROM retirement_titles
ORDER BY retirement_titles.emp_no ASC, retirement_titles.to_date DESC;

-- Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.

--Create a retiring titles table
SELECT COUNT(ut.title), t.title
--INTO retiring_titles
FROM unique_titles as ut
LEFT JOIN titles as t
ON (ut.emp_no = t.emp_no)
GROUP BY t.title
ORDER BY COUNT (t.title) DESC;


-- Deliverable 2: The Employees Eligible for the Mentorship Program

-- Using the ERD you created in this module as a reference and your knowledge of SQL queries, create a mentorship-eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.
-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
-- etc.
SELECT e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
ti.from_date,
ti.to_date,
ti.title
--INTO mentorship_eligibilty
FROM employees as e
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no;
