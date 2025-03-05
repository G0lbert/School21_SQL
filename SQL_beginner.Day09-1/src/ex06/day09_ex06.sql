CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date 
(pperson varchar DEFAULT 'Dmitriy', 
pprice numeric DEFAULT 500, 
pdate date DEFAULT '08.01.2022')
returns TABLE (NAME varchar) AS 
$$
BEGIN
RETURN query
SELECT pizzeria.NAME
  FROM   person_visits
  JOIN   pizzeria
  ON     pizzeria.id = person_visits.pizzeria_id
  JOIN   person_order
  ON     person_order.person_id = person_visits.person_id
  JOIN   person
  ON     person.id = person_order.person_id
  AND    person.id = person_visits.person_id
  JOIN   menu
  ON     menu.pizzeria_id = pizzeria.id
  AND    menu.id = person_order.menu_id
  WHERE  order_date = pdate
  AND    menu.price < pprice
  AND    person.NAME = pperson;
  END;
  $$ 
  language plpgsql;
  
SELECT * FROM   Fnc_person_visits_and_eats_on_date(pprice := 800);
SELECT * FROM   Fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');