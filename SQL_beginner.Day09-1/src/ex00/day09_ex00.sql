create table if not exists person_audit (
	created timestamp with time zone default current_timestamp not null,
	type_event char(1) default 'I' not null,
	row_id bigint not null,
	name varchar,
	age integer,
	gender varchar,
	address varchar,
	constraint ch_type_event check (type_event in ('I', 'U', 'D'))
);

create or replace function fnc_trg_person_insert_audit() returns trigger as
$$
begin
	if tg_op  = 'INSERT' then 
	insert into person_audit 
	values (current_timestamp, 'I', new.id, new.name, new.age, new.gender, new.address);
	return new;
	end if;
	return null;
end;
$$
language plpgsql;

-- drop trigger trg_person_insert_audit on person;
create or replace trigger trg_person_insert_audit
	after insert on person
	for each row
	execute procedure fnc_trg_person_insert_audit();

delete from person where id  = 10;
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');

select * from person_audit;
