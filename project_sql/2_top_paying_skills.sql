
/* 
What are the skills required for these top-paying roles?
    - utilise previous top 10 paying jobs query
    - identifying skills needed for these roles by join skills_dim 
    - identify what skills come with the higher price and why and this can be
    used by job seeking to identify skills related to high pay
*/

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
----
SELECT 
    jp.job_id,
    jp.job_title,
    jp.job_location,
    jp.job_schedule_type,
    jp.salary_year_avg,
    jp.job_posted_date,
    sd.skills,
    cd.name AS company_name
FROM job_postings_fact jp
LEFT JOIN company_dim cd
ON jp.company_id = cd.company_id
LEFT JOIN skills_job_dim sj
ON jp.job_id = sj.job_id
LEFT JOIN skills_dim sd
ON sj.skill_id = sd.skill_id
WHERE job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL
AND job_title = 'Data Analyst'
ORDER BY salary_year_avg DESC
LIMIT 10;

SELECT * FROM skills_job_dim LIMIT 5; --- has job_id and skill_id 
SELECT * FROM skills_dim LIMIT 5; --- has skill_id but no job_id
--- need to join skills_job_dim to get skill_id and then skills_dim to get skills
--- Above works but is quite messy and has unneccary columns

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact jp
    LEFT JOIN company_dim cd ON jp.company_id = cd.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL 
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    tp.*,
    sd.skills
FROM top_paying_jobs tp
INNER JOIN skills_job_dim sj ON tp.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
ORDER BY salary_year_avg DESC;
--- location removed, schedule removed, date posted removed
--- getting same job_id over several roles due to different skills
