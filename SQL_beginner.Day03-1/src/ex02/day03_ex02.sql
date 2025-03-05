-- те же самые два запроса с подзапросами из 1 задания просто немного изменённые
SELECT pizza_name,
       price,
       (SELECT NAME
        FROM   pizzeria
        WHERE  pizzeria.id = pizzeria_id) AS pizzeria_name
FROM   menu
WHERE  NOT EXISTS (SELECT menu_id
                   FROM   person_order
                   WHERE  menu.id = menu_id)
ORDER  BY pizza_name,
          price;

SELECT pizza_name,
       price,
       (SELECT NAME
        FROM   pizzeria
        WHERE  pizzeria.id = pizzeria_id) AS pizzeria_name
FROM   menu
WHERE  id NOT IN (SELECT menu_id
                  FROM   person_order)
ORDER  BY pizza_name,
          price; 