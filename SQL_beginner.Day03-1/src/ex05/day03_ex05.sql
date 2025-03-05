WITH visits
     AS (SELECT *
         FROM   person_visits
         WHERE  EXISTS (SELECT *
                        FROM   person
                        WHERE  person_id = person.id
                               AND NAME = 'Andrey')),
     orders
     AS (SELECT *
         FROM   person_order
         WHERE  EXISTS (SELECT *
                        FROM   person
                        WHERE  person_id = person.id
                               AND NAME = 'Andrey')),
     pizzerias
     AS (SELECT pizzeria_id
         FROM   menu
         WHERE  id IN (SELECT menu_id
                       FROM   orders))
                       
SELECT (SELECT NAME
        FROM   pizzeria
        WHERE  pizzeria_id = pizzeria.id) AS pizzeria_name
FROM   (SELECT *
        FROM   visits)
WHERE  pizzeria_id NOT IN (SELECT *
                           FROM   pizzerias)
ORDER  BY pizzeria_name; 