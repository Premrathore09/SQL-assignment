-- ques 1
select * from employees;
select * from departments;

-- ques 2
select concat(first_name,' ', last_name) as full_name, hire_date from employees;

-- ques 3
select concat(first_name, last_name,' ',job_id) as employee_title from employees;

-- ques 4
select concat(first_name,' ', last_name) as full_name, hire_date, department_id from employees where job_id like '%CLERK%';

-- ques 5
select concat(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) as THE_OUTPUT from employees;

-- ques 6
select concat(first_name,' ', last_name) as full_name, salary from employees where salary > 2000;

-- ques 7
select concat(first_name,' ', last_name) as Full_name, hire_date as Start_date from employees;

-- ques8
select concat(first_name,' ', last_name) as full_name, hire_date from employees order by hire_date;

-- ques 9
select concat(first_name,' ', last_name) as full_name, salary from employees order by salary desc;

-- ques 10
select concat(first_name,' ', last_name) as full_name, department_id, salary, commission_pct from employees where commission_pct is not null order by salary desc;

-- ques 11
select last_name, job_id from employees where manager_id is null;

-- ques 12
SELECT last_name, job_id, salary from employees where (job_id like '%sa_re%' ) or (job_id like '%st_CLERK%') and salary not in (2500, 3500, 5000);

-- page 2

-- ques 1
select employee_id, max(salary), min(salary), avg(salary), commission_pct from employees where commission_pct is not null group by employee_id;

-- ques 2
select department_id, sum(salary) as total_salary, sum(commission_pct) as total_comm from employees group by department_id;

-- ques 3
select department_id, count(employee_id) from employees group by department_id;

-- ques 4
select department_id, sum(salary) from employees group by department_id;

-- ques 5
select concat(first_name, ' ', last_name) as full_name, commission_pct from employees where commission_pct is null;

-- ques 6
SELECT 
    first_name,
    last_name,
    department_id,
    COALESCE(commission_pct, 'No commission') AS commission
FROM employees;

-- ques 7
select first_name, 
last_name, 
salary,
coalesce(commission_pct*2, 'No commission') as commission 
from employees;

-- ques 8
select e1.first_name, e1.department_id
from employees e1
join employees e2
				on e1.department_id = e2.department_id
where e1.employee_id <> e2.employee_id
and e1.first_name = e2.first_name;

-- ques 9
select manager_id, sum(salary) from employees group by manager_id;

-- ques 10
SELECT m.first_name, m.last_name, w.manager_id,
       count(*)
FROM employees w,
     employees m
WHERE w.manager_id = m.employee_id
GROUP BY w.manager_id; 

-- ques 11
SELECT 
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    e.first_name AS employee_name,
    e.department_id,
    e.salary
FROM 
    employees e
JOIN 
    employees m ON e.manager_id = m.employee_id
WHERE 
    e.last_name LIKE '_a%'
GROUP BY 
    manager_name, employee_name, e.department_id, e.salary;
    
-- ques 12
select department_id, avg(salary) as salary_sumavg from employees group by department_id order by department_id; 

-- ques 13 
select department_id, max(salary) as max_salary from employees group by department_id;

-- ques 14
select first_name,
       case
           when commission_pct is not null then salary*10/100
           else 1
end as Commission
from employees;
       
-- page 3 
-- ques 1Write a query that displays the employee's last names only from the string's 2-5th 
-- position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.

SELECT 
    CONCAT(
        UPPER(SUBSTRING(last_name, 2, 1)), 
        LOWER(SUBSTRING(last_name, 3, 5))
    ) AS formatted_last_name
FROM 
    employees;
    
-- ques 2 Write a query that displays the employee's first name and last name along with a " in 
-- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined

select concat(first_name,"-", last_name) as full_name, month(hire_date) as joined_month from employees;

-- ques 3

select last_name,
case salary
     when salary/2 > 10000 then salary + salary*10/100 + 1500
     else salary + salary*11.5/100 + 1500
end as new_salary
from employees; 

-- ques 4 Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, 
-- department id, salary and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$! 

select employee_id, concat(substring(employee_id,1,1),'00', replace(substring(employee_id,3,1), substring(employee_id,3,1),'E')) 
as E_id, department_id, salary, first_name from employees;

-- ques 5 Write a query that displays the employee's last names with the first letter capitalized and 
-- all other letters lowercase, and the length of the names, for all employees whose name 
-- starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names

SELECT 
    CONCAT(
        UPPER(SUBSTRING(last_name, 1, 1)), 
        LOWER(SUBSTRING(last_name, 2, 11))) as formatted_name
        from employees where first_name like 'J%' or first_name like 'A%'or first_name like 'M%' order by last_name;
        
-- ques 13 
select concat(first_name,' ', last_name) as full_name, salary from employees order by salary limit 1;

-- ques 14
select concat(first_name,' ', last_name) as full_name, salary from employees order by salary limit 200 offset 1;

-- ques 11
select first_name, last_name, job_id
from employees
where job_id =
(select job_id 
from employees
where first_name = 'Trenna');

-- ques 6 Create a query to display the last name and salary for all employees. Format the salary to 
-- be 15 characters long, left-padded with $. Label the column SALARY 

select last_name, lpad(salary, 15, '$') as salary
from employees;

-- ques 7  Display the employee's name if it is a palindrome

select first_name from employees  where first_name = reverse(first_name);

-- ques 8 . Display First names of all employees with initcaps. 

select concat(upper(substring(first_name, 1, 1)),
lower(substring(first_name, 2, 20))) as F_NAME from employees; -- no initcap function in this 

-- ques 9
select substring_index(substring_index(street_address, ' ', 2), ' ', -1) as sun_name from locations; 

