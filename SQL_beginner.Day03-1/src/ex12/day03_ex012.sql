INSERT INTO person_order
            (id,
             person_id,
             menu_id,
             order_date)
SELECT Generate_series(Max(id) + 1, Max(id)
                                    + (SELECT Count(*)
                                       FROM   person)),
       Generate_series((SELECT Min(id)
                        FROM   person), (SELECT Max(id)
                                         FROM   person)),
       (SELECT id
        FROM   menu
        WHERE  pizza_name = 'greek pizza'),
       '2022-02-24'
FROM   person_order; 