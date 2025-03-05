DROP TABLE IF EXISTS nodes;

CREATE TABLE IF NOT EXISTS nodes 
( 
    id int PRIMARY KEY, 
    point1 char NOT NULL, 
    point2 char NOT NULL, 
    cost integer NOT NULL 
);
    
INSERT INTO nodes VALUES
            ( 1, 'a', 'b',  10 ),
            ( 2, 'b', 'a', 10 ),
            ( 3, 'a', 'c', 15 ),
            ( 4, 'c', 'a', 15 ),
            ( 5, 'a', 'd', 20 ),
            ( 6, 'd', 'a', 20 ),
            ( 7, 'b', 'c', 35 ),
            ( 8, 'c', 'b', 35 ),
            ( 9, 'b', 'd', 25 ),
            (10, 'd', 'b', 25 ),
            (11, 'c', 'd', 30 ),
            (12, 'd', 'c', 30 )
ON CONFLICT DO NOTHING;

SELECT * 
FROM   nodes;

-- сам обход графа через рекурсию
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
                     AND    NOT tour 
                     LIKE '%' || n.point2 || '%' )
              OR     (
                            level = 3
                     AND    n.point2 = 'a')) ), find_min AS
(
       SELECT min(total_cost)
       FROM   count_total_cost
       WHERE  level = 4 ), cheapest_way AS
(
         SELECT   total_cost,
                  tour
         FROM     count_total_cost
         WHERE    level = 4
         AND      total_cost =
                  (
                         SELECT *
                         FROM   find_min )
         ORDER BY total_cost,
                  tour )

SELECT *
FROM   cheapest_way;