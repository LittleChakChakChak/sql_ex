/* 1 */
SELECT model, speed, hd 
FROM PC
WHERE price < 500

/* 2 */
/* DISTINCT - вывод только уникальных значений */
SELECT DISTINCT maker 
FROM Product 
WHERE type = 'Printer'

/* 3 */
SELECT model, ram, screen 
FROM Laptop 
WHERE price > 1000

/* 4 */
SELECT * 
FROM Printer 
WHERE color = 'y'

/* 5 */
SELECT model, speed, hd 
FROM pc 
WHERE (cd = '12x' OR cd = '24x') AND price < 600

/* 6 */
SELECT DISTINCT Product.Maker, Laptop.speed 
FROM Product 
LEFT JOIN Laptop
	ON Product.model = Laptop.model
WHERE Laptop.hd >= 10

/* 7 */
/* UNION - объединение запросов */
SELECT DISTINCT PC.model, PC.price FROM PC
	LEFT JOIN Product 
	ON PC.model = Product.model
	WHERE Product.maker = 'B'
UNION 
SELECT DISTINCT Laptop.model, Laptop.price FROM Laptop
	LEFT JOIN Product 
	ON Laptop.model = Product.model
	WHERE Product.maker = 'B'
UNION 
SELECT DISTINCT Printer.model, Printer.price FROM Printer
	LEFT JOIN Product 
	ON Printer.model = Product.model
	WHERE Product.maker = 'B'

/* 8 */
SELECT DISTINCT maker 
FROM product 
WHERE type='pc'
	and maker NOT IN(SELECT maker 
					FROM product 	
					WHERE type='laptop')

/* 9 */
SELECT distinct product.maker 
FROM Product 
LEFT JOIN PC 
	ON pc.model = product.model
WHERE pc.speed >= 450

/* 10 */
SELECT model, price 
FROM printer
WHERE price = (SELECT max(price) 
				FROM printer)
				
/* 11 */
/* AVG - средние значение */
SELECT AVG(speed) AS avg_speed 
FROM PC				
				
/* 12 */
SELECT AVG(SPEED) AS Avg_speed 
FROM Laptop
WHERE price > 1000				
				
/* 13 */
SELECT AVG(PC.speed) AS Avg_speed 
FROM PC
LEFT JOIN Product
	ON PC.model = Product.model
WHERE Product.maker = 'A'				
				
/* 14 */
SELECT Classes.class, Ships.name, Classes.country
FROM Ships
LEFT JOIN Classes
	ON Ships.class = Classes.class
WHERE CLasses.numGuns >= 10
				
/* 15 */
/* GROUP BY - распределяет значение колонок по группам */
/* HAVING - условие при группировеи колонки */
SELECT pc.hd 
FROM pc
GROUP BY pc.hd
HAVING COUNT(pc.hd) > 1				
				
/* 16 */
SELECT DISTINCT p1.model, p2.model, p1.speed, p1.ram
FROM PC p1, PC p2
WHERE p1.speed = p2.speed AND p1.ram = p2.ram AND p1.model > p2.model

/* 17 */
/* ANY/SOME -  возвращает true, если какое-либо из значений подзапроса соответствует условию. 
 * ALL - возвращает true, если все значения подзапроса удовлетворяют условию. */
SELECT DISTINCT Product.type, Laptop.model, Laptop.speed 
FROM Product, Laptop
WHERE Product.type = 'Laptop' 
	AND Laptop.speed < ANY(SELECT MIN(speed) 
							FROM PC)

/* 18 */
SELECT DISTINCT Product.maker, Printer.price
FROM Printer
LEFT JOIN Product 
	ON Product.model = Printer.model
WHERE Printer.color = 'y' 
	AND Printer.price = (SELECT min(price) 
							FROM Printer 
							WHERE Printer.color = 'y')

/* 19 */
SELECT pro.maker AS Maker, AVG(lap.screen) AS Avg_sreen 
FROM Product pro
LEFT JOIN Laptop lap 
	ON pro.model = lap.model
GROUP BY pro.maker
							
/* 20 */
SELECT maker AS Maker, COUNT(model) AS Count_Model 
FROM product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(model) >= 3

/* 21 */
SELECT pro.maker AS Maker, MAX(PC.price) AS Max_Price 
FROM Product pro 
RIGHT JOIN PC ON PC.model = pro.model
GROUP BY pro.maker

/* 22 */
SELECT speed, AVG(price) AS AVG_price
FROM PC
WHERE speed > 600
GROUP BY speed

/* 23 */
SELECT DISTINCT t1.maker
FROM Product t1 
LEFT JOIN PC t2 
ON t1.model=t2.model
WHERE t2.speed>=750 AND t1.maker IN(SELECT t1.maker
				FROM Product t1 
				JOIN Laptop t2 
				ON t1.model=t2.model
				WHERE t2.speed>=750)
				
/* 24 */
/* UNION - объединение отдельных запросов в один (без All вывод только уникальных строк)
 * WITH - создание временной таблицы (CTE) */				
