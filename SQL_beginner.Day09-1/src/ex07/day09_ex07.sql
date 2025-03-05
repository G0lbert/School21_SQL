CREATE OR REPLACE FUNCTION func_minimum(variadic arr numeric[])
RETURNS numeric AS 
$$
SELECT MIN(j)
FROM   Unnest(arr) g(j) 
$$ 
LANGUAGE SQL;

SELECT func_minimum(variadic arr => array[10.0, -1.0, 5.0, 4.4]);