INSERT INTO person_visits
            (id,
             person_id,
             pizzeria_id,
             visit_date)
VALUES      ((SELECT Max(id) + 1
              FROM   person_visits),
             (SELECT id
              FROM   person
              WHERE  NAME = 'Denis'),
             (SELECT id
              FROM   pizzeria
              WHERE  NAME = 'Dominos'),
             '2022-02-24');

INSERT INTO person_visits
            (id,
             person_id,
             pizzeria_id,
             visit_date)
VALUES      ((SELECT Max(id) + 1
              FROM   person_visits),
             (SELECT id
              FROM   person
              WHERE  NAME = 'Irina'),
             (SELECT id
              FROM   pizzeria
              WHERE  NAME = 'Dominos'),
             '2022-02-24'); 