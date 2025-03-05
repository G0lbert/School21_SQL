
drop table if exists nodes;
create table if not exists nodes 
(
	id int primary key,
	point1 char not null,
	point2 char not null,
	cost integer not null
);

insert into nodes  values 
	(1, 'a', 'b',  10),
	(2, 'b', 'a', 10),
	(3, 'a', 'c', 15),
	(4, 'c', 'a', 15),
	(5, 'a', 'd', 20),
	(6, 'd', 'a', 20),
	(7, 'b', 'c', 35),
	(8, 'c', 'b', 35),
	(9, 'b', 'd', 25),
	(10, 'd', 'b', 25),
	(11, 'c', 'd', 30),
	(12, 'd', 'c', 30)
ON CONFLICT DO NOTHING;

select * from nodes;

-- сам обход графа через рекурсию

with recursive 
	count_total_cost as (
	select n.id, n.point1, n.point2, n.cost,
	n.cost as total_cost,
	1 as level, '{' || n.point1  || ', ' || n.point2 || ', ' as tour
	from nodes n
	where point1 = 'a'
		union all
	select n.id, n.point1, n.point2, n.cost, 
	prev.total_cost + n.cost as total_cost,
	prev.level + 1 as level, 
	case 
	when level < 3  then prev.tour || n.point2 || ', '
	when level = 3 then prev.tour || n.point2 || '}'
	end  as tour
	from nodes n
	join count_total_cost prev
	on n.point1 = prev.point2 and ((level < 3 and 
	not tour like '%' || n.point2  || '%') or ( level = 3 and n.point2  = 'a'))
),
	find_min as (
	select min(total_cost) 
	from count_total_cost 
	where level = 4
	),
	cheapest_way as(
	select total_cost, tour
	from count_total_cost 
	where level = 4 and total_cost = ( select * from find_min )
	order by total_cost, tour
)

select * from cheapest_way;



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