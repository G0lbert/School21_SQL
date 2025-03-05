SELECT NAME,
       Count(pizzeria_id) AS count_of_visits
FROM   person_visits
       JOIN person
         ON person.id = person_id
GROUP  BY NAME
HAVING Count(pizzeria_id) > 3
ORDER  BY 2 DESC,
          1 ASC; 