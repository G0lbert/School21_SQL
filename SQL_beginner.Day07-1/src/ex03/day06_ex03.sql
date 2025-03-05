WITH visits
     AS (SELECT NAME,
                Count(pizzeria_id) AS count,
                'visit'            AS action_type
         FROM   person_visits
                JOIN pizzeria
                  ON pizzeria.id = person_visits.pizzeria_id
         GROUP  BY NAME,
                   action_type),
     orders
     AS (SELECT NAME,
                Count(pizzeria_id) AS count,
                'order'            AS action_type
         FROM   person_order
                JOIN menu
                  ON menu.id = menu_id
                JOIN pizzeria
                  ON pizzeria.id = menu.pizzeria_id
         GROUP  BY NAME,
                   action_type),
     total_count
     AS (SELECT visits.NAME,
                visits.count + orders.count AS total_count2
         FROM   visits
                JOIN orders
                  ON visits.NAME = orders.NAME
         ORDER  BY 2 DESC,
                   1 ASC) 
                   
SELECT *
FROM   total_count
UNION ALL
SELECT NAME,
       count
FROM   visits
WHERE  NOT EXISTS (SELECT NAME
                   FROM   total_count
                   WHERE  total_count.NAME = visits.NAME)
UNION ALL
SELECT NAME,
       count
FROM   orders
WHERE  NOT EXISTS (SELECT NAME
                   FROM   total_count
                   WHERE  total_count.NAME = orders.NAME) 