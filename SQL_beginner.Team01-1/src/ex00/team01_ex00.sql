WITH get_volume AS (SELECT COALESCE(u.name, 'not defined') AS name,
                           COALESCE(u.lastname, 'not defined') AS lastname,
                           b.type, SUM(b.money) AS volume,
                           MAX(b.currency_id) AS currency_id
                    FROM balance b
                    FULL JOIN "user" u
                           ON u.id = b.user_id
                    GROUP BY u.name, u.lastname, b.type),
	get_last_update AS (SELECT c.id, MAX(c.updated) AS updated 
	                    FROM currency c
	                    GROUP BY c.id, c.name),
	get_last_rate AS (SELECT *
	                  FROM currency c
	                  WHERE c.updated = (SELECT updated
	                                     FROM get_last_update glu
	                                     WHERE c.id = glu.id))
SELECT gv.name, gv.lastname, gv.type, gv.volume,
       COALESCE(glr.name, 'not defined') AS currency_name,
       COALESCE(glr.rate_to_usd, 1) AS last_rate_to_usd, 
       gv.volume * COALESCE(glr.rate_to_usd, 1) AS total_volume_in_usd
FROM get_volume gv
FULL JOIN get_last_rate glr
    ON glr.id = gv.currency_id
ORDER BY 1 DESC, 2 ASC, 3 ASC