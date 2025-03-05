CREATE INDEX idx_person_order_order_date 
ON person_order 
USING btree (person_id, menu_id) 
WHERE order_date = '01.01.2022';

EXPLAIN ANALYZE 
    SELECT * FROM
    person_order 
    WHERE order_date = '01.01.2022'; 