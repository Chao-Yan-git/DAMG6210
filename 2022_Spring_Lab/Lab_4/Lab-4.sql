Use AdventureWorks2008R2;
CREATE DATABASE "Chao_Yan";

USE "Chao_Yan";

-- Part A

CREATE TABLE TargetCustomers
(
TargetID int IDENTITY NOT NULL PRIMARY KEY,
FirstName varchar (50),
LastName varchar (50),
Address varchar (50),
City varchar (10),
State varchar (10),
ZipCode varchar (10)
);

CREATE TABLE MailingLists
(
MailingListID int IDENTITY NOT NULL PRIMARY KEY,
MailingList varchar (50)
);

CREATE TABLE TargetMailingLists
(
TargetID int NOT NULL 
		REFERENCES TargetCustomers(TargetID),
MailingListID int NOT NULL 
		REFERENCES MailingLists(MailingListID)
		CONSTRAINT PKTargetMailingLists PRIMARY KEY CLUSTERED
		(TargetID, MailingListID)
);


-- Part B

-- B-1

SELECT CustomerID,
STUFF ((SELECT distinct ', ' + isnull(convert(varchar(8),soh.SalesPersonID),'')
		FROM sales.SalesOrderHeader soh
		WHERE soh.CustomerID = h.CustomerID
		GROUP BY SalesPersonID
		FOR XML PATH('')) , 1, 1, '') AS SalesPerson
FROM sales.SalesOrderHeader h
GROUP BY h.CustomerID
ORDER BY CustomerID desc;

-- B-2

SELECT DISTINCT DATEPART(YEAR,soh.OrderDate) AS YEAR,
CONVERT(FLOAT,((SELECT CONVERT(FLOAT,SUM(top5Qty)) AS top5SUM
FROM (SELECT top 5 SUM(OrderQty) AS top5Qty
      FROM Sales.SalesOrderDetail sod
      JOIN Sales.SalesOrderHeader soh
      ON sod.SalesOrderID = soh.SalesOrderID
      WHERE DATEPART(YEAR,soh.OrderDate) = DATEPART(YEAR, soh.OrderDate)
      GROUP BY ProductID, DATEPART(YEAR,soh.OrderDate)
      ORDER BY SUM(OrderQty) DESC) AS temp)/
(SELECT CONVERT(FLOAT,SUM(OrderQty))
	FROM Sales.SalesOrderDetail sod
	JOIN Sales.SalesOrderHeader soh
	ON sod.SalesOrderID = soh.SalesOrderID
	WHERE DATEPART(YEAR,soh.OrderDate) = DATEPART(YEAR, soh.OrderDate))))*100 AS "% of Total Sale",
STUFF ((SELECT top 5 ', '+RTRIM(CAST (ProductID AS CHAR))
       FROM Sales.SalesOrderDetail sod
       JOIN Sales.SalesOrderHeader AS soh
       ON sod.SalesOrderID = soh.SalesOrderID
       WHERE DATEPART(YEAR,soh.OrderDate) = DATEPART(YEAR,soh.OrderDate)
       GROUP BY ProductID,DATEPART(YEAR, soh.OrderDate)
       ORDER BY SUM(OrderQty) DESC
       FOR XML path('')),1,1,'') AS Top5Products
       FROM Sales.SalesOrderDetail sod
       JOIN Sales.SalesOrderHeader soh
      ON sod.SalesOrderID = soh.SalesOrderID;


-- Part C

WITH Parts(AssemblyID, ComponentID, PerAssemblyQty, EndDate, ComponentLevel) AS
(
 	SELECT b.ProductAssemblyID, b.ComponentID, b.PerAssemblyQty,
 		b.EndDate, 0 AS ComponentLevel
 	FROM Production.BillOfMaterials AS b
 	WHERE b.ProductAssemblyID = 992 AND b.EndDate IS NULL
 	UNION ALL
 	SELECT bom.ProductAssemblyID, bom.ComponentID, p.PerAssemblyQty,
 		bom.EndDate, ComponentLevel + 1
 	FROM Production.BillOfMaterials AS bom
 	INNER JOIN Parts AS p
 	ON bom.ProductAssemblyID = p.ComponentID AND bom.EndDate IS NULL
),
Parts1 AS
(
 	SELECT AssemblyID, ComponentID, Name, PerAssemblyQty, ComponentLevel, (ListPrice * PerAssemblyQty) AS SubTotal
 	FROM Parts AS p
 	INNER JOIN Production.Product AS pt
 	ON p.ComponentID = pt.ProductID
 	GROUP BY AssemblyID, ComponentID, Name, PerAssemblyQty, ComponentLevel, ListPrice
),
Parts2 AS(
 	SELECT ComponentID AS Material, SUM(SubTotal) AS Cost0
 	FROM Parts1
 	WHERE ComponentID = 815
 	GROUP BY ComponentID
),  
Parts3 AS (
	SELECT AssemblyID AS Material, sum(SubTotal) AS Cost1
    FROM Parts1
    WHERE AssemblyID = 815
    GROUP BY AssemblyID
)
SELECT p2.Material, (Cost0 - Cost1) AS Reduction
FROM Parts2 p2 
JOIN Parts3 p3 
ON p2.Material = p3.Material
GROUP BY p2.Material, Cost0, Cost1;