-- ques 10 . Extract first letter from First Name column and append it with the Last Name. Also add 
 -- "@systechusa.com" at the end. Name the column as e-mail address. All characters should 
-- be in lower case. Display this along with their First Name. 

select first_name, concat(left(first_name, 1), last_name , '@systechusa') as email from employees;


-- page 4

-- ques 1 Write a query to display the last name, department number, department name for all employees. 
select e.last_name, e.department_id, d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

-- ques 2 Create a unique list of all jobs that are in department 4. Include the location of the department in the output. 
SELECT DISTINCT(j.job_title), l.street_address, l.postal_code, l.city, l.country_id, d.department_id
from jobs j
join employees e on j.job_id = e.job_id
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where d.department_id = 40;

-- ques 3  Write a query to display the employee last name,department name,location id and city of all employees who earn commission
select e.last_name, d.department_name, d.location_id, l.city
from employees e
join departments d on e.department_id = d.department_id
join locations l on l.location_id = d.location_id 
	where commission_pct is not null;
    
-- ques 4 Display the employee last name and department name of all employees who have an 'a' in their last name 
select e.last_name, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where last_name like '%a%';

-- ques 5 Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA. 
select e.last_name, e.job_id, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id 
join locations l on d.location_id = l.location_id
     where l.city = 'ATLANTA';
     
-- ques 6 . Display the employee last name and employee number along with their manager's last name and manager number.
select m.last_name as manager_name,
m.employee_id as employee_id,
e.last_name as employee_name,
e.manager_id as manager_id
from employees e
join employees m on e.manager_id = m.employee_id;

-- ques 7  Display the employee last name and employee number along with their manager's last 
-- name and manager number (including the employees who have no manager). 
SELECT 
    e.last_name AS employee_last_name,
    e.employee_id AS employee_number,
    m.last_name as manager_name,
    COALESCE(m.employee_id, 'No Manager') AS manager_number
FROM employees e
left JOIN employees m ON e.manager_id = m.employee_id;

-- ques 8 . Create a query that displays employees last name,department number,and all the 
-- employees who work in the same department as a given employee. 
select e.last_name, d.department_id
from employees e
join departments d on e.department_id = d.department_id; -- little problem

-- ques 9 Create a query that displays the name,job,department name,salary,grade for all 
-- employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)

select e.first_name, e.last_name, e.job_id, e.salary, d.department_name,
case 
	when salary >= 50000 then 'A'
    when salary >= 30000 then 'B'
else 'C'
end as salary_grade
from employees e
join departments d on e.department_id = d.department_id;

-- ques 10
select
e.last_name as employee_name,
e.manager_id as manager_id,
e.hire_date as emp_hire_date
from employees e
join employees m on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;


-- page 6

-- ques 1 . Write a query to display the last name and hire date of any employee in the same department as SALES. 
select last_name, hire_date, job_id
from employees
where department_id =
(select department_id
from departments
where department_name = 'Sales');

-- ques 2 Create a query to display the employee numbers and last names of all employees who 
 -- earn more than the average salary. Sort the results in ascending order of salary 
select last_name, employee_id
from employees
where salary >
(select avg(salary)
from employees)
order by salary;

-- ques 3 3. Write a query that displays the employee numbers and last names of all employees who 
-- work in a department with any employee whose last name contains a' u 
select last_name, employee_id from employees where last_name like '%u%';

-- ques 4  Display the last name, department number, and job ID of all employees whose department location is ATLANTA.
select last_name, job_id, department_id
from employees
where department_id =
(select department_id
from departments
where location_id =
(select location_id
from locations
where city = "ATLANTA"));

select e.last_name, e.job_id, e.department_id
from employees e
join departments d
on e.department_id = d.department_id
join locations l 
on d.location_id = l.location_id
where city = 'ATLANTA';

-- ques 5 Display the last name and salary of every employee who reports to FILLMORE
select last_name, salary
from employees
where manager_id =
(select employee_id
from employees
where last_name = 'FILLMORE');

-- ques 6 Display the department number, last name, and job ID for every employee in the OPERATIONS department. 
select last_name, job_id, department_id
from employees
where department_id =
(select department_id
from departments
where department_name = 'OPERATION');

-- ques 7 Modify the above query to display the employee numbers, last names, and salaries of all 
-- employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name. 
select last_name, employee_id, salary
from employees
where salary >
(select avg(salary)
from employees
where last_name like '%U%');

 -- ques 8 Display the names of all employees whose job title is the same as anyone in the sales dept.     

select e.first_name, j.job_title from employees e join jobs j on e.job_id = j.job_id where 
	e.department_id is null and j.job_title in (select jt.job_title from jobs jt join employees em on jt.job_id = em.job_id 
	where em.department_id = 80);

-- ques 9 Write a compound query to produce a list of employees showing raise percentages, 
-- employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, 
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are 
-- given a 15% raise, and employees in department 6 are not given a raise.
SELECT 
    employee_id,
    salary, department_id,
    CASE
        WHEN department_id IN (10, 30) THEN '5%'
        WHEN department_id = 20 THEN '10%'
        WHEN department_id IN (40, 50) THEN '15%'
        WHEN department_id = 60 THEN 'No raise'
    END AS raise_percentage
FROM employees;	

-- 10 ques . Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 
select last_name, salary from employees order by salary desc limit 3;

-- ques 11 Display the names of all employees with their salary and commission earned. Employees 
-- with a null commission should have O in the commission column

SELECT 
    first_name,
    salary,
    COALESCE(commission_pct, 'O') AS commission
FROM employees;

-- ques 12 Display the Managers (name) with top three salaries along with their salaries and department information

select concat(first_name,' ', last_name) as full_name, department_id, salary from employees where employee_id in
(select manager_id from employees) order by salary desc limit 3;











     






