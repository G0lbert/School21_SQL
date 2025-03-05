WITH new_menu
     AS (SELECT menu.id,
                NAME,
                pizza_name,
                price
         FROM   pizzeria
                JOIN menu
                  ON pizzeria.id = pizzeria_id)
SELECT n1.pizza_name AS pizza_name,
       n1.NAME       AS pizzeria_name_1,
       n2.NAME       AS pizzeria_name_2,
       n1.price
FROM   new_menu n1
       JOIN new_menu n2
         ON n1.id > n2.id
            AND n1.price = n2.price
            AND n1.NAME != n2.NAME
            AND n1.pizza_name = n2.pizza_name
ORDER  BY pizza_name; 