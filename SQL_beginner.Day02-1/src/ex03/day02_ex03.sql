WITH "day generator" AS
(
       SELECT generate_series::date AS missing_date
       FROM   generate_series('01.01.2022'::date, '10.01.2022'::date, '1 day') 
       )

SELECT    missing_date
FROM      "day generator"
LEFT JOIN person_visits
ON        missing_date = visit_date
AND       ( person_id = 1 OR person_id = 2 )
WHERE     visit_date IS NULL
ORDER BY  missing_date ASC;