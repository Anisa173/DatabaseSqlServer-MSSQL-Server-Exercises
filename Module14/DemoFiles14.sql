-- Demonstration A
-- Step 1: Open a new query window to the TSQL database
USE TSQL;
GO
IF OBJECT_ID('Sales.CategoryQtyYear','V') IS NOT NULL DROP VIEW Sales.CategoryQtyYear
GO


-- Step 2: Create view for inner derived table (for screen space/convenience)
CREATE VIEW Sales.CategoryQtyYear
AS
SELECT  c.categoryname AS Category,
        od.qty AS Qty,
        YEAR(o.orderdate) AS Orderyear
FROM    Production.Categories AS c
        INNER JOIN Production.Products AS p ON c.categoryid=p.categoryid
        INNER JOIN Sales.OrderDetails AS od ON p.productid=od.productid
        INNER JOIN Sales.Orders AS o ON od.orderid=o.orderid;
GO 


-- Step 3: Test view, review data
SELECT  Category, Qty,Orderyear
FROM Sales.CategoryQtyYear;


-- Step 4: PIVOT and UNPIVOT

-- PIVOT categories on orderyear
SELECT  Category, [2006],[2007],[2008]
FROM    Sales.categProductReport_Anisa as c
    PIVOT(SUM(QTY) FOR orderyear IN ([2006],[2007],[2008])) AS pvt
ORDER BY Category;

Create View Sales.categProductReport_Anisa
AS
SELECT  v.Category, v.Qty, v.Orderyear FROM Sales.CategoryQtyYear v
GO



-- Step 5: Setup for UNPIVOT demo
-- Pivot categories on orderyear, save to temp table
-- Create staging table to hold pivoted data
CREATE TABLE [Sales].[PivotedCategorySales](
	[Category] [nvarchar](15) NOT NULL,
	[2006] [int] NULL,
	[2007] [int] NULL,
	[2008] [int] NULL);
GO
-- Populate it by pivoting from view
INSERT INTO Sales.PivotedCategorySales (Category, [2006],[2007],[2008])
SELECT Category, [2006],[2007],[2008] 
FROM (SELECT  Category, Qty, Orderyear FROM Sales.CategoryQtyYear) AS D 
    PIVOT(SUM(QTY) FOR orderyear IN ([2006],[2007],[2008]))AS p

-- Test staging table    
SELECT Category, [2006],[2007],[2008]
FROM Sales.PivotedCategorySales

-- Step 6: UNPIVOT
SELECT category, qty, orderyear
FROM Sales.PivotedCategorySales
UNPIVOT(qty FOR orderyear IN([2006],[2007],[2008])) AS unpvt;


-- Step 7: Clean up
IF OBJECT_ID('Sales.CategoryQtyYear','V') IS NOT NULL DROP VIEW Sales.CategoryQtyYear
IF OBJECT_ID('Sales.PivotedCategorySales') IS NOT NULL DROP TABLE Sales.PivotedCategorySales
GO

-- Demonstration A
-- Step 1: Open a new query window to the TSQL database
USE TSQL;
GO


-- Step 2: Setup objects for demo
IF OBJECT_ID('Sales.CategorySales','V') IS NOT NULL DROP VIEW Sales.CategorySales
GO
CREATE VIEW Sales.CategorySales
AS
SELECT  c.categoryname AS Category,
        o.empid AS Emp,
        o.custid AS Cust,
        od.qty AS Qty,
        YEAR(o.orderdate) AS Orderyear
FROM    Production.Categories AS c
        INNER JOIN Production.Products AS p ON c.categoryid=p.categoryid
        INNER JOIN Sales.OrderDetails AS od ON p.productid=od.productid
        INNER JOIN Sales.Orders AS o ON od.orderid=o.orderid
WHERE c.categoryid IN (1,2,3) AND o.custid BETWEEN 1 AND 5; --limits results for slides
GO

-- Step 3: Show query without use of grouping sets
SELECT Category, NULL AS Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY category
UNION ALL 
SELECT  NULL, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY cust 
UNION ALL
SELECT NULL, NULL, SUM(Qty) AS TotalQty
FROM Sales.CategorySales;

-- Step 4: Query with grouping sets
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY 
GROUPING SETS((Category),(Cust),())
ORDER BY Category, Cust;

-- Step 5: Query with CUBE
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY CUBE(Category,Cust)
ORDER BY Category, Cust;

-- Step 6: With ROLLUP
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY ROLLUP(Category,Cust)
ORDER BY Category, Cust;

-- Step 7: Using GROUPING_ID
SELECT	GROUPING_ID(Category)AS grpCat, GROUPING_ID(Cust) AS grpCust, 
		Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY ROLLUP(Category,Cust)
ORDER BY Category, Cust;

-- Step 8: Clean up
IF OBJECT_ID('Sales.CategorySales','V') IS NOT NULL DROP VIEW Sales.CategorySales
GO


