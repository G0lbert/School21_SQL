CREATE OR replace VIEW v_generated_dates AS 
SELECT generate_series::date AS generated_date
FROM   generate_series ('01.01.2022'::date, '31.01.2022'::date, '1 day');
SELECT *
FROM   v_generated_dates;