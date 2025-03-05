INSERT INTO person_visits
SELECT Max(id)+1,
       (
              SELECT id
              FROM   person
              WHERE  NAME = 'Dmitriy'),
       (
              SELECT id
              FROM   pizzeria
              WHERE  NAME = 'DoDo Pizza'),
       '2022-01-08'
FROM   person_visits;

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;