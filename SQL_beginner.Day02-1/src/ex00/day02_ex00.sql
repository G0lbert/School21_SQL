-- разрешённый вариант через join-ы ( по сути реализация аналога not in-а )
SELECT name, rating FROM pizzeria
	LEFT JOIN person_visits ON pizzeria.id =pizzeria_id
	WHERE pizzeria_id IS NULL;
    
-- запрещённый вариант из-за IN
SELECT name, rating 
FROM pizzeria
WHERE id not in 
( SELECT pizzeria_id FROM person_visits );