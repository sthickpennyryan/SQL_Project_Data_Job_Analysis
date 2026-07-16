/*
Question: What are the most in-demand skills for data analysts?
- Identify the top 5 in-demand skills for a data analyst
- Focus on all job postings
- Why? Insight into the most in demand skills for these roles that 
a job seeker may wish to improve/develop
*/

SELECT * FROM skills_dim LIMIT 5;

SELECT 
    sd.skills,
    COUNT(sj.job_id) AS demand
FROM job_postings_fact jp
INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
GROUP BY
    sd.skills
ORDER BY
    demand DESC
LIMIT 5;
--- this query gives us the top 5 skills but we need it specifically for data analysts

SELECT * FROM job_postings_fact LIMIT 5;

SELECT 
    sd.skills,
    COUNT(sj.job_id) AS demand    
FROM job_postings_fact jp
INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
WHERE 
    jp.job_title_short = 'Data Analyst' AND
    jp.job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
        demand DESC
LIMIT 5;


