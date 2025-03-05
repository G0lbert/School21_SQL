SELECT address,
       ROUND(( MAX(age) - MIN(age) / MAX(age :: NUMERIC) ), 2) AS formula,
       ROUND(Avg(age), 2)                                      AS average,
       CASE
         WHEN MAX(age) - MIN(age) / MAX(age :: NUMERIC) <= Avg(age) THEN FALSE
         ELSE TRUE
       END AS comparison
FROM   person
GROUP  BY address
ORDER  BY 1; 