select * from person;
select * from pizzeria;
select * from menu;
select * from person_order;
select * from person_visits;

-- отключение индексов, чтобы постгрес работал без них
set enable_seqscan = off;

-- 0
create index idx_person_visits_person_id on person_visits(person_id);
create index idx_person_visits_pizzeria_id on person_visits(pizzeria_id);
create index idx_person_order_person_id on person_order(person_id);
create index idx_person_order_menu_id on person_order(menu_id);
create index idx_menu_pizzeria_id on menu(pizzeria_id);

-- 1

-- отключение индексов, чтобы постгрес работал без них
set enable_seqscan = off;

explain analyze
select pizza_name, pizzeria.name as pizzeria_name from menu
	join pizzeria on pizzeria.id = pizzeria_id;

-- 2
create index idx_person_name on person using btree (upper(name));
explain analyze
 select * from person where upper(name) = 'DENIS';

-- 3
create index idx_person_order_multi on person_order using btree (person_id, menu_id);
explain analyze
	SELECT person_id, menu_id,order_date
	FROM person_order
	WHERE person_id = 8 AND menu_id = 19;

-- 4
drop index idx_menu_unique;
create unique index idx_menu_unique on menu using btree (pizzeria_id, pizza_name);
explain analyze
	SELECT *
	FROM menu
	WHERE pizzeria_id = 1 AND pizza_name = 'sausage pizza';

-- 5
create index idx_person_order_order_date on person_order using btree (person_id, menu_id)
where order_date = '01.01.2022';
explain analyze
	SELECT *
	FROM person_order
	WHERE order_date = '01.01.2022';

-- 6 
drop index idx_1;
create index idx_1 on pizzeria (rating);
explain analyze
	SELECT
	    m.pizza_name AS pizza_name,
	    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
	FROM  menu m
	INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
	ORDER BY 1,2;