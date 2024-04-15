Create Database theProject;

use theproject;

select * from hr;

alter table hr
change column ï»¿id emp_id varchar(20) null;

describe hr;

set sql_safe_updates = 0;

update hr
set birthdate = CASE
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table hr
modify column birthdate date;

update hr
set hire_date = CASE
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table hr
modify column hire_date date;

update hr
set termdate = date(str_to_date(termdate, '%y-%m-%d %h:%i:%s UTC'))
	where termdate is not null and termdate !='';

alter table hr
modify column termdate date;
    
select termdate from hr;

alter table hr add column age int;

update hr
set age = timestampdiff(year, birthdate, curdate());

select birthdate, age from hr;

select
	min(age) as youngest,
    max(age) as oldest
from hr;

select count(*) from hr where age < 18;

-- gender breakdown of the employees in the company
select gender, count(*) as count
from hr where age >= 18 and termdate = '0000-00-00'
group by gender;

-- ethnicity breakdown of employees
select race, count(*) as count
from hr where age >= 18 and termdate = '0000-00-00'
group by race
order by count(*) desc;

-- age distribution of employees
select
	min(age) as youngest,
    max(age) as oldest
from hr where age >= 18 and termdate = '0000-00-00';

select 
	case
		when age >= 18 and age <= 29 then '18-29'
        when age >= 30 and age <= 39 then '30-39'
        when age >= 40 and age <= 49 then '40-49'
        when age >= 50 and age <= 60 then '50-60'
        else '60+'
	end as age_group,
    count(*) as count
from hr where age >= 18 and termdate = '0000-00-00'
group by age_group
order by age_group;
     
 select
	min(age) as youngest,
    max(age) as oldest
from hr where age >= 18 and termdate = '0000-00-00';

select 
	case
		when age >= 18 and age <= 29 then '18-29'
        when age >= 30 and age <= 39 then '30-39'
        when age >= 40 and age <= 49 then '40-49'
        when age >= 50 and age <= 60 then '50-60'
        else '60+'
	end as age_group, gender,
    count(*) as count
from hr where age >= 18 and termdate = '0000-00-00'
group by age_group, gender
order by age_group, gender;
 
-- employees at HQ vs remote locations
select location, count(*) as count
from hr where age >= 18 and termdate = '0000-00-00'
group by location;

-- gender distribtion across depts & job titles
select department, gender, count(*) as count 
from hr where age >= 18 and termdate = '0000-00-00'
group by department, gender
order by department; 

-- distribution of job titles across the company
select jobtitle, count(*) as count
from hr where age >= 18 and termdate = '0000-00-00'
group by jobtitle
order by jobtitle desc;

-- distribution of employees by state
select location_state, count(*) as count
from hr where age >= 18 and termdate = '0000-00-00'
group by location_state
order by count desc;
