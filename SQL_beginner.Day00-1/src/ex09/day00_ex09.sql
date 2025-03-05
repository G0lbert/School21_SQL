-- без join-ов памяти конечно на создание левых таабличек тратится мама не горюй....
SELECT person.name AS person_name, 
pizzeria.name AS pizzeria_name FROM person,
(SELECT person_id, pizzeria_id
FROM person_visits
WHERE visit_date BETWEEN '07.01.2022' AND '09.01.2022'), pizzeria
WHERE person.id = person_id AND pizzeria.id = pizzeria_id
ORDER BY person_name ASC, pizzeria_name DESC;