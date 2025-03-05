select * from person;
select * from menu;
select * from pizzeria;
select * from person_visits;
select * from person_order;


-- 0
select name, rating from pizzeria
	left join person_visits on pizzeria.id =pizzeria_id
	where pizzeria_id is null;

select name, rating from pizzeria
where id not in ( select pizzeria_id from person_visits );

-- 1
select generate_series::date as missing_date from generate_series('01.01.2022'::date, '10.01.2022'::date, '1 day')
	left join person_visits on generate_series = visit_date and (person_id = 1 or person_id = 2)
	where visit_date is null
order by missing_date asc;

SELECT missing_date::date
FROM generate_series('2022-01-01'::date, '2022-01-10', '1 day') as missing_date
LEFT JOIN (SELECT * FROM person_visits pv
		   WHERE (pv.person_id = '1' OR pv.person_id = '2')
		   AND (pv.visit_date BETWEEN '2022-01-01' AND '2022-01-10')
) t1 ON (missing_date = t1.visit_date)
WHERE visit_date is null
ORDER BY missing_date asc;

-- 2

-- select ( select name from person where person.id = person_id ) as person_name, 
-- 	visit_date, ( select name from pizzeria where id = pizzeria_id) as pizzeria_name from person_visits;

select coalesce(person.name, '-') as person_name, visit_date, coalesce(pizzeria.name, '-') as pizzeria_name from person
	full join ( select * from person_visits where visit_date between '01.01.2022' and '03.01.2022') on person.id = person_id
	full join pizzeria on pizzeria_id = pizzeria.id 
-- where visit_date between '01.01.2022' and '03.01.2022'
order by person_name, visit_date, pizzeria_name;

-- 3
with "day generator" as (
select generate_series::date as missing_date from generate_series('01.01.2022'::date, '10.01.2022'::date, '1 day')
)

select missing_date from "day generator"
	left join person_visits on missing_date = visit_date and (person_id = 1 or person_id = 2)
	where visit_date is null
order by missing_date asc;

-- 4
select pizza_name, (select name from pizzeria where pizzeria.id = pizzeria_id) as pizzeria_name, price from menu
where pizza_name = 'mushroom pizza' or pizza_name = 'pepperoni pizza'
order by pizza_name, pizzeria_name;

-- 5
select name from person
where age > 25 and gender = 'female'
order by name;

-- 6
with find_person as (select id from person where name = 'Denis' or name = 'Anna'),
	 find_persons_order as ( select menu_id from person_order where person_id in (select * from find_person))
select pizza_name, (select pizzeria.name from pizzeria where pizzeria.id = pizzeria_id ) as pizzeria_name from menu
where id in ( select * from find_persons_order )
order by pizza_name, pizzeria_name;

select pizza_name, (select pizzeria.name from pizzeria where pizzeria.id = pizzeria_id ) as pizzeria_name from menu
where id in ( select menu_id from person_order where person_id in ( select id from person where name = 'Denis' or name = 'Anna' ) )
order by pizza_name, pizzeria_name;

-- 7
with find_person as (select id from person where name = 'Dmitriy'),
	 find_low_price_pizza as (select pizzeria_id from menu where price < 800 )
select (select pizzeria.name from pizzeria where pizzeria.id = pizzeria_id ) as pizzeria_name from person_visits
where visit_date = '08.01.2022' and person_id = (select * from find_person) and pizzeria_id in ( select * from find_low_price_pizza );

-- 8
with find_person as (select name, id from person where gender = 'male' and ( address = 'Moscow' or address = 'Samara')),
	 find_pizza as (select id from menu where pizza_name = 'pepperoni pizza' or pizza_name = 'mushroom pizza'),
	 find_person_id as (select person_id from person_order where menu_id in (select * from find_pizza))
	
select name from find_person 
	join find_person_id on find_person.id = person_id
group by name
order by name desc;

-- 9
with find_person as (select name, id from person where gender = 'female'),
	 find_pizza as (select id from menu where pizza_name = 'pepperoni pizza' or pizza_name = 'cheese pizza'),
	 find_person_id as (select person_id, count(person_id) from person_order where menu_id in (select * from find_pizza) group by person_id having count(person_id) >=2 )

select name from find_person 
	join find_person_id on find_person.id = person_id
group by name
order by name asc;

-- 10
select p1.name as person_name1, p2.name as person_name2, p1.address as common_address from person p1
	join person p2 on p1.address = p2.address and p1.id > p2.id
order by 1,2,3;
