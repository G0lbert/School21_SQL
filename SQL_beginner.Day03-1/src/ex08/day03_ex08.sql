WITH new_values
     AS (SELECT Max(id) + 1 AS max_id,
                pizzeria_id
         FROM   menu
         WHERE  pizzeria_id = (SELECT id
                               FROM   pizzeria
                               WHERE  NAME = 'Dominos')
         GROUP  BY pizzeria_id)
INSERT INTO menu
SELECT max_id,
       pizzeria_id,
       'sicilian pizza',
       900
FROM   new_values; 