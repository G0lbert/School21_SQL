-- говняное объединение, но вроде я провильно понял что авторы от меня хотели
SELECT concat(name, ' (age:', age, ',gender:''', gender, ''',address:''', address, ''')') 
AS "person_information" 
FROM person
ORDER BY "person_information";