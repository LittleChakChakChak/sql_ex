/* 51 */
SELECT ship, numGuns,displacement
FROM Outcomes
JOIN Classes ON Outcomes.ship = Classes.class
WHERE Classes.numGuns= any(SELECT MAX(numGuns) AS max_numGuns
FROM Classes 
GROUP BY displacement)
UNION 
SELECT name, MAX(numGuns) AS max_numGuns, displacement
FROM Ships 
JOIN Classes ON Ships.class = Classes.class
WHERE Classes.numGuns= any(SELECT displacement
FROM Classes 
GROUP BY displacement)





/* 51 */
/* 51 */
/* 51 */
/* 51 */
/* 51 */
/* 51 */
/* 51 */