-- 1 сессия
begin;
update pizzeria 
	set rating = 5
	where name = 'Pizza Hut';

select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
select * from pizzeria where name = 'Pizza Hut';

-- 1 сесссия
commit;
select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
select * from pizzeria where name = 'Pizza Hut';
