SELECT NAME,
       Count(menu_id)    AS count_of_orders,
       Round(Avg(price)) AS average_price,
       Max(price)        AS max_price,
       Min(price)        AS min_price
FROM   person_order
       JOIN menu
         ON menu_id = menu.id
       JOIN pizzeria
         ON pizzeria.id = pizzeria_id
GROUP  BY NAME
ORDER  BY 1; 