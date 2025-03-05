SELECT pizza_name,
       price,
       (SELECT pizzeria.NAME
        FROM   pizzeria
        WHERE  pizzeria.id = person_visits.pizzeria_id) AS pizzeria_name,
       visit_date
FROM   person_visits
       JOIN menu
         ON menu.pizzeria_id = person_visits.pizzeria_id
WHERE  person_id = (SELECT id
                    FROM   person
                    WHERE  NAME = 'Kate')
       AND price BETWEEN 800 AND 1000
ORDER  BY pizza_name,
          price,
          pizzeria_name,
          visit_date; 