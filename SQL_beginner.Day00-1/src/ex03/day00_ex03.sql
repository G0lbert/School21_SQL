SELECT person_id FROM person_visits
WHERE visit_date BETWEEN '06.01.2022' AND '09.01.2022' OR pizzeria_id = 2
GROUP BY person_id
ORDER BY person_id DESC;

SELECT DISTINCT person_id FROM person_visits
WHERE visit_date BETWEEN '06.01.2022' AND '09.01.2022' OR pizzeria_id = 2
ORDER BY person_id DESC;