-- сейчас вроде читабельность нормальная стала благодаря CTE
WITH find_person
     AS (SELECT NAME,
                id
         FROM   person
         WHERE  gender = 'male'
                AND ( address = 'Moscow'
                       OR address = 'Samara' )),
     find_pizza
     AS (SELECT id
         FROM   menu
         WHERE  pizza_name = 'pepperoni pizza'
                 OR pizza_name = 'mushroom pizza'),
     find_person_id
     AS (SELECT person_id
         FROM   person_order
         WHERE  menu_id IN (SELECT *
                            FROM   find_pizza))
SELECT NAME
FROM   find_person
       JOIN find_person_id
         ON find_person.id = person_id
GROUP  BY NAME
ORDER  BY NAME DESC; 