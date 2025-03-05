SELECT name,
	CASE
	WHEN name = 'Denis' THEN TRUE
	ELSE FALSE
	END AS "check_name"
FROM person, 
(SELECT person_id FROM person_order 
WHERE ( menu_id = 13 OR menu_id = 14 OR menu_id = 18)
	AND order_date = '07.01.2022')
WHERE id = person_id;