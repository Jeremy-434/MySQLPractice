--"AS" Asignar un nombre a una columna mientras se consulta--
SELECT Price, Price*2 AS double_price FROM Products;

--"ORDER BY" ordenar por--
SELECT * FROM Products
ORDER BY Price DESC; --"DESC" para ordenar descendentemente o "ASC" para ascendente--

--"NULL LAST" NULL al final--
SELECT * FROM Products
ORDER BY Price DESC NULLS LAST;

--"RANDOM()" para ordenar de forma aleatoria--
SELECT * FROM Products
ORDER BY RANDOM();

--"DISTINC"--
SELECT DISTINCT ProductName
FROM Products ORDER BY RANDOM();

--"LIMIT" cuantos registros quiero que se muestren--
SELECT * FROM Products
WHERE NOT CategoryID = 6
AND NOT SupplierID = 1
AND Price <= 30
ORDER BY RANDOM()
LIMIT 3;

--"BETWEEN" para buscar entre un rango entre--
SELECT * FROM Products
WHERE Price BETWEEN 20 AND 30;

--"LIKE"--
SELECT * FROM Employees WHERE LastName LIKE "$r$"; -- "F____r" , ""

--"IS NULL" - "IS NOT NULL"--
SELECT * FROM Products
WHERE ProductName IS NOT NULL;

--"IN"--
SELECT * FROM Products
WHERE SupplierID IN (5,3,4,6);

--Funciones de agregación "count()", "AVG()", "sum()", "ROUND(n1,n2)", "MIN()", ""--
SELECT count(FirstName) FROM Employees;
---
SELECT ProductName, MIN(Price) FROM Products
WHERE ProductName IS NOT NULL;

--"GROUP BY"--
SELECT SupplierID,ROUND(AVG(Price)) as Promedio FROM Products
GROUP BY SupplierID -- Se muestra el promedio de cada SupplierID --
ORDER BY promedio DESC
--"WHERE" va antes del "GROUP BY"--
SELECT ProductName,CategoryID,ROUND(AVG(Price)) as Promedio FROM Products -- Devuelve el primer "ProductName" de los posibles, gracias a que esta agrupado con "ORDER BY" --
WHERE CategoryID IS NOT NULL -- Primero se usa la condicion para luego agruparlos por esa condicion --
GROUP BY CategoryID

--"HAVING" con esta clausula se puede hacer filtrado del "GROUP BY"--
SELECT SupplierID,ROUND(AVG(Price)) as Promedio FROM Products 
GROUP BY SupplierID
HAVING Promedio > 40 --Solo las agrupaciones del promedio de SupplierID que sean mayor a 40--

--"WHERE" antes que el "GROUP BY" porque las condiciones se trabajan antes que las condiciones de grupos--
SELECT SupplierID,ROUND(AVG(Price)) as Promedio FROM Products 
WHERE ProductName IS NOT NULL
GROUP BY SupplierID
HAVING Promedio > 40 --"HAVING" clausula con la que se puede hacer filtrado del "GROUP BY"--
---
SELECT ProductID, SUM(Quantity) as Total FROM OrderDetails
GROUP BY ProductID
-- HAVING MAX(Total) No se puede ya que "Total" es el resultado de una funcion --
HAVING Total > 50 --"HAVING" clausula con la que se puede hacer filtrado del "GROUP BY"--
ORDER BY Total ASC
LIMIT 1

-- SUBCONSULTAS --
SELECT 
ProductID, --Column 1
Quantity, --Column 2
(SELECT ProductName FROM Products p WHERE od.ProductID = p.ProductID) as 'Nombre del producto', --Esto es una subconsulta(subquery) como campo en la tabla a mostrar
(SELECT Price FROM Products p WHERE od.ProductID = p.ProductID) as 'Precio del producto' --Column 3
FROM OrderDetails od; --El "od" es un alias muy usado en SQL para hacer referencias a tablas de una forma muy sencilla--


