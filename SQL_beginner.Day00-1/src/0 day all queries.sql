select * from person;
select * from pizzeria;
select * from person_visits;
select * from person_order;

-- 1
select name, age from person
where address = 'Kazan' and gender = 'female'
order by name;

-- 2
select name, rating from pizzeria
where 3.5 <= rating and rating <= 5
order by rating; 

select name, rating from pizzeria
where rating between 3.5 and 5
order by rating; 

-- 3
select person_id from person_visits
where visit_date between '06.01.2022' and '09.01.2022' or pizzeria_id = 2
group by person_id
order by person_id desc;

select distinct person_id from person_visits
where visit_date between '06.01.2022' and '09.01.2022' or pizzeria_id = 2
order by person_id desc;

-- 4
select concat(name, ' (age:', age, ',gender:''', gender, ''',address:''', address, ''')') 
as "person_information" 
from person
order by "person_information";

--5 
select name
from person, (select person_id from person_order where ( menu_id = 13 or menu_id = 14 or menu_id = 18) 
	and order_date = '07.01.2022')
where id = person_id;

select name
from person
where id in  (select person_id from person_order where ( menu_id = 13 or menu_id = 14 or menu_id = 18) 
	and order_date = '07.01.2022');

-- 6
select name,
	case
	when name = 'Denis' then true
	else false
	end as "check_name"
from person, (select person_id from person_order where ( menu_id = 13 or menu_id = 14 or menu_id = 18) 
	and order_date = '07.01.2022')
where id = person_id;

select id, name, 
	case
	when age between 10 and 20 then 'interval #1'
	when age > 20 and age < 24 then 'interval #2'	
	else 'interval #3'
	end as "interval_info"
from person
order by "interval_info";

select * from person_order 
where mod(id, 2) = 0
order by id asc;

select person.name AS person_name, pizzeria.name AS pizzeria_name from person, 
(select person_id, pizzeria_id 
from person_visits 
where visit_date between '07.01.2022' and '09.01.2022'), pizzeria
where person.id = person_id and pizzeria.id = pizzeria_id
order by person_name asc, pizzeria_name desc;