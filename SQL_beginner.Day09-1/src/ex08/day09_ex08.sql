CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop bigint DEFAULT 10)
returns 
    TABLE(number1 bigint) AS 
$$ WITH recursive fibonacci(number1, number2) AS
    (
        SELECT 1,
                1
        UNION ALL
        SELECT number2 + number1,
                number1
        FROM   fibonacci
        WHERE  number1 < pstop )
SELECT number1
FROM   fibonacci 
$$ 
LANGUAGE SQL;

SELECT *
FROM   Fnc_fibonacci(100);

SELECT *
FROM   Fnc_fibonacci();