SELECT name,
       COUNT(pizzeria_id) AS count_of_visits
FROM   person_visits
       JOIN person
         ON person_id = person.id
GROUP  BY name
ORDER  BY 2 DESC,
          1 ASC
LIMIT  4; 