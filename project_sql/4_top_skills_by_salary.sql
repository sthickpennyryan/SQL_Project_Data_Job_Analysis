/* 
Question: What are the top skills based on salary?
- average salaries assoicated with each skill for Data Analyst roles
- No Nulls for salary
Purpose: Reveals how different skills impact the salary levels for data analysts
and helps identify the most financially rewarding skills to acquire
*/

SELECT * FROM job_postings_fact LIMIT 5;



--- rounded to 2dp for monintary values
SELECT
    sd.skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jp
INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
ORDER BY
    avg_salary DESC
LIMIT 10;

--- comparing general salaries to remote work salary
SELECT
    sd.skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jp
INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY 
    sd.skills
ORDER BY
    avg_salary DESC
LIMIT 10;