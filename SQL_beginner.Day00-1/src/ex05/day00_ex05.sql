-- это запрос по корякски, но который ожидают авторы задания 
SELECT name
FROM person, 
(SELECT person_id FROM person_order 
WHERE ( menu_id = 13 OR menu_id = 14 OR menu_id = 18)
	AND order_date = '07.01.2022')
WHERE id = person_id;

-- это нормальный запрос, но почему-то так запрещено из-за IN
SELECT name
FROM person
WHERE id in  
(SELECT person_id FROM person_order 
WHERE ( menu_id = 13 OR menu_id = 14 OR menu_id = 18)
	AND order_date = '07.01.2022');