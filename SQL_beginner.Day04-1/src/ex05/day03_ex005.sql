CREATE OR replace VIEW v_price_with_discount
AS
  SELECT name,
         pizza_name,
         price,
         ( 0.9 * price ) :: INT AS discount_price
  FROM   person_order
         join person
           ON person.id = person_id
         join menu
           ON menu_id = menu.id
  ORDER  BY name,
            pizza_name;

SELECT *
FROM   v_price_with_discount; 