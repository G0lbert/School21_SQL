CREATE sequence seq_person_discounts 
start WITH 1 
increment BY 1;

ALTER TABLE person_discounts ALTER COLUMN id SET default nextval('seq_person_discounts');

-- обновляем значение последовательности seq_person_discounts
SELECT Setval('seq_person_discounts',
       (
              SELECT Count(*)+1
              FROM   person_discounts));
