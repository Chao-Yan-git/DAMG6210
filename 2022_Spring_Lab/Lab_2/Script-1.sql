USE AdventureWorks2008R2;

-- 2-1

SELECT 	SalesPersonID, SalesOrderID, CAST (OrderDate as date) 'Order Date', ROUND(TotalDue, 2) 'Total Due'
FROM Sales.SalesOrderHeader soh 
WHERE SalesPersonID = 276 OR SalesPersonID = 277 AND TotalDue > 100000
Order BY SalesOrderID , OrderDate ;


-- 2-2

SELECT TerritoryID AS 'Territory ID',  COUNT(SalesOrderID) AS 'Total Orders', CAST(SUM(ROUND(TotalDue, 0)) AS Integer) AS 'Total Sales Amount'
FROM Sales.SalesOrderHeader 
GROUP BY TerritoryID
HAVING COUNT(SalesOrderID) > 3500
ORDER BY TerritoryID ;


-- 2-3

SELECT ProductID AS 'Product ID' , Name AS 'Product Name' , ROUND(ListPrice, 2) AS 'List Price', CAST (SellStartDate AS date) AS 'Sell Start Date'
FROM Production.Product p 
WHERE ListPrice > ((SELECT MAX (ListPrice) FROM Production.Product p2) - 1000)
ORDER BY ListPrice DESC ;


-- 2-4

SELECT p.ProductID AS 'Product ID' , Name AS 'Product Name' , SUM (p.ListPrice * sod.OrderQty) AS 'Total Sold Quantity'
FROM Production.Product p 
JOIN Sales.SalesOrderDetail sod 
on p.ProductID = sod.ProductID 
WHERE p.Color IN ('BLACK')
GROUP BY p.ProductID , p.Name 
HAVING  SUM (p.ListPrice * sod.OrderQty) > 3000
ORDER BY SUM (p.ListPrice * sod.OrderQty) DESC ;


-- 2-5

SELECT CAST (OrderDate AS Date) AS 'Date', 
	SUM(OrderQty) AS 'Total Product Quantity Sold for the Date'
FROM Sales.SalesOrderDetail sod 
INNER JOIN Production.Product p 
ON sod.ProductID = p.ProductID 
INNER JOIN Sales.SalesOrderHeader soh
ON soh.SalesOrderID = sod.SalesOrderID 
WHERE Color NOT IN('RED')
GROUP BY soh.OrderDate 
HAVING SUM(sod.OrderQty) > 0
ORDER BY SUM(OrderQty) DESC ;


-- 2-6
WITH ma (
	CustomerID ,
	LastName ,
	FirstName ,
	AnnualPurchase
) 
AS (
	SELECT soh.CustomerID , 
		p.LastName, 
		p.FirstName,
		SUM(soh.TotalDue)
	FROM Sales.SalesOrderHeader soh 
		LEFT JOIN Person.Person p 
			ON CustomerID = p.BusinessEntityID
	GROUP BY soh.CustomerID , Year (soh.OrderDate), p.LastName , p.FirstName 
)
SELECT CustomerID 
		, LastName 
		, FirstName 
		, SUM(AnnualPurchase) AS 'Overall Purchase'
		, MAX(AnnualPurchase) AS 'Highest Annual Purchase' 
FROM ma 
GROUP BY CustomerID, ma.LastName , ma.FirstName 
HAVING SUM(AnnualPurchase) > 500000
ORDER BY SUM(AnnualPurchase) DESC ;





