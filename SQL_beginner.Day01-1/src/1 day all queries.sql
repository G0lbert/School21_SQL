select * from person;
select * from menu;
select * from pizzeria;
select * from person_visits;
select * from person_order;

-- 0 
select id as object_id, pizza_name as  object_name from menu
union all
select id, name from person
order by object_id, object_name;   

-- 1
select pizza_name as  object_name from menu
union all
select name from person
order by object_name;  

-- 2
select pizza_name from menu
union
select pizza_name from menu	
order by pizza_name desc;

-- 3
select order_date as action_date, person_id as person_id   from person_order
	intersect
select visit_date, person_id from person_visits
order by action_date asc, person_id  desc;

-- 4
select person_id  from person_order
where order_date = '07.01.2022'
	except all
select person_id from person_visits
where visit_date = '07.01.2022';

-- 5
select person.id AS "person.id", person.name AS "person.name", age, gender, address,
       pizzeria.id AS "pizzeria.id", pizzeria.name AS "pizzeria.name", rating 
from person, pizzeria
order by person.id, pizzeria.id;

-- 6
select order_date as action_date, (select name from person where person.id = person_id) as person_name from person_order
	intersect
select visit_date, (select name from person where person.id = person_id) as person_name from person_visits
order by action_date asc, person_name  desc;

-- 7
select order_date, concat(name, ' (age:', age ,')') as person_information from person_order
	join person on person_id = person.id
order by order_date, person_information;

-- 8
select order_date, concat(name, ' (age:', age ,')') as person_information from person_order
	natural join (select id as person_id, name, age from person)
order by order_date, person_information; 

-- 9
select name as not_visited_pizzeria from pizzeria
where id not in (select pizzeria_id from person_visits );

select name as not_visited_pizzeria from pizzeria
where not exists (select pizzeria_id from person_visits where pizzeria.id = pizzeria_id);


-- 10
select ( select name from person where person_id =id ) as person_name, pizza_name, pizzeria.name as pizzeria_name from person_order
	join menu on menu.id = menu_id
	join pizzeria on pizzeria_id = pizzeria.id
order by person_name, pizza_name, pizzeria_name;
