WITH men_favorite_pizzerias
     AS (SELECT (SELECT NAME
                 FROM   pizzeria
                 WHERE  pizzeria_id = pizzeria.id),
                Count(pizzeria_id) AS men_visits
         FROM   person_visits
                JOIN person
                  ON person.id = person_id
         WHERE  gender = 'male'
         GROUP  BY pizzeria_id),
     women_favorite_pizzerias
     AS (SELECT (SELECT NAME
                 FROM   pizzeria
                 WHERE  pizzeria_id = pizzeria.id),
                Count(pizzeria_id) AS women_visits
         FROM   person_visits
                JOIN person
                  ON person.id = person_id
         WHERE  gender = 'female'
         GROUP  BY pizzeria_id)
SELECT m.NAME AS pizzeria_name
FROM   men_favorite_pizzerias m
       JOIN women_favorite_pizzerias w
         ON m.NAME = w.NAME
            AND men_visits != women_visits
ORDER  BY pizzeria_name; 