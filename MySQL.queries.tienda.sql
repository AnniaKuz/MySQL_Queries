USE tienda;
/* A l'hora de fer l'exercici sempre especifico la data de base a propòsit
(no calia posar tienda.* però penso que en els projectes més grans és 
més pràctic especificar-ho per no crear confucions)
Quan faig serviar alias utilitzo '' tot i que no és necessari. Des del meu punt de vista, 
així el codi és més fàcil de llegir. */

-- 1.Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre
FROM tienda.producto;

-- 2. Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio
FROM tienda.producto;

-- 3. Llista totes les columnes de la taula producto.
SHOW COLUMNS 
FROM tienda.producto;

-- 4. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, CONCAT('€', FORMAT(precio, 2)) AS '€precio', 
		CONCAT('$', FORMAT(precio*0.97, 2)) AS '$precio'
FROM tienda.producto;

-- 5. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). 
-- Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS 'nombre de producto', CONCAT('€', FORMAT(precio, 2)) AS 'euros', 
		CONCAT('$', FORMAT(precio*0.97, 2)) AS 'dolars'
FROM tienda.producto;

-- 6. Llista els noms i els preus de tots els productes de la taula producto, 
-- convertint els noms a majúscula.
SELECT UPPER(nombre) AS 'NOMBRE', precio
FROM tienda.producto;

-- 7. Llista els noms i els preus de tots els productes de la taula producto, 
-- convertint els noms a minúscula.
SELECT LOWER(nombre) as 'nombre', precio
FROM tienda.producto;

-- 8. Llista el nom de tots els fabricants en una columna,
-- i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(SUBSTRING(nombre,1,2)) AS 'abreviatura' FROM tienda.fabricante;

-- 9. Llista els noms i els preus de tots els productes de la taula producto, 
-- arrodonint el valor del preu.
SELECT nombre, ROUND(precio, 0) AS 'precio redondeo' FROM tienda.producto;

-- 10. Llista els noms i els preus de tots els productes de la taula producto,
-- truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, FLOOR(precio) FROM tienda.producto;

-- 11. Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT codigo_fabricante FROM tienda.producto;

-- 12. Llista el codi dels fabricants que tenen productes en la taula producto, 
-- eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo_fabricante FROM tienda.producto; 

-- 13. Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM tienda.fabricante ORDER BY nombre;

-- 14. Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM tienda.fabricante ORDER BY nombre DESC;

-- 15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent 
-- i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio FROM tienda.producto ORDER BY nombre ASC, precio DESC;

-- 16. Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM tienda.fabricante LIMIT 5;

-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. 
-- La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM tienda.fabricante LIMIT 3, 2;

-- 18. Llista el nom i el preu del producte més barat. 
-- (Utilitza solament les clàusules ORDER BY i LIMIT). 
-- NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM tienda.producto ORDER BY precio LIMIT 1;

-- 19. Llista el nom i el preu del producte més car.
-- (Utilitza solament les clàusules ORDER BY i LIMIT).
-- NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM tienda.producto ORDER BY precio DESC LIMIT 1;

-- 20. Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM tienda.producto WHERE codigo_fabricante = 2;

-- 21. Retorna una llista amb el nom del producte, 
-- preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre, precio, f.nombre AS 'nombre_fabricante' FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo;

-- 22. Retorna una llista amb el nom del producte, preu 
-- i nom de fabricant de tots els productes de la base de dades. 
-- Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT p.nombre, precio, f.nombre AS 'nombre_fabricante' FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

 -- 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricador 
 -- i nom del fabricador, de tots els productes de la base de dades
SELECT p.codigo, p.nombre, precio, f.nombre AS 'nombre_fabricante' FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo; 
    
-- 24. Retorna el nom del producte, el seu preu i el nom del seu fabricant,
-- del producte més barat.
/* SELECT p.codigo, p.nombre, precio, f.nombre AS 'nombre_fabricante'
FROM tienda.producto p
JOIN tienda.fabricante f
	ON p.codigo_fabricante = f.codigo
ORDER BY precio 
LIMIT 1; */

SELECT p.codigo, p.nombre, precio , f.nombre AS 'nombre_fabricante' FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE precio = (SELECT MIN(precio) FROM tienda.producto);

-- 25. Retorna el nom del producte, el seu preu 
-- i el nom del seu fabricant, del producte més car.
/* SELECT p.codigo, p.nombre, precio, f.nombre AS 'nombre_fabricante'
FROM tienda.producto p
JOIN tienda.fabricante f
	ON p.codigo_fabricante = f.codigo
ORDER BY precio DESC
LIMIT 1; */