WITH model_count 
AS (SELECT model, price AS max_price 
	FROM PC
	UNION ALL
	SELECT model, price AS max_price 
	FROM Laptop
	UNION ALL
	SELECT model, price AS max_price 
	FROM Printer)
SELECT DISTINCT model 
FROM model_count 
WHERE max_price = (SELECT max(max_price) 
					FROM model_count)

/* 25 */				
SELECT DISTINCT maker
FROM Product
WHERE model IN (SELECT model
				FROM PC
				WHERE ram = (SELECT MIN(ram)
  							FROM PC
  							) 
  							AND speed = (SELECT MAX(speed)
  										FROM PC
  										WHERE ram = (SELECT MIN(ram)
   													FROM PC
   													)
   										)
							)
							AND maker IN (SELECT maker
											FROM Product
											WHERE type='printer'
										)
			
/* 26 */
SELECT AVG(t.price) AS AVG_price
FROM (SELECT price 
		FROM PC
 		JOIN product ON product.model = pc.model
		WHERE product.maker = 'A'
		UNION ALL 
		SELECT price 
		FROM laptop
		JOIN product ON product.model = laptop.model
		WHERE product.maker = 'A'
		) t										

/* 27 */
SELECT DISTINCT Product.maker, AVG(PC.hd) AS AVG_hd
FROM Product
JOIN PC ON PC.model = Product.model
WHERE Product.maker IN (SELECT maker 
						FROM Product 
						WHERE Product.type = 'Printer')
GROUP BY Product.maker	
		
/* 28 */
SELECT count(maker) as qty
FROM Product
WHERE maker IN (SELECT maker
				FROM Product
				GROUP BY maker
				having count(model) = 1)
		
/* 29 */
SELECT i.point, i.date, i.inc, o.out
FROM income_o i
LEFT JOIN outcome_o o ON i.point = o.point AND i.date = o.date
UNION
SELECT o.point, o.date, i.inc, o.out
FROM outcome_o o
LEFT JOIN income_o i ON o.point = i.point AND o.date = i.date
		
/* 30 */
WITH SB(point, date, out, inc) AS (
    SELECT point, date, null, inc
        FROM income
        UNION ALL
        SELECT point, date, out, null
        FROM outcome
)
SELECT point, date, SUM(out) as Outcome, SUM(inc) as Income
FROM SB
GROUP BY point, date
		
/* 31 */
SELECT class, country 
FROM Classes
WHERE bore >= 16		
		
/* 32 */
/* CAST - преобразование типа данных
 * power - возведение числа в степень */	
SELECT t1.country,
	CAST(avg(power(t1.bore,3)/2) AS NUMERIC(6,2)) AS weight
FROM (SELECT c.country, c.bore, s.name
		FROM Classes c
		LEFT JOIN Ships s ON c.class=s.class
		UNION 
		SELECT c.country, c.bore, o.ship name
		FROM Classes c
		LEFT JOIN Outcomes o ON c.class=o.ship) t1
WHERE name IS NOT NULL
GROUP BY t1.country		
		
/* 33 */
SELECT ship 
FROM Outcomes
WHERE battle = 'North Atlantic' AND result = 'sunk'		
		
/* 34 */
SELECT name 
FROM ships s, classes c
WHERE c.class = s.class AND displacement > 35000 
	AND launched >= 1922 AND type = 'bb'

/* 35 */
/* LIKE - поиск содержащих символов
 * '%[^A-Z]%'  - не содержит только латинских букв
 * '%[^0-9]%'  - не содержит только цифры 
 * ^ - диапозон 
 * [] - одиночный символ (указывается)*/
SELECT model, type 
FROM Product
WHERE upper(model) NOT LIKE '%[^A-Z]%' 
		OR model NOT LIKE '%[^0-9]%'

/* 36 */
SELECT s.name 
FROM Ships s
WHERE s.name = s.class
UNION 
SELECT o.ship AS name 
FROM Outcomes o
JOIN Classes c ON c.class = o.ship		

/* 37 */
SELECT c.class 
FROM Classes c
LEFT JOIN (SELECT class, name 
			FROM Ships
			UNION
			SELECT Classes.class AS class, Outcomes.ship AS name
			FROM Outcomes
			JOIN Classes ON Outcomes.ship = Classes.class) AS s ON c.class = s.class
GROUP BY c.class
HAVING count(s.name)=1

/* 38 */
/* INTERSECT - пересечение (встречаются и одновременно в разных запросах) */
SELECT country
FROM Classes
where type = 'bb' 
INTERSECT 
SELECT country
FROM Classes
where type = 'bc'

/* 39 */
SELECT DISTINCT o.ship
FROM Outcomes o, Battles b
WHERE o.battle = b.name AND o.ship IN (SELECT o1.ship
										FROM Outcomes o1, Battles b1
										WHERE o1.battle = b1.name AND o1.result = 'damaged' 
												AND b.date > b1.date)

