SELECT person.NAME,
       pizza_name,
       price,
       ROUND(price * ( 100 - discount ) / 100) AS discount_price,
       pizzeria.NAME                           AS pizzeria_name
FROM   person_discounts
       JOIN person
         ON person.id = person_discounts.person_id
       JOIN pizzeria
         ON pizzeria.id = pizzeria_id
       JOIN person_order
         ON person_order.person_id = person_discounts.person_id
       JOIN menu
         ON menu.id = menu_id
            AND menu.pizzeria_id = person_discounts.pizzeria_id
ORDER  BY person.NAME,
          pizza_name; 