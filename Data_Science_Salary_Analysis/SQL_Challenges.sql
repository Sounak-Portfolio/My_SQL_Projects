-- CREATE DATABASE Company;

-- use Company;

-- select * from companies;
-- select * from jobs;

## 1. What is the average salary for all the jobs in the dataset?
select avg(salary) as average_salary 
from jobs;

## 2. What is the highest salary in the dataset and which job role does it correspond to?
SELECT MAX(salary) AS highest_salary, job_title FROM jobs;

## 3. What is the average salary for data scientists in US?
select avg(salary), job_title,company_location
from jobs
where job_title="Data Scientist" and
	  company_location="US";
      
## 4. What is the number of jobs available for each job title?
select job_title, count(*) as count_of_jobs
from jobs
group by job_title
order by count_of_jobs desc;

## 5. What is the total salary paid for all data analyst jobs in DE?
select sum(salary) as total_salary,
		job_title,company_location
from jobs
where job_title="Data Analyst" and
	  company_location="DE";

## 6. What are the top 5 highest paying job titles and their corresponding average salaries?
select job_title,
		avg(salary) as average_salary
from jobs
group by job_title
order by average_salary desc
limit 5;

## 7. What is the number of jobs available in each location?
select company_location,
		count(*) as no_of_jobs_per_location
from jobs
group by company_location
order by no_of_jobs_per_location desc;

## 8. What are the top 3 job titles that have the most jobs available in the dataset?
select job_title, 
		count(*) as no_of_jobs_available
from jobs
group by job_title
order by no_of_jobs_available desc
limit 3;

## 9. What is the average salary for data engineers in US?
select job_title,
		company_location,
		avg(salary) as average_salary
from jobs
where job_title="Data Engineer" and
		company_location="US";
        
## 10. What are the top 5 cities with the highest average salaries?
select company_location,
		avg(salary) as average_salary
from jobs
group by company_location
order by average_salary desc
limit 5;

## 11. What is the average salary for each job title, and what is the total number of jobs available for each job title?
select job_title,
		avg(salary) as average_salary,
		count(*) as no_of_jobs_available
from jobs
group by job_title;

## 12. What are the top 5 job titles with the highest total salaries, and what is the total number of jobs available for each job title?
select job_title,
		sum(salary) as total_salary,
		count(*) as no_of_jobs_available
from jobs
group by job_title
order by total_salary desc
limit 5;

## 13. What are the top 5 locations with the highest total salaries, and what is the total number of jobs available for each location?
select company_location,
		sum(salary) as total_salary,
		count(*) as no_of_jobs_available
from jobs
group by company_location
order by total_salary desc
limit 5;

## 14. What is the average salary for each job title in each location, and what is the total number of jobs available for each job title in each location?
select job_title, company_location,
		avg(salary) as average_salary,
        count(*) as no_of_jobs_available
from jobs
group by job_title,company_location;

## 15. What is the average salary for each job title in each location, and what is the percentage of jobs for each job title in each location?
select job_title, company_location,
		avg(salary) as average_salary,
        count(*) as no_of_jobs_available,
        (count(*)*100)/(select count(*) from jobs 
					  where company_location=jobs.company_location) as percentage_of_jobs_availabe
from jobs
group by job_title,company_location
order by percentage_of_jobs_availabe desc;    

## 16. What are the top 5 job titles with the highest average salaries, and what is the total number of jobs available for each job title?
select job_title,
		avg(salary) as average_salary,
        count(*) as no_of_jobs_available
from jobs
group by job_title
order by average_salary desc 
limit 5;
       
## 17. What is the average salary for each job title, and what is the percentage of jobs for each job title in the dataset?
select job_title,
		avg(salary) as average_salary,
        (count(*)*100)/(select count(*) from jobs 
					  where company_location=jobs.company_location) as percentage_of_jobs_availabe
from jobs
group by job_title
order by percentage_of_jobs_availabe desc;		

## 18. What is the total number of jobs available for each year of experience, and what is the average salary for each year of experience?
select experience_level,
		count(*) as no_of_jobs_available,
        avg(salary) as average_salary
from jobs
group by experience_level;      
/*
EN, which refers to Entry-level / Junior.
MI, which refers to Mid-level / Intermediate.
SE, which refers to Senior-level / Expert.
EX, which refers to Executive-level / Director.
*/			

## 19. What are the top 5 job titles with the highest average salaries in each location?
select job_title, company_location,
		avg(salary) as average_salary
from jobs
group by job_title,company_location
order by average_salary desc
limit 5;  

# 20. What are the top 5 job titles with the highest salaries, and what is the name of the company that offers the highest salary for each job title?
select job_title,
		max(salary) as highest_salary,
		company_name
from jobs
left join companies
		on jobs.id=companies.id
group by job_title
order by highest_salary desc
limit 5;

## 21. What is the total number of jobs available for each job title, and what is the name of the company that offers the highest salary for each job title?
SELECT job_title, COUNT(*) AS num_jobs, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE salary = (SELECT MAX(salary) FROM jobs WHERE job_title = jobs.job_title) 
GROUP BY job_title, company_name;
       
## 22. What are the top 5 cities with the highest average salaries, and what is the name of the company that offers the highest salary for each city?
SELECT company_location, AVG(salary) AS average_salary, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY company_location 
ORDER BY average_salary DESC 
LIMIT 5;
       
## 23. What is the average salary for each job title in each company, and what is the rank of each job title within each company based on the average salary?
SELECT job_title, company_name, AVG(salary) AS average_salary, 
RANK() OVER (PARTITION BY company_name ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY job_title, company_name;

## 24. What is the total number of jobs available for each job title in each location, and what is the rank of each job title within each location based on the total number of jobs?
SELECT job_title, company_location, COUNT(*) AS num_jobs, 
RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS job_rank 
FROM jobs 
GROUP BY job_title, company_location;

## 25.What are the top 5 companies with the highest average salaries for data scientist positions, and what is the rank of each company based on the average salary?
SELECT company_name, AVG(salary) AS average_salary, 
RANK() OVER (ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE job_title = 'Data Scientist' 
GROUP BY company_name 
ORDER BY average_salary DESC 
LIMIT 5;

## 26. What is the total number of jobs available for each year of experience in each location, and what is the rank of each year of experience within each location based on the total number of jobs?
SELECT work_year, company_location, COUNT(*) AS num_jobs, 
RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS experience_rank 
FROM jobs 
GROUP BY work_year, company_location;

-- ---------------------------------------------------------------------------- THE END --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       