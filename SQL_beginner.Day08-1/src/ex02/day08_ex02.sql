-- 1 сессия
set session characteristics as transaction isolation level repeatable read;
SHOW TRANSACTION ISOLATION LEVEL;

-- 2 сессия
set session characteristics as transaction isolation level repeatable read;
SHOW TRANSACTION ISOLATION LEVEL;

-- 1 сессия
begin;
select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
begin;
select * from pizzeria where name = 'Pizza Hut';

-- 1 сессия
update pizzeria
	set rating = 4
	where name = 'Pizza Hut';

-- 2 сессия
update pizzeria
	set rating = 3.6
	where name = 'Pizza Hut';

-- 1 сессия
commit;

-- 2 сессия
commit;

-- 1 сессия
select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
select * from pizzeria where name = 'Pizza Hut';
