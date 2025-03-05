WITH men_favorite_pizzerias
     AS (SELECT (SELECT NAME
                 FROM   pizzeria
                 WHERE  pizzeria_id = pizzeria.id)
         FROM   person_order
                JOIN person
                  ON person.id = person_id
                JOIN menu
                  ON menu_id = menu.id
         WHERE  gender = 'male'),
     women_favorite_pizzerias
     AS (SELECT (SELECT NAME
                 FROM   pizzeria
                 WHERE  pizzeria_id = pizzeria.id)
         FROM   person_order
                JOIN person
                  ON person.id = person_id
                JOIN menu
                  ON menu_id = menu.id
         WHERE  gender = 'female'),
     men_except
     AS (SELECT NAME AS pizzeria_name
         FROM   men_favorite_pizzerias
         EXCEPT
         SELECT NAME
         FROM   women_favorite_pizzerias),
     women_except
     AS (SELECT NAME AS pizzeria_name
         FROM   women_favorite_pizzerias
         EXCEPT
         SELECT NAME
         FROM   men_favorite_pizzerias) SELECT pizzeria_name
FROM   men_except
UNION
SELECT pizzeria_name
FROM   women_except
ORDER  BY pizzeria_name; 