SELECT COALESCE(person.NAME, '-')   AS person_name,
       visit_date,
       COALESCE(pizzeria.NAME, '-') AS pizzeria_name
FROM   person
       FULL JOIN (SELECT *
                  FROM   person_visits
                  WHERE  visit_date BETWEEN '01.01.2022' AND '03.01.2022')
              ON person.id = person_id
       FULL JOIN pizzeria
              ON pizzeria_id = pizzeria.id
ORDER  BY person_name,
          visit_date,
          pizzeria_name; 