SELECT p.codigo, p.nombre, precio , f.nombre AS 'nombre_fabricante' FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE precio = (SELECT MIN(precio) FROM tienda.producto);

-- 26. Retorna una llista de tots els productes del fabricant Lenovo.
SELECT p.* FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';

-- 27. Retorna una llista de tots els productes del fabricant Crucial
-- que tinguin un preu major que 200 €.
SELECT p.* FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' AND precio > 200;

-- 28. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. 
-- Sense utilitzar l'operador IN.
SELECT p.* FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate'; 

-- 29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate.
-- Fent servir l'operador IN.
SELECT p.* FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ('Asus','Hewlett-Packard','Seagate'); 

-- 30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants
-- el nom dels quals acabi per la vocal e.
SELECT p.nombre, precio FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e';

-- 31. Retorna un llistat amb el nom i el preu de tots els productes 
-- el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT p.nombre, precio FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre REGEXP 'w'; 

-- 32.Retorna un llistat amb el nom de producte, preu i nom de fabricant,
-- de tots els productes que tinguin un preu major o igual a 180 €.
-- Ordena el resultat, en primer lloc, pel preu (en ordre descendent) 
-- i, en segon lloc, pel nom (en ordre ascendent).
SELECT p.nombre, precio, f.nombre FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE precio>=180 ORDER BY precio DESC, p.nombre; 

-- 33. Retorna un llistat amb el codi i el nom de fabricant,
-- solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT DISTINCT f.* FROM tienda.fabricante f RIGHT JOIN tienda.producto p ON f.codigo = p.codigo_fabricante;
/* SELECT f.*
FROM tienda.fabricante f
JOIN tienda.producto p
	ON f.codigo = p.codigo_fabricante
group by p.codigo_fabricante
having count(p.codigo)>=1; */

-- 34.Retorna un llistat de tots els fabricants que existeixen en la base de dades, 
-- juntament amb els productes que té cadascun d'ells. 
-- El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT f.*, p.nombre AS 'nombre_producto', p.codigo AS 'codigo_producto', precio FROM tienda.fabricante f LEFT JOIN tienda.producto p ON f.codigo = p.codigo_fabricante;

    
-- 35.Retorna un llistat on només apareguin aquells fabricants 
-- que no tenen cap producte associat.
SELECT f.* FROM tienda.fabricante f LEFT JOIN tienda.producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo_fabricante IS NULL;

-- 36. Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT p.* FROM tienda.producto p LEFT JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';  

-- 37. Retorna totes les dades dels productes que tenen el mateix preu 
-- que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
/* SELECT *
FROM tienda.producto
WHERE precio=(
	SELECT max(p.precio) FROM tienda.producto p
	LEFT JOIN tienda.fabricante f
		ON p.codigo_fabricante = f.codigo
	WHERE  f.nombre='Lenovo'
	GROUP BY p.codigo_fabricante) 
AND codigo_fabricante != (
	SELECT codigo
    FROM tienda.fabricante 
    WHERE nombre='Lenovo'); */

SELECT * FROM tienda.producto p WHERE precio=( SELECT max(p.precio) FROM tienda.producto p WHERE  p.codigo_fabricante=(SELECT codigo FROM tienda.fabricante WHERE nombre = 'Lenovo')) AND codigo_fabricante != (SELECT codigo FROM tienda.fabricante WHERE nombre = 'Lenovo');

-- 38. Llista el nom del producte més car del fabricant Lenovo.
SELECT p.nombre FROM tienda.producto p LEFT JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo' ORDER BY p.precio DESC LIMIT 1; 

-- 39. Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT p.nombre FROM tienda.producto p LEFT JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Hewlett-Packard' ORDER BY p.precio LIMIT 1; 

-- 40. Retorna tots els productes de la base de dades que tenen un preu major 
-- o igual al producte més car del fabricant Lenovo.
SELECT p.* FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante=f.codigo WHERE precio>=(SELECT MAX(precio) FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre ='LENOVO') AND f.nombre != 'LENOVO';

-- 41. Llista tots els productes del fabricant Asus que tenen un preu superior 
-- al preu mitjà de tots els seus productes. 

SELECT p.* FROM tienda.producto p LEFT JOIN tienda.fabricante f ON p.codigo_fabricante=f.codigo WHERE precio>(SELECT AVG(precio) FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre ='Asus') AND f.nombre = 'Asus';