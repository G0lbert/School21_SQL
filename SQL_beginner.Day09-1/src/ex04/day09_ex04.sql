CREATE OR REPLACE FUNCTION fnc_persons_female()
returns TABLE 
    (id bigint, NAME varchar, age integer, gender varchar, address varchar) 
AS $$
    SELECT *
    FROM   person
    WHERE  gender = 'female';
$$ language sql;

CREATE OR REPLACE FUNCTION fnc_persons_male()
returns TABLE 
    (id bigint, NAME varchar, age integer, gender varchar, address varchar) 
AS $$
    SELECT *
    FROM   person
    WHERE  gender = 'male';
$$ language sql;

SELECT *
FROM   fnc_persons_male();

SELECT *
FROM   fnc_persons_female();