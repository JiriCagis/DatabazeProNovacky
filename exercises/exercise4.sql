-- Exercise 4

-- Task 1
-- Show last names and numbers of all managers together with the number of employees that are his / her subortinates.
select emp1.employee_id as manager_number, job_id, last_name,
(
	select count(*)
	from hr.employees emp2
	where emp2.manager_id = emp1.employee_id
) as count_employess
from hr.employees emp1
where job_id like '%_M%'



-- Task 2
-- Create a report that displays the department name, location name, job title and salary of those employeses who work
-- in a specific (given) location.
select 	department_name, 
		(street_address||', '||postal_code||', '||city||', '||state_province||', '||country_name||', '||region_name) as location_name, 
		job_title, 
		salary
from hr.employees emp
	left join hr.departments dep on emp.department_id = dep.department_id
	left join hr.jobs job on emp.job_id = job.job_id
	left join hr.locations loc on dep.location_id = loc.location_id
	left join hr.countries cou on loc.country_id = cou.country_id
	left join hr.regions reg on cou.region_id = reg.region_id;



-- Task 3
-- Find the number of employees who have a last name that ends with the letter n.
select count(*)
from hr.employees
where last_name like '%n';



-- Task 4
-- Create a report that shows the name, location and the number of employees for each department. Make sure that
-- report also includes departments without employees.
select  dep.department_name, 
        (loc.street_address || ' ' || loc.city) as location,
        (   
            select count(*)
            from hr.employees emp
            where emp.department_id = dep.department_id
        ) as count_employess
from hr.departments dep
    left join hr.locations loc on dep.location_id = loc.location_id
order by count_employess;



-- Task 5
-- Show all employees who were hired in the first half of the month (before the 16
select employee_id, first_name, last_name,hire_date
from hr.employees
where extract(day from hire_date) < 16



-- Task 6
-- Create a report to display the department number and lowest salary of the department with the highest average
-- salary.
select  dep.department_id, 
        dep.department_name,
        (
            select min(salary)
            from hr.employees emp
            where emp.department_id = dep.department_id
        ) as lowest_salary,
        (
            select max(salary)
            from hr.employees emp
            where emp.department_id = dep.department_id
        ) as highest_salary
from hr.departments dep



-- Task 7
-- Create a report that displays department where no sales representatives work. Include the deprtment number,
-- department name and location in the output.
select  dep.department_id, 
        dep.department_name,
        (loc.street_address || ' ' || loc.city) as location
from hr.departments dep
    left join hr.locations loc on dep.location_id = loc.location_id
where not exists 
     (
        select emp.employee_id
        from hr.employees emp
        where dep.department_id = emp.department_id and emp.job_id = 'SA_MAN'
     )



-- Task 8
-- Display the depatrment number, department name and the number of employees for the department:
-- a. with the highest number of employees.
-- b. with the lowest number of employees
-- c. that employs fewer than three employees.
select department_id,count_employees, 'department_with_the_highest_number_of_employees' as description
from 
(
    select department_id,count(*) as count_employees
    from hr.employees
    group by department_id
    order by count_employees desc
)
where rownum = 1
union
select department_id,count_employees, 'department_with_the_lowest_number_of_employees' as description
from 
(
    select department_id,count(*) as count_employees
    from hr.employees
    group by department_id
    order by count_employees asc
)
where rownum = 1
union
select department_id,count_employees, 'department_that_employs_fewer_than_three_employees.' as description
from 
(
    select department_id,count(*) as count_employees
    from hr.employees
    group by department_id
    having count(*) < 3
    order by count_employees asc
)
order by description



-- Task 9
-- Display years and total numbers of employees that were employed in that year.
select  extract(year from hire_date) as year, 
        count(*) as count_hired_employees
from hr.employees
group by extract(year from hire_date)
order by year asc



-- Task 10
-- Display countries and number of locations in that country.
select countries.country_name, group_table.count_of_locations
from 
    (
        select country_id,count(*) as count_of_locations
        from hr.locations
        group by country_id
    ) group_table
left join hr.countries countries on countries.country_id = group_table.country_id
