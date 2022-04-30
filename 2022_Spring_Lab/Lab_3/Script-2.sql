USE AdventureWorks2008R2; 

-- Lab 3-1

SELECT SalesPersonID, p.LastName, p.FirstName,
		COUNT(o.SalesOrderid) [Total Orders],
		CASE 
			WHEN COUNT(o.SalesOrderID) BETWEEN 1 AND 120
				THEN 'Do more!'
			WHEN COUNT(o.SalesOrderID) BETWEEN 121 AND 320
				THEN 'Fine!'
			WHEN COUNT(o.SalesOrderID) > 320
				THEN 'Excellent!'
		END AS [Order Amount]
FROM Sales.SalesOrderHeader o
JOIN Person.Person p
ON o.SalesPersonID = p.BusinessEntityID
GROUP BY o.SalesPersonID, p.LastName, p.FirstName
ORDER BY p.LastName, p.FirstName;


-- Lab 3-2

SELECT o.TerritoryID, s.Name, o.SalesPersonID,
	COUNT(o.SalesOrderid) [Total Orders],
	RANK() OVER (PARTITION BY o.TerritoryID ORDER BY COUNT(o.SalesOrderid) DESC) [Rank]
FROM Sales.SalesOrderHeader o
JOIN Sales.SalesTerritory s
	ON o.TerritoryID = s.TerritoryID
WHERE SalesPersonID IS NOT NULL
GROUP BY o.TerritoryID, s.Name, o.SalesPersonID
ORDER BY o.TerritoryID;



-- Lab 3-3


WITH temp AS (
	SELECT sod.ProductID AS "ProductID", a.City AS "City" , SUM(sod.OrderQty) AS "Total Sold Quantity",
	RANK() OVER (PARTITION BY a.City ORDER BY SUM(sod.OrderQty) DESC) AS [Rank]
	FROM Sales.SalesOrderDetail sod 
	JOIN Sales.SalesOrderHeader soh 
	ON sod.SalesOrderID = soh.SalesOrderID 
	JOIN Production.Product p 
	ON sod.ProductID = p.ProductID 
	JOIN Person.Address a 
	ON soh.ShipToAddressID = a.AddressID  
	GROUP BY  sod.ProductID , a.City
	HAVING SUM(sod.OrderQty) > 100 
)
SELECT  "City" , "ProductID",  "Total Sold Quantity"
FROM temp
WHERE Rank = 1
ORDER BY 'City';



-- Lab 3-4

SELECT "OrderDate", "ProductID", "Total Sold Quantity"
FROM(
	SELECT soh.OrderDate AS "OrderDate"
	, sod.ProductID AS "ProductID"
	, SUM(sod.OrderQty) AS "Total Sold Quantity",
	RANK() OVER(PARTITION BY soh.OrderDate ORDER BY SUM(sod.OrderQty) DESC) AS [RANK]
	FROM Sales.SalesOrderDetail sod 
	JOIN Sales.SalesOrderHeader soh 
	ON sod.SalesOrderID = soh.SalesOrderID 
	JOIN Production.Product p 
	ON sod.ProductID = p.ProductID 
	GROUP BY sod.ProductID , soh.OrderDate 
) cho
WHERE RANK = 1
ORDER BY "OrderDate";



-- Lab 3-5

WITH ma1 AS (
	SELECT soh.CustomerID AS "CustomerID",
		   sod.ProductID AS "ProductID",
		   COUNT(sod.ProductID) as "quantity1"
	FROM Sales.SalesOrderHeader soh 
	JOIN Sales.SalesOrderDetail sod 
	ON soh.SalesOrderID = sod.SalesOrderID  
	GROUP BY soh.CustomerID, sod.ProductID 
	HAVING COUNT(sod.ProductID) > 1
),
ma2 AS(
	SELECT soh.CustomerID AS "CustomerID",
		   COUNT(DISTINCT sod.ProductID) AS "quantity2"
	FROM Sales.SalesOrderHeader soh 
	JOIN Sales.SalesOrderDetail sod 
	ON soh.SalesOrderID = sod.SalesOrderID  
	GROUP BY soh.CustomerID 
	HAVING COUNT(DISTINCT sod.ProductID) > 10
)
SELECT "CustomerID" FROM ma2
WHERE "CustomerID" NOT IN (SELECT "CustomerID" FROM ma1)
ORDER BY "quantity2" DESC;

