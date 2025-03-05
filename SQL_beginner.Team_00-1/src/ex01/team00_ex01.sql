
-- та же самая рекурсия и запрос, просто другая сортировка
WITH recursive count_total_cost AS
(
       SELECT n.id,
              n.point1,
              n.point2,
              n.cost,
              n.cost AS total_cost,
              1      AS level,
              '{' || n.point1
              || ', ' || n.point2
              || ', ' AS tour
       FROM   nodes n
       WHERE  point1 = 'a'
       UNION ALL
       SELECT n.id,
              n.point1,
              n.point2,
              n.cost,
              prev.total_cost + n.cost AS total_cost,
              prev.level      + 1      AS level,
              CASE
                     WHEN level < 3 THEN 
                        prev.tour || n.point2 || ', '
                     WHEN level = 3 THEN 
                        prev.tour || n.point2 || '}'
              END AS tour
       FROM   nodes n
       JOIN   count_total_cost prev
       ON     n.point1 = prev.point2
       AND    ((
                            level < 3
                     AND    NOT tour LIKE 
                     '%' || n.point2 || '%'
                     )
              OR     (
                            level = 3
                     AND    n.point2 = 'a')) ),
all_ways AS
(
         SELECT   total_cost,
                  tour
         FROM     count_total_cost
         WHERE    level = 4
         ORDER BY total_cost,
                  tour
)

SELECT *
FROM   all_ways;
