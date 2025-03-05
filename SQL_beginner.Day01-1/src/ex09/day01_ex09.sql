-- подзапрос в части WHERE с использованием IN
SELECT name AS not_visited_pizzeria FROM pizzeria
WHERE id not in (SELECT pizzeria_id FROM person_visits );

-- подзапрос в части WHERE с использованием EXISTS
SELECT name AS not_visited_pizzeria FROM pizzeria
WHERE NOT EXISTS 
(SELECT pizzeria_id FROM person_visits WHERE pizzeria.id = pizzeria_id);