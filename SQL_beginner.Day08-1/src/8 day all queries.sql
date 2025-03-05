select * from person;
select * from pizzeria;
select * from menu;
select * from person_order;
select * from person_visits;

-- 0
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

-- 1
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

-- 2
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

--3
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
select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
update pizzeria
	set rating = 3.6
	where name = 'Pizza Hut';
commit;

-- 1 сессия
select * from pizzeria where name = 'Pizza Hut';
commit;
select * from pizzeria where name = 'Pizza Hut';

-- 2 сессия
select * from pizzeria where name = 'Pizza Hut';



-- 4
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


-- 5
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


-- 6
-- 1 сессия
set session characteristics as transaction isolation level repeatable read;
SHOW TRANSACTION ISOLATION LEVEL;

-- 2 сессия
set session characteristics as transaction isolation level repeatable read;
SHOW TRANSACTION ISOLATION LEVEL;

-- 1 сессия
begin;

-- 2 сессия
begin;

-- 1 сессия
select sum(rating) from pizzeria;

-- 2 сессия
insert into pizzeria 
	values (11,'Kazan Pizza 2', 4);
commit;

-- 1 сессия
select sum(rating) from pizzeria;
commit;
select sum(rating) from pizzeria;

-- 2 сессия
select sum(rating) from pizzeria;


-- 7
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