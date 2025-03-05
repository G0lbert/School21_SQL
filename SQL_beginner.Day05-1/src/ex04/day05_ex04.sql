CREATE UNIQUE INDEX idx_menu_unique 
ON menu 
USING btree (pizzeria_id, pizza_name);

EXPLAIN ANALYZE 
    SELECT * 
    FROM menu 
    WHERE pizzeria_id = 1 
    AND pizza_name = 'sausage pizza'; 