SELECT pizza_name,
       (SELECT NAME
        FROM   pizzeria
        WHERE  pizzeria.id = pizzeria_id
        ) AS pizzeria_name, price
FROM   menu
WHERE  pizza_name = 'mushroom pizza'
        OR pizza_name = 'pepperoni pizza'
ORDER  BY pizza_name,
          pizzeria_name; 