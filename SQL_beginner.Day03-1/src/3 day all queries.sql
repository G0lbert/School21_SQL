select * from person;
select * from menu;
select * from pizzeria;
select * from person_visits;
select * from person_order;

-- 0
select pizza_name,	price,	( select pizzeria.name from pizzeria where pizzeria.id = person_visits.pizzeria_id ) as pizzeria_name,	visit_date from person_visits
	join menu on menu.pizzeria_id = person_visits.pizzeria_id
where person_id = (select id from person where name = 'Kate') and price between 800 and 1000
order by pizza_name, price,	pizzeria_name, visit_date;


-- 1
select id as menu_id from menu
where not exists (select menu_id from person_order where menu.id = menu_id)
order by menu_id;

select id as menu_id from menu
where id not in (select menu_id from person_order)
order by menu_id;

-- 2
select pizza_name, price, (select name from pizzeria where pizzeria.id = pizzeria_id) as pizzeria_name from menu
where not exists (select menu_id from person_order where menu.id = menu_id)
order by pizza_name, price;

select  pizza_name, price, (select name from pizzeria where pizzeria.id = pizzeria_id) as pizzeria_name from menu
where id not in (select menu_id from person_order)
order by pizza_name, price;


-- 3
with 
	men_favorite_pizzerias as (
	select (select name from pizzeria where pizzeria_id = pizzeria.id),count(pizzeria_id) as men_visits from person_visits
	join person on person.id = person_id
	where gender = 'male'
	group by pizzeria_id
),
	women_favorite_pizzerias as (
	select (select name from pizzeria where pizzeria_id = pizzeria.id),count(pizzeria_id) as women_visits from person_visits
	join person on person.id = person_id
	where gender = 'female'
	group by pizzeria_id
	 )
	
select m.name as pizzeria_name from men_favorite_pizzerias m
	join women_favorite_pizzerias w on m.name = w.name and men_visits != women_visits 
order by pizzeria_name;

-- 4
with 
	men_favorite_pizzerias as (
	select (select name from pizzeria where pizzeria_id = pizzeria.id) from person_order
	join person on person.id = person_id
	join menu on menu_id = menu.id
	where gender = 'male'
),
	women_favorite_pizzerias as (
	select (select name from pizzeria where pizzeria_id = pizzeria.id) from person_order
	join person on person.id = person_id
	join menu on menu_id = menu.id
	where gender = 'female'
),
	men_except as (
select name as pizzeria_name from men_favorite_pizzerias 
	except
select name from women_favorite_pizzerias
),
	women_except as (
select name as pizzeria_name from women_favorite_pizzerias 
	except
select name from men_favorite_pizzerias
)
	
select pizzeria_name from men_except
	union
select pizzeria_name from women_except
order by pizzeria_name;


-- 5
with visits as 
	(select * from person_visits 
	where exists 
		( select * from person
		where person_id = person.id and name = 'Andrey')),
	 orders as
	 ( select * from person_order 
	where exists 
		( select * from person
		where person_id = person.id and name = 'Andrey')
	 ),
	 pizzerias as
	 ( select pizzeria_id from menu
	 where id in (select menu_id from orders))

select (select name from pizzeria where pizzeria_id = pizzeria.id) as pizzeria_name 
	from ( select * from visits)
where pizzeria_id not in (select * from pizzerias)
order by pizzeria_name;

-- 6
with new_menu as (
	select menu.id, name, pizza_name, price from pizzeria
	join menu on pizzeria.id = pizzeria_id
)
select n1.pizza_name as pizza_name, n1.name as pizzeria_name_1, n2.name as pizzeria_name_2, n1.price from new_menu n1
	join new_menu n2 on n1.id > n2.id and n1.price = n2.price and n1.name!= n2.name and n1.pizza_name = n2.pizza_name
order by pizza_name; 

-- 7
delete from menu where id = 19
INSERT INTO menu values (19, 2,'greek pizza', 800);

-- 8
delete from menu where id = 20
WITH new_value AS (
    SELECT max(id) + 1 AS max_id, pizzeria_id
    FROM menu
    WHERE pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos')
    GROUP BY pizzeria_id
)
INSERT INTO menu 
SELECT max_id, pizzeria_id, 'sicilian pizza', 900
FROM new_value;

-- 9
delete from person_visits where id = 20;
delete from person_visits where id = 21;
INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
VALUES ((SELECT MAX(id) + 1 FROM person_visits),
        (SELECT id FROM person WHERE name = 'Denis'),
        (SELECT id FROM pizzeria WHERE name = 'Dominos'),'2022-02-24');
INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
VALUES ((SELECT MAX(id) + 1 FROM person_visits),
        (SELECT id FROM person WHERE name = 'Irina'),
        (SELECT id FROM pizzeria WHERE name = 'Dominos'), '2022-02-24');

-- 10
delete from person_order where id = 21;
delete from person_order where id = 22;
INSERT INTO person_order
VALUES ((SELECT MAX(id) + 1 FROM person_order),
        (SELECT id FROM person WHERE name = 'Denis'),
        (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),'2022-02-24');
INSERT INTO person_order
VALUES ((SELECT MAX(id) + 1 FROM person_order),
        (SELECT id FROM person WHERE name = 'Irina'),
        (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'), '2022-02-24');

-- 11
delete from menu where id = 19;
INSERT INTO menu values (19, 2,'greek pizza', 800);
update menu 
	set price=price*0.9
	where pizza_name = 'greek pizza';

-- 12 и 13
INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT generate_series(max(id)+1, max(id)+(select count(*) from person)), 
	generate_series((select min(id) from person),(select max(id) from person)),
	(select id from menu where pizza_name='greek pizza'),  
	'2022-02-24' 
	from person_order;

delete from person_order where order_date = '2022-02-24';
delete from menu where pizza_name = 'greek pizza';