WITH visits AS
(
         SELECT   NAME,
                  Count(pizzeria_id) AS count,
                  'visit'            AS action_type
         FROM     person_visits
         JOIN     pizzeria
         ON       pizzeria.id = person_visits.pizzeria_id
         GROUP BY NAME,
                  action_type
         ORDER BY 2 DESC limit 3 ), 
     orders AS
(
         SELECT   NAME,
                  Count(pizzeria_id) AS count,
                  'order'            AS action_type
         FROM     person_order
         JOIN     menu
         ON       menu.id = menu_id
         JOIN     pizzeria
         ON       pizzeria.id = menu.pizzeria_id
         GROUP BY NAME,
                  action_type
         ORDER BY 2 DESC limit 3 )
         
SELECT *
FROM   orders
UNION ALL
SELECT   *
FROM     visits
ORDER BY action_type,
         count DESC;