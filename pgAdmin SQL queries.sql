-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/tpw1Xz
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


-- SELECT * 
-- FROM titles


-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON salaries.emp_no=employees.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '01/01/1986' AND hire_date < '01/01/1987'


-- List the manager of each department along with their department number, department name, employee number, 
-- last name, and first name.
SELECT dept_manager.dept_no,departments.dept_name,dept_manager.emp_no,employees.last_name,employees.first_name
FROM dept_manager
INNER JOIN departments ON departments.dept_no=dept_manager.dept_no
INNER JOIN employees ON employees.emp_no=dept_manager.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name,
-- first name, and department name.
SELECT dept_emp.dept_no,employees.emp_no,employees.last_name,employees.first_name, departments.dept_name
FROM departments
INNER JOIN dept_emp ON dept_emp.dept_no=departments.dept_no
INNER JOIN employees ON employees.emp_no=dept_emp.emp_no;


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins 
-- with the letter B.
SELECT employees.first_name,employees.last_name,employees.sex
FROM employees
WHERE 
	first_name ='Hercules' AND last_name LIKE 'B%'

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM employees
LEFT JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
LEFT JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE dept_name ='Sales'

SELECT * 
FROM departments

-- List each employee in the Sales and Development departments, including their employee number, last name, 
-- first name, and department name.
SELECT employees.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM employees
LEFT JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
LEFT JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE dept_name ='Sales' OR dept_name ='Development'


-- *** List the frequency counts, in descending order, of all the employee last names (that is, how many employees share 
-- each last name).
SELECT last_name, COUNT (*) AS lastname_count
FROM employees
GROUP BY last_name
ORDER BY lastname_count DESC;
