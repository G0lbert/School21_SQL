CREATE INDEX idx_person_name ON person USING btree (upper(name)); 

SELECT *
FROM   person
WHERE  Upper(NAME) = 'DENIS';