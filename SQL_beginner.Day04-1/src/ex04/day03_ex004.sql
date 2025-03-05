CREATE OR replace VIEW v_symmetric_union AS
                       (
                              SELECT *
                              FROM   person_visits
                              WHERE  visit_date < '02.01.2022'
                              EXCEPT
                              SELECT *
                              FROM   person_visits
                              WHERE  visit_date < '06.01.2022'
                       )
                UNION
                      (
                             SELECT *
                             FROM   person_visits
                             WHERE  visit_date < '06.01.2022'
                             EXCEPT
                             SELECT *
                             FROM   person_visits
                             WHERE  visit_date < '02.01.2022');