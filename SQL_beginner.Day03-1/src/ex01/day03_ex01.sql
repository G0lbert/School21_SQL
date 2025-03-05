-- два одинаковых запроса с подзапросами - этот с NOT EXISTS
SELECT id AS menu_id
FROM   menu
WHERE  NOT EXISTS (SELECT menu_id
                   FROM   person_order
                   WHERE  menu.id = menu_id)
ORDER  BY menu_id;

-- этот с NOT IN
SELECT id AS menu_id
FROM   menu
WHERE  id NOT IN (SELECT menu_id
                  FROM   person_order)
ORDER  BY menu_id; 