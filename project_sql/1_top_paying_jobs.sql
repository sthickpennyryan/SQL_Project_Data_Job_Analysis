/* 
Question: What are the top-paying data analyst jobs?
    - identifying the top 10 highest-payying data analyst roles remotely
    - Jobs need to have a specified salary (remove nulls)
    - Why? Why are the top paying jobs paying this price
*/

SELECT * FROM (SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
WHERE job_location = 'Anywhere'
AND
salary_year_avg IS NOT NULL) 
WHERE job_title = 'Data Analyst'
ORDER BY salary_year_avg DESC
LIMIT 10;
--- this gives us the top 10 highest paying remote data analyst jobs
--- now we need to figure out what exactly makes them so expensive
--- The above tells us the money but not a lot about the company/why it pays so well

SELECT * FROM company_dim LIMIT 5;
SELECT * FROM job_postings_fact LIMIT 5;

--- my original subqueried result may be a bit more problematic so going to change this
--- for the below 

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
     cd.name AS company_name
FROM job_postings_fact jp
LEFT JOIN company_dim cd
ON jp.company_id = cd.company_id
WHERE job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL
AND job_title = 'Data Analyst'
ORDER BY salary_year_avg DESC
LIMIT 10;
