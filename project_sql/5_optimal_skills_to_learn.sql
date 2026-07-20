/* 
Question: what are the most optimal skills to learn? (this would be most in demand and highest paying skills)
- need to find the higher demand skills that are associated with the highest avgerage salaries for Data Analyst roles
- See if remote work changes what skills are most in demand
Purpose: High demand skills often offer job security and financial/career benefits due to high salaries
*/

WITH skills_demand AS (
    SELECT 
        sd.skill_id,
        sd.skills,
        COUNT(sj.job_id) AS demand    
    FROM job_postings_fact jp
    INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst' AND
        jp.salary_year_avg IS NOT NULL AND
        jp.job_work_from_home = TRUE
    GROUP BY
        sd.skill_id
), average_salary AS (
    SELECT
        sd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact jp
    INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY 
        sd.skill_id
) 

SELECT 
    sd.skill_id,
    sd.skills,
    demand,
    avg_salary
FROM skills_demand sd
INNER JOIN average_salary asl ON sd.skill_id = asl.skill_id
WHERE demand >= 10
ORDER BY 
    avg_salary DESC,
    demand DESC
    
LIMIT 25;

--- double CTE is lengthy and not ideal. Attempted rewrite below:
--- contains the same info and is potentially a bit easier to follow
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sj.job_id) AS demand,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jp
  INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
  INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY 
        sd.skill_id
HAVING 
    COUNT(sj.job_id) >= 10    
ORDER BY 
    avg_salary DESC,
    demand DESC
LIMIT 25;

