CREATE DATABASE Recursos_Humanos;

USE recursos_humanos;

RENAME TABLE nueva TO hr;

SELECT * FROM hr;

SET sql_safe_updates = 0;

ALTER TABLE hr
CHANGE COLUMN ï»¿id empleado_id VARCHAR(20) NULL;


select termdate from hr;

UPDATE hr
SET termdate = 
    CASE
        WHEN termdate IS NULL OR termdate = '' THEN '0000-00-00'
        ELSE DATE_FORMAT(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'), '%Y-%m-%d')
    END;
    
-- MODO PARA MODIFICAR EL TIPO DE DATO
SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;
SET sql_mode = '';

describe hr;

SELECT birthdate FROM hr;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE null
END;

ALTER TABLE hr
modify column birthdate date;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE null
END;

SELECT hire_date FROM hr;

SET sql_mode = 'ALLOW_INVALID_DATES';
SELECT COUNT(*) AS PRUEBA_1_CONTAR_FECHAS_INVALIDAS
FROM hr
WHERE termdate = '0000-00-00';
SET sql_mode = '';

UPDATE hr
SET termdate = NULL
WHERE termdate = '';
SET sql_mode = 'ALLOW_INVALID_DATES';

SELECT termdate FROM hr;

ALTER TABLE hr
modify column termdate date;

ALTER TABLE hr
modify column hire_date date;

ALTER TABLE hr ADD COLUMN age INT;

SELECT * FROM hr;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate, CURDATE());

SELECT birthdate, age FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

SELECT
    min(age)AS youngest,
    max(age) AS oldest
FROM hr;

