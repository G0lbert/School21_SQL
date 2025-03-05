-- 1 сессия
set session characteristics as transaction isolation level serializable;
SHOW TRANSACTION ISOLATION LEVEL;

-- 2 сессия
set session characteristics as transaction isolation level read serializable;
SHOW TRANSACTION ISOLATION LEVEL;

-- 1 сессия
begin;

-- 2 сессия
begin;

-- 1 сессия
select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
update pizzeria
	set rating = 3.0
	where name = 'Pizza Hut';
commit;

-- 1 сессия
select * from pizzeria where name = 'Pizza Hut';
commit;
select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
select * from pizzeria where name = 'Pizza Hut';