/* 40 */
SELECT maker, max(type) AS type
FROM product 
GROUP BY maker
HAVING count(DISTINCT type) = 1 AND count(model) > 1

/* 41 */
/* case/ when / then / end - проверка значения на пустоту(условие на вывод) */
SELECT t1.maker, CASE WHEN count(price) = count(*) THEN max(price) END AS m_price
FROM (SELECT Product.maker, CASE WHEN count(price) = count(*) THEN max(price) END AS price
		FROM Product
		JOIN PC ON PC.model = Product.model
		GROUP BY Product.maker
		UNION 
		SELECT Product.maker, CASE WHEN count(price) = count(*) THEN max(price) END AS price
		FROM Product
		JOIN Printer ON Printer.model = Product.model
		GROUP BY Product.maker
		UNION 
		SELECT Product.maker,CASE WHEN count(price) = count(*) THEN max(price) END AS price
		FROM Product
		JOIN Laptop ON Laptop.model = Product.model
		GROUP BY Product.maker
		) as t1
GROUP BY t1.maker

/* 42 */
SELECT Outcomes.ship, Outcomes.battle
FROM Outcomes
WHERE Outcomes.result = 'sunk'

/* 43 */
/* IS NOT NULL - проверка значения на пустоту (в данном случае, что не содержит) */
SELECT Battles.name
FROM Battles
WHERE YEAR(Battles.date) NOT IN (SELECT DISTINCT Ships.launched 
									FROM Ships
									WHERE Ships.launched IS NOT NULL)

/* 44 */
SELECT Ships.name
FROM Ships
WHERE Ships.name LIKE 'R%'
UNION
SELECT Outcomes.ship
FROM Outcomes
WHERE Outcomes.ship LIKE 'R%'

/* 45 */
SELECT Ships.name
FROM Ships
WHERE Ships.name LIKE '% % %'
UNION
SELECT Outcomes.ship
FROM Outcomes
WHERE Outcomes.ship LIKE '% % %'

/* 46 */
/* ---Моя первая попытка------ */
SELECT Outcomes.ship, Classes.displacement, Classes. numGuns
FROM Outcomes
JOIN Ships ON Outcomes.ship = Ships.name
JOIN Classes ON Ships.class = Classes.class
WHERE Outcomes. battle = 'Guadalcanal'
/* ----Моя вторая попытка с учтением всех кораблей----- */
SELECT o.ship, displacement, numGuns 
FROM (SELECT name AS ship, displacement, numGuns
		FROM Ships s 
		JOIN Classes c ON c.class=s.class
		UNION
		SELECT class AS ship, displacement, numGuns
		FROM Classes c
		) AS a
RIGHT JOIN Outcomes o ON o.ship=a.ship
WHERE battle = 'Guadalcanal'

/* 47 */
/* ---Получения количества кораблей по странам----- */
WITH T1 AS (SELECT COUNT(name) as co, country 
			FROM (SELECT name, country 
					FROM Classes 
					INNER JOIN Ships ON Ships.class = Classes.class
					UNION 
					SELECT ship, country 
					FROM Classes 
					INNER JOIN Outcomes ON Outcomes.ship = Classes.class
					) FR1
			GROUP BY country
			),

/* ---Получения количества кораблей по странам, которые были потоплены----- */
T2 AS (SELECT COUNT(name) as co, country 
		FROM (SELECT name, country 
				FROM Classes 
				INNER JOIN Ships ON Ships.class = Classes.class
				WHERE name IN (SELECT DISTINCT ship 
								FROM Outcomes 
								WHERE result = 'sunk'
								)
				UNION
				SELECT ship, country 
				FROM Classes 
				INNER JOIN Outcomes ON Outcomes.ship = Classes.class
				WHERE ship IN (SELECT DISTINCT ship 
								FROM Outcomes 
								WHERE result = 'sunk')
								) FR2 
				GROUP BY country 
				)

/* ---Сверка двух временных таблиц----- */
SELECT T1.country 
FROM T1
INNER JOIN T2 ON T1.co = t2.co and t1.country = t2.country

/* 48 */
SELECT Classes.class
FROM Classes
JOIN Outcomes ON Outcomes.ship = Classes.class
WHERE Outcomes.result = 'sunk'
UNION
SELECT Ships.class
FROM Ships
JOIN Outcomes ON Outcomes.ship = Ships.name
WHERE Outcomes.result = 'sunk'

/* 49 */
SELECT Ships.name
FROM Ships
JOIN Classes ON Classes.class = Ships.class
WHERE Classes.bore = 16
UNION 
SELECT Outcomes.ship
FROM Outcomes
JOIN Classes ON Classes.class = Outcomes.ship
WHERE Classes.bore = 16

/* 50 */
SELECT DISTINCT Outcomes.battle
FROM Outcomes
JOIN Ships ON Outcomes.ship = Ships.name
WHERE Ships.class = 'Kongo'
