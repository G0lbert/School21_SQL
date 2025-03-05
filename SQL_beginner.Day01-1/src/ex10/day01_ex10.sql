SELECT ( SELECT name FROM person WHERE person_id =id ) AS person_name, 
pizza_name, pizzeria.name AS pizzeria_name FROM person_order
	JOIN menu ON menu.id = menu_id
	JOIN pizzeria ON pizzeria_id = pizzeria.id
ORDER BY person_name, pizza_name, pizzeria_name;