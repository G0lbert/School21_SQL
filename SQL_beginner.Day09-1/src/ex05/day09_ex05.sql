DROP FUNCTION fnc_persons_male(), fnc_persons_female();
RETURNS 
    TABLE (id bigint, NAME varchar, age integer, gender varchar, address varchar) AS 
$$
    SELECT *
    FROM   person
    WHERE  gender = pgender;
$$ language sql;

SELECT *
FROM   Fnc_persons(pgender := 'male');

SELECT *
FROM   Fnc_persons();