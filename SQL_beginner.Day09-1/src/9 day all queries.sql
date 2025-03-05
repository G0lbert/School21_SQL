-- 8
create or replace function fnc_fibonacci(pstop bigint default 10) returns table(number1 bigint) as
$$
	with recursive fibonacci(number1, number2) as(
	select 1, 1
		union all
	select number2 + number1, number1
	from fibonacci
	where number1 < pstop
	)
	select number1 from fibonacci
$$
language sql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();

