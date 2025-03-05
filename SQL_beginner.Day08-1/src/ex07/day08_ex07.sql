-- 1 сессия
set session characteristics as transaction isolation level read uncommitted;
SHOW TRANSACTION ISOLATION LEVEL;

-- 2 сессия
set session characteristics as transaction isolation level read uncommitted;
SHOW TRANSACTION ISOLATION LEVEL;

-- 1 сессия
begin;

-- 2 сессия
begin;

-- 1 сессия
update pizzeria
	set rating = 1.0
	where id = 1;

-- 2 сессия
update pizzeria
	set rating = 2.0
	where id = 2;
commit;

-- 1 сессия
update pizzeria
	set rating = 1.0
	where id = 2;

-- 2 сессия
update pizzeria
	set rating = 2.0
	where id = 1;

-- 1 сессия 
commit;
-- 2 сессия
commit;