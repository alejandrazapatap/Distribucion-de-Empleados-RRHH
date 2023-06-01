-- QUESTIONS

-- 1. Cuál es el desglose por sexos de los empleados de la empresa?

SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;


-- 2. Cuál es el desglose por raza/etnia de los empleados de la empresa?

SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race 
ORDER BY count(*) DESC;

-- 3. Cuál es la distribución por edades de los empleados de la empresa?
SELECT
    min(age)AS youngest,
    max(age) AS oldest
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT 
	CASE
		WHEN age >=18 AND age <=24 THEN '18-24'
		WHEN age >=25 AND age <=34 THEN '25-34'
		WHEN age >=35 AND age <=44 THEN '35-44'
		WHEN age >=45 AND age <=54 THEN '45-54'
		WHEN age >=55 AND age <=64 THEN '55-64'
		ELSE '65+'
	END AS age_group,
	count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;


SELECT 
	CASE
		WHEN age >=18 AND age <=24 THEN '18-24'
		WHEN age >=25 AND age <=34 THEN '25-34'
		WHEN age >=35 AND age <=44 THEN '35-44'
		WHEN age >=45 AND age <=54 THEN '45-54'
		WHEN age >=55 AND age <=64 THEN '55-64'
		ELSE '65+'
	END AS age_group, gender,
	count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. Cuántos empleados trabajan en la sede central y cuántos en ubicaciones remotas?

SELECT location, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5. Cuál es la duración media del empleo de los trabajadores despedidos?
SELECT 
	round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_employment
    FROM hr
    WHERE termdate <= curdate()AND termdate <> '0000-00-00'AND age >=18;
-- 6. Cómo varía la distribución por sexos en los distintos departamentos y puestos de trabajo?
SELECT department, gender, COUNT(*)AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- 7. Cómo se distribuyen los puestos de trabajo en la empresa?

SELECT jobtitle, count(*)AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;
-- 8. Qué departamento tiene el mayor índice de rotación?
SELECT department, 
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
	SELECT department,
    count(*)AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate()THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    WHERE age >= 18
    GROUP BY department
    )AS subquery 
ORDER BY termination_rate DESC;
-- 9. Cuál es la distribución de los empleados por ciudades y estados?
SELECT location_state, COUNT(*)AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

/* 10. Cómo ha cambiado el número de empleados de la empresa a lo largo del tiempo en función de las fechas 
de contratación y de finalización del contrato? */

SELECT 
year,
hires,
terminations,
hires-terminations AS net_change,
round((hires-terminations)/hires * 100,2) AS net_change_percent
FROM(
	SELECT
    YEAR(hire_date)AS year,
    count(*)AS hires,
    SUM(CASE WHEN termdate <> '0000-00-00'AND termdate <= curdate()THEN 1 ELSE 0 END) AS terminations
    FROM hr
    WHERE age >=18
    GROUP BY YEAR(hire_date)
    )AS subquery
ORDER BY year ASC;
    
-- 11. Cuál es la distribución de la titularidad en cada departamento?
SELECT department, round(avg(datediff(termdate, hire_date)/365),0)AS avg_tenure
FROM hr
WHERE termdate <= curdate()AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department;
