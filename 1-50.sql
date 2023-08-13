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
		
		
/* 33 */
		
		
/* 34 */
/* 35 */
/* 36 */
/* 37 */
/* 38 */
/* 39 */
/* 40 */
/* 41 */
/* 42 */
