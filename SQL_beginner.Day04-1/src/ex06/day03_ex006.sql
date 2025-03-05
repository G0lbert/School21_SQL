CREATE materialized VIEW mv_dmitriy_visits_and_eats AS WITH correct_data AS
(
       SELECT *
       FROM   person_visits
       WHERE  visit_date ='08.01.2022'
       AND    EXISTS
              (
                     SELECT *
                     FROM   person
                     WHERE  NAME = 'Dmitriy'
                     AND    id = person_id) )SELECT   NAME AS pizzeria_name
FROM     (
                SELECT *
                FROM   correct_data) AS correct
JOIN     person_order
ON       person_order.person_id = correct.person_id
JOIN     menu
ON       price < 800
AND      menu.pizzeria_id = correct.pizzeria_id
JOIN     pizzeria
ON       pizzeria.id = correct.pizzeria_id
GROUP BY pizzeria_name
ORDER BY pizzeria_name;