COMMENT ON TABLE person_discounts IS
'This table provides some information about person''s discount in each pizzeria';

COMMENT ON COLUMN person_discounts.id IS 'PK identificator for each row';

COMMENT ON COLUMN person_discounts.person_id IS 'FK identificator for person';

COMMENT ON COLUMN person_discounts.pizzeria_id IS
'FK identificator for pizzeria where was  ordered pizza by specific person';

COMMENT ON COLUMN person_discounts.discount IS
'field with amount of discount on pizza in percents'; 