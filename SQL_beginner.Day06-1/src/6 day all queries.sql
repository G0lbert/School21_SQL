select * from person;
select * from pizzeria;
select * from menu;
select * from person_order;
select * from person_visits;

-- 0
create table if not exists person_discounts (
	id bigint primary key,
	person_id bigint not null,
	pizzeria_id bigint not null,
	discount numeric not null,
	constraint fk_person_discounts_person_id foreign key (person_id) references person(id),
	constraint fk_person_discounts_pizzeria_id foreign key (pizzeria_id) references pizzeria(id)
);

-- 1
insert into person_discounts 
select ROW_NUMBER( ) OVER ( ) AS id, person_id, pizzeria_id,
case when count(person_id) = 1 then 10.5
	 when count(person_id) = 2 then 22
	 else 30
end as discount
from person_order
join menu on menu_id = menu.id
group by person_id, pizzeria_id;

select * from person_discounts;
	
-- 2
select person.name, pizza_name, price, round(price*(100-discount)/100) as discount_price, 
pizzeria.name as pizzeria_name from person_discounts
	join person on person.id = person_discounts.person_id
	join pizzeria on pizzeria.id = pizzeria_id
	join person_order on person_order.person_id = person_discounts.person_id 
	join menu on menu.id = menu_id and menu.pizzeria_id = person_discounts.pizzeria_id 
order by person.name, pizza_name;

-- 3
create unique index idx_person_discounts_unique on person_discounts(person_id, pizzeria_id);
set enable_seqscan = off;
explain analyze
	select person.name, pizza_name, price, round(price*(100-discount)/100) as discount_price, 
pizzeria.name as pizzeria_name from person_discounts
	join person on person.id = person_discounts.person_id
	join pizzeria on pizzeria.id = pizzeria_id
	join person_order on person_order.person_id = person_discounts.person_id 
	join menu on menu.id = menu_id and menu.pizzeria_id = person_discounts.pizzeria_id 
order by person.name, pizza_name;

-- 4
alter table person_discounts
	add constraint ch_nn_person_id check(person_id is not null),
	add constraint ch_nn_pizzeria_id check(pizzeria_id is not null),
	add constraint ch_nn_discount check(discount is not null),
	alter column discount set default 0,
	add constraint ch_range_discount check(discount between 0 and 100);

-- 5

comment on table person_discounts is 'This table provides some information about person''s discount in each pizzeria';
comment on column person_discounts.id is 'PK identificator for each row';
comment on column person_discounts.person_id is 'FK identificator for person';
comment on column person_discounts.pizzeria_id is 'FK identificator for pizzeria where was  ordered pizza by specific person';
comment on column person_discounts.discount is 'field with amount of discount on pizza in percents';

-- 6
create sequence seq_person_discounts
start with 1
increment by 1;

alter table person_discounts alter column id set default nextval('seq_person_discounts');
select setval('seq_person_discounts',(select count(*)+1 from person_discounts)); 
-- обновляем значение последовательности seq_person_discounts 

select *
from pg_sequences
where sequencename = 'seq_person_discounts'
