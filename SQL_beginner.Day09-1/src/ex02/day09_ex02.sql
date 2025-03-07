create or replace function fnc_trg_person_delete_audit() returns trigger as
$$
begin
	if tg_op = 'DELETE' then 
	insert into person_audit 
	values (current_timestamp, 'D', old.id, old.name, old.age, old.gender, old.address);
	end if;
	return null;
end;
$$
language plpgsql;

-- drop trigger trg_person_delete_audit on person;
create or replace trigger trg_person_delete_audit
	after delete on person
	for each row
	execute procedure fnc_trg_person_delete_audit();


DELETE FROM person WHERE id = 10;


select * from person_audit;
