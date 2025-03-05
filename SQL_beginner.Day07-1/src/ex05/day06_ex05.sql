SELECT DISTINCT NAME
FROM   person_order
       JOIN person
         ON person.id = person_id
ORDER  BY 1; 