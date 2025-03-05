-- индексы не используются
EXPLAIN analyze 

SELECT pizza_name, 
       pizzeria.name 
       AS pizzeria_name 
FROM menu 
    JOIN pizzeria ON 
       pizzeria.id = pizzeria_id; 
-- а вот так используются

-- отключение индексов, чтобы постгрес работал без них
SET enable_seqscan = off;

EXPLAIN analyze 

SELECT pizza_name, 
       pizzeria.name 
       AS pizzeria_name 
FROM menu 
    JOIN pizzeria ON 
       pizzeria.id = pizzeria_id; 