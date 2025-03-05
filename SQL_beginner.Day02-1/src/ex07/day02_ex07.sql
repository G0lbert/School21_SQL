-- дада, я опять решил выпендриться с CTE. Но хз насколько читаемость улучшилась
WITH find_person
     AS (SELECT id
         FROM   person
         WHERE  NAME = 'Dmitriy'),
     find_low_price_pizza
     AS (SELECT pizzeria_id
         FROM   menu
         WHERE  price < 800)
         
SELECT (SELECT pizzeria.NAME
        FROM   pizzeria
        WHERE  pizzeria.id = pizzeria_id) AS pizzeria_name
FROM   person_visits
WHERE  visit_date = '08.01.2022'
       AND person_id = (SELECT *
                        FROM   find_person)
       AND pizzeria_id IN (SELECT *
                           FROM   find_low_price_pizza); 