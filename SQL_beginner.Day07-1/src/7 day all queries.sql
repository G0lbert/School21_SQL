select * from person;
select * from pizzeria;
select * from menu;
select * from person_order;
select * from person_visits;

-- 0
select person_id, count(pizzeria_id) as count_of_visits
from person_visits
group by person_id
order by 2 desc, 1 asc;

-- 1
select name, count(pizzeria_id) as count_of_visits
from person_visits
	join person on person_id = person.id
group by name
order by 2 desc, 1 asc
limit 4;

-- 2
with visits as (
	select name, count(pizzeria_id) as count, 'visit' as action_type from person_visits
	join pizzeria on pizzeria.id  = person_visits.pizzeria_id
	group by name, action_type
	order by 2 desc
	limit 3
),
	orders as (
	select name, count(pizzeria_id) as count, 'order' as action_type from person_order
	join menu on menu.id = menu_id
	join pizzeria on pizzeria.id  = menu.pizzeria_id
	group by name, action_type
	order by 2 desc
	limit 3
	)
select * from orders
	union all
select * from visits
order by action_type, count desc;


-- 3
with visits as (
	select name, count(pizzeria_id) as count, 'visit' as action_type from person_visits
	join pizzeria on pizzeria.id  = person_visits.pizzeria_id
	group by name, action_type
),
	orders as (
	select name, count(pizzeria_id) as count, 'order' as action_type from person_order
	join menu on menu.id = menu_id
	join pizzeria on pizzeria.id  = menu.pizzeria_id
	group by name, action_type
	),
	total_count as (
	select visits.name, visits.count + orders.count as total_count2 from visits
	join orders on visits.name = orders.name
	order by 2 desc, 1 asc
	)

select * from total_count
	union all
select name, count from visits
where not exists (select name from total_count where total_count.name = visits.name )
	union all
select name, count from orders
where not exists (select name from total_count where total_count.name = orders.name );

-- 4
select name, count(pizzeria_id) as count_of_visits
from person_visits
	join person on person.id = person_id
group by name
having count(pizzeria_id) > 3
order by 2 desc, 1 asc;

-- 5
select distinct name from person_order
	join person on person.id  = person_id
order by 1;

-- 6
select name, count(menu_id) as count_of_orders, 
	round(avg(price)) as average_price, 
	max(price) as max_price, 
	min(price) as min_price 
from person_order
	join menu on menu_id  = menu.id
	join pizzeria on pizzeria.id = pizzeria_id
group by name
order by 1;

-- 7
select round(avg(rating), 4) as global_rating from pizzeria;

-- 8 
select address, pizzeria.name, count(menu_id) as count_of_orders from person_order
	join person on person.id = person_id
	join menu on menu.id = menu_id
	join pizzeria on pizzeria_id = pizzeria.id
group by address, pizzeria.name
order by address, pizzeria.name;

-- 9
select address, round((max(age) - min(age)/max(age::numeric)), 2) as formula, round(avg(age), 2) as average, 
	case 
	when max(age) - min(age)/max(age::numeric) <= avg(age) then false
	else true
	end as comparison
from person
group by address
order by 1;


