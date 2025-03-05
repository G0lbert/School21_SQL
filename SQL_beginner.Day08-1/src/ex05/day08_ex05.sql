-- 1 сессия
set session characteristics as transaction isolation level read committed;
SHOW TRANSACTION ISOLATION LEVEL;

-- 2 сессия
set session characteristics as transaction isolation level read committed;
SHOW TRANSACTION ISOLATION LEVEL;

-- 1 сессия
begin;

-- 2 сессия
begin;

-- 1 сессия
select sum(rating) from pizzeria;

-- 2 сессия
insert into pizzeria 
	values (10,'Kazan Pizza', 5);
commit;

-- 1 сессия
select sum(rating) from pizzeria;
commit;
select sum(rating) from pizzeria;

-- 2 сессия
select sum(rating) from pizzeria;



