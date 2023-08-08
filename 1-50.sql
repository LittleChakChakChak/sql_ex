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
SELECT pc.hd FROM pc
GROUP BY pc.hd
HAVING COUNT(pc.hd) > 1				
				
/* 16 */
/* 17 */
/* 18 */
/* 19 */
/* 20 */
/* 21 */
/* 22 */
/* 23 */
/* 24 */
/* 25 */
/* 26 */
/* 27 */
/* 28 */
/* 29 */
/* 30 */
