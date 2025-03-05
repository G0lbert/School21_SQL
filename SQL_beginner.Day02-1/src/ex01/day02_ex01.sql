SELECT generate_series :: DATE AS missing_date
FROM   generate_series('01.01.2022'::DATE, '10.01.2022'::DATE, '1 day')
       LEFT JOIN person_visits
              ON generate_series = visit_date
                 AND ( person_id = 1
                        OR person_id = 2 )
WHERE  visit_date IS NULL
ORDER  BY missing_date ASC; 