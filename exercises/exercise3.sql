--Sada 3

--Task 3.2
--Display names and salaries of employees.

select first_name, last_name, salary
from hr.employees

--OK 


--Task 3.3
--Display the last name and salary of employees earning more than $12,000

select last_name, salary
from hr.employees
where salary > 12000

--OK


--Task 3.4
--Display the last name and department number for employee number 176

select *
from
(
    select hr.employees.employee_id, hr.employees.last_name, hr.departments.department_name
    from hr.employees
    left join hr.departments on hr.employees.department_id = hr.departments.department_id
)
where employee_id = 176

--Reseni i tak funguje, ale lze napsat jednoduseji v jednom selektu
--a doporucuji pouzivat alias pro nazvy tabulek v dotazu kde se pracuje s vice tabulkami.
--Zlepsuje to prehlednost zapisu.

--Oprava:

select emp.employee_id, emp.last_name, dep.department_name
from hr.employees emp
left join hr.departments dep on emp.department_id = dep.department_id
where employee_id = 176

--OK


--Task 3.5
--Display the last name and salary for all employees whose salary is not in the range of $5,000 to $12,000

--Poznámka: není záznam v dolarech proto použití záznamu bez označení

select last_name, salary
from hr.employees
where salary not between 5000 and 12000

--OK


--Task 3.6
--Display the last name, job ID, and start date (hire date) for the employees with the last names of Matos and Taylor.
--Order the query in ascending order by start date.

select last_name, job_ID, hire_date
from hr.employees
where last_name = 'Matos' or last_name = 'Taylor'
order by hire_date asc

--OK 

--Spravne tam patri OR, jedna se o bud 'Matos' nebo 'Taylor',
--kdyby tam byla logicka spojka AND tak by to nevybralo zadny radek, protoze neexistuje last_name
--ktere je zaroven 'Matos' a 'Taylor'.


--Task 3.7
--Display the last name and department number of all employees in departments 20 or 50 in ascending alphabetical and order by name.

select last_name, department_id
from hr.employees
where department_id = '20' or department_id = '50'
order by last_name asc;

--OK


--Task 3.8
--Display the last name and job title of all employees who do not have a manager.
--Je treba pouzit join pro pripojeni tabulky jobs kde je ulozeno job_title.
--Protoze te zajima radek zamestnance pouzijeme left join pripojujici k danemu zamestnanci zaznamy z tabulky jobs a projekci pote vybereme job_title.
--Ve vypisu je pouze jeden zamestnanec, ktery nema zadneho nadrizeneho a jedna se o prezidenta spolecnosti.

select emp.last_name, j.job_title
from hr.employees emp
left join hr.jobs j on emp.job_id = j.job_id
where emp.manager_id is null;

--OK


--Task 3.9
--Display the last name, salary, and commission for all employees who earn commissions.
--Sort data in descending
--order of salary and commissions.
--Je dobrym zvykem psat sql v jednom stylu cele tedy bud lower case nebo upper case. 
--Serazene je to spavne, prvni se seradily zaznamy podle atributu salary a skupinka se stejnou salary se dale radila dle commission_pct.

select last_name, salary, commission_pct
from hr.employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--OK 


--Task 3.10
--Find the highest, lowest, sum, and average salary of all employees.
--Label the columns Maximum, Minimum, Sum, and Average, respectively.

select max(salary) as highest_salary, min(salary) as lovest_salary, sum(salary)as total_salary, avg(salary) as average_salary
from hr.employees;

--OK


--Task 3.11
--Modify the previous query to display the minimum, maximum, sum, and average salary
--for each job type (job_id).

select job_id, max(salary) as highest_salary, min(salary) as lovest_salary, avg(salary) as average_salary, sum(salary) as total_salary
from hr.employees
group by job_id;

--OK


--Task 3.12
--Display the number of people with the same job

select job_id, count(job_id) from hr.employees
group by job_id;

--OK


--Task 3.13
--Determine the number of managers without listing them.
--Label the column Number of Managers.
--Hint: Use the column MANAGER_ID to determine the number of managers.

select count (distinct manager_id) as number_of_managers from hr.employees;

--OK


--Task 3.14
--Find the difference between the highest and lowest salaries.
--Label the column DIFFERENCE.

select (highest_salary - lowest_salary) as difference
from
(
    select max(salary) as highest_salary, min(salary) as lowest_salary
    from hr.employees
);

--OK


--Task 3.15
--Find the addresses of all the departments. Use the LOCATIONS and COUNTRIES tables.

select department_name, street, city, countries
from
(
    select locations.location_id, locations.street_address as street, locations.city as city, countries.country_name as countries
    from hr.locations
    left join hr.countries on locations.country_id = countries.country_id
) loc
right join hr.departments on loc.location_id = departments.location_id;

--OK


--Task 3.16
--Show the location ID, street address, city, state or province, and country in the output.

select loc.location_id, department_name, street, city, state_province, countries
from
(
    select locations.location_id, locations.street_address as street, locations.city as city, locations.state_province as state_province, countries.country_name as countries
    from hr.locations
    left join hr.countries on locations.country_id = countries.country_id
) loc
left join hr.departments on loc.location_id = departments.location_id;

--ok asi nevím jestli mám použít left join a to nechá null když to není v druhé tabulce nebo tím mysleli right join a to jen shodné v obou tabulkách


--Task 3.17
--Display the last name and department name for all employees.

select employees.last_name, departments.department_name
from hr.employees
left join hr.departments on employees.department_id = departments.department_id;

--OK


--Task 3.18
--Display the last name, job, department number, and department name for all employees who work in Toronto.

select last_name, job_title, dep.department_id, dep.department_name, city
from hr.employees emp
left join hr.departments dep on emp.department_id = dep.department_id
left join hr.jobs job on emp.job_id = job.job_id
left join hr.locations loc on dep.location_id = loc.location_id
where city = 'Toronto';

--OK