/* 51 */               
WITH t1 AS 
(
	SELECT numGuns, displacement, name
	FROM 
		(SELECT s.name, s.class
		FROM Ships s
		UNION 
		SELECT o.ship, o.ship
		FROM Outcomes o) AS tt1		
		JOIN Classes c ON c.class=tt1.class
), t2 AS
(
	SELECT max(numGuns) MaxGuns, displacement
	FROM 
		(SELECT s.name, s.class
		FROM Ships s
		UNION 
		SELECT o.ship, o.ship
		FROM Outcomes o) AS tt2
		JOIN Classes c ON c.class=tt2.class
	GROUP BY displacement
)

SELECT t1.name
FROM t1
	JOIN t2 ON t2.MaxGuns=t1.numGuns AND t2.displacement=t1.displacement

/* 52 */
/* upper - перевод строки в верхний регистр */	
/* IS NULL - проверка на значение NULL */	
SELECT DISTINCT s.name
FROM Ships s 
LEFT JOIN Classes c ON c.class = s.class
WHERE c.type='bb' AND upper(c.country) = 'JAPAN' 
AND (c.numGuns >= 9 OR c.numGuns IS NULL) 
AND (c.bore < 19 OR c.bore IS NULL) 
AND (c.displacement <= 65000 OR c.displacement IS NULL)

/* 53 */
SELECT CAST(avg(CAST(c.numGuns AS NUMERIC(10,2))) AS NUMERIC(10,2)) AS 'Avg-numGuns'
FROM Classes c
WHERE c.type = 'bb'

/* 54 */
SELECT CAST(avg(CAST(t.numGuns AS NUMERIC(10,2))) AS NUMERIC(10,2)) AS 'Avg-numGuns'
FROM (SELECT s.name, c.numGuns 
		FROM Ships s, Classes c
		WHERE c.type = 'bb' AND s.class = c.class
		UNION 
		SELECT o.ship, c.numGuns 
		FROM Outcomes o, Classes c
		WHERE c.type = 'bb' AND o.ship = c.class) t

/* 55 */
SELECT c.class, s.launched as year
FROM Classes c
left join (SELECT class, min(launched) AS launched
			FROM Ships
			GROUP BY class) s on s.class = c.class
		
		
/* 56 */
/* 57 */
/* 58 */
/* 59 */
/* 60 */
/* 61 */
/* 62 */
/* 63 */
/* 64 */
/* 65 */
/* 66 */
/* 67 */
/* 68 */
/* 69 */
/* 70 */
/* 71 */
/* 72 */
/* 73 */
/* 74 */
/* 75 */
/* 76 */
/* 77 */
/* 78 */
/* 79 */
/* 80 */
/* 81 */
/* 82 */
/* 83 */
/* 84 */
/* 85 */
/* 86 */
/* 87 */	
/* 88 */
/* 89 */
/* 90 */
/* 91 */
/* 92 */
/* 93 */
/* 94 */
/* 95 */
/* 96 */
/* 97 */
/* 98 */
/* 99 */
/* 100 */
