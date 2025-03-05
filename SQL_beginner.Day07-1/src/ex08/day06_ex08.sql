SELECT address,
       pizzeria.NAME,
       Count(menu_id) AS count_of_orders
FROM   person_order
       JOIN person
         ON person.id = person_id
       JOIN menu
         ON menu.id = menu_id
       JOIN pizzeria
         ON pizzeria_id = pizzeria.id
GROUP  BY address,
          pizzeria.NAME
ORDER  BY address,
          pizzeria.NAME; 