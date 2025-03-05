SELECT generated_date AS missing_date
FROM   v_generated_dates
WHERE  NOT EXISTS (SELECT visit_date
                   FROM   person_visits
                   WHERE  generated_date = visit_date)
ORDER  BY missing_date; 