-- дурацное условие, я до сих пор не понял что от имели ввиду авторы задания
SELECT * FROM person_order
WHERE mod(id, 2) = 0
ORDER BY id ASC;