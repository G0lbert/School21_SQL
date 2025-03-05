-- Два одинаково работающих  запроса( по времени и производительности тоже) - первый с помощью CTE -
-- подумал, что так будет читабельнее ( хз, мне не очень читабельнее получилось )
WITH find_person
     AS (SELECT id
         FROM   person
         WHERE  NAME = 'Denis'
                 OR NAME = 'Anna'),
     find_persons_order
     AS (SELECT menu_id
         FROM   person_order
         WHERE  person_id IN (SELECT *
                              FROM   find_person))

SELECT pizza_name,
       (SELECT pizzeria.NAME
        FROM   pizzeria
        WHERE  pizzeria.id = pizzeria_id) AS pizzeria_name
FROM   menu
WHERE  id IN (SELECT *
              FROM   find_persons_order)
ORDER  BY pizza_name,
          pizzeria_name;

-- второй просто с подзапросами
SELECT pizza_name,
       (SELECT pizzeria.NAME
        FROM   pizzeria
        WHERE  pizzeria.id = pizzeria_id) AS pizzeria_name
FROM   menu
WHERE  id IN (SELECT menu_id
              FROM   person_order
              WHERE  person_id IN (SELECT id
                                   FROM   person
                                   WHERE  NAME = 'Denis'
                                           OR NAME = 'Anna'))
ORDER  BY pizza_name,
          pizzeria_name; 