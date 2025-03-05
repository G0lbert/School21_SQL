-- типа переписанный 8 запрос, но с интересным HAVING-ом
WITH find_person
     AS (SELECT NAME,
                id
         FROM   person
         WHERE  gender = 'female'),
     find_pizza
     AS (SELECT id
         FROM   menu
         WHERE  pizza_name = 'pepperoni pizza'
                 OR pizza_name = 'cheese pizza'),
     find_person_id
     AS (SELECT person_id,
                Count(person_id)
         FROM   person_order
         WHERE  menu_id IN (SELECT *
                            FROM   find_pizza)
         GROUP  BY person_id
         HAVING Count(person_id) >= 2)

SELECT NAME
FROM   find_person
       JOIN find_person_id
         ON find_person.id = person_id
GROUP  BY NAME
ORDER  BY NAME ASC; 