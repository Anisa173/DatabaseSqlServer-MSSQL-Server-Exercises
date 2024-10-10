---------------------------------------------------------------------
-- LAB 14
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- The IT department has provided you with T-SQL code to generate a view named Sales.CustGroups, 
-- which contains three pieces of information about customers: their IDs, the countries in which they are located, 
-- and the customer group in which they have been placed. Customers are placed into one of three predefined 
-- customers groups (A, B, or C).Execute the provided T-SQL code.
--
--1-- Write a SELECT statement that will return the custid, custgroup, and country columns  
--    from the newly created Sales.CustGroups view.
CREATE VIEW Sales.CustGroups AS
SELECT 
	custid,
	CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,
	country
FROM Sales.Customers;
GO
------

Select sc.custid , sc.custgroup , sc.country
FROM Sales.CustGroups AS sc

--1.1-- Execute the written statement and compare the results that you got with the desired results 
-- shown in the file 52 - Lab Exercise 1 - Task 1_1 Result.txt.
--2-- Modify the SELECT statement. Begin by retrieving the column country. Then use the PIVOT operator 
-- to retrieve three columns based on the possible values of the custgroup 
-- column (values A, B, and C), showing the number of customers in each group.
Select [country] , [A] ,[B] ,[C]
From (SELECT 
	custid,
	CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,
	country
FROM Sales.Customers
) as sel
PIVOT(COUNT(custid) FOR custgroup IN ([A],[B],[C]) ) AS pvt 
Order By [country]

go


--2.1-- Execute the modified statement and compare the results that you got with the desired results 
-- shown in the file 53 - Lab Exercise 1 - Task 1_2 Result.txt.
---------------------------------------------------------------------
**Executed Succesfully
--------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 2
-- 
--1-- The IT department has provided T-SQL code to add two new columns—city and contactname—to 
-- the Sales.CustGroups view. Execute the provided T-SQL code.
ALTER VIEW Sales.CustGroups AS
SELECT 
	custid,
	CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,
	country,
	city,
	contactname
FROM Sales.Customers;

GO
----------------View is updated SUCCESFULLY

-- Copy the last SELECT statement in task 1 and execute it. 
--Task1
SELECT 
	custid,
	CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,
	country
FROM Sales.Customers
--Task2
SELECT 
	custid,
	CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,
	country,
	city,
	contactname
	FROM Sales.Customers

-- Is this result the same as the result from the query in task 1? Is the number of rows retrieved the same? 
-- To better understand the reason for the different results, modify the copied SELECT statement
-- to include the new city and contactname columns.
-- Execute the modified statement and compare the results that you got with the desired results
-- shown in the file 54 - Lab Exercise 1 - Task 2 Result.txt.
-- Notice that this query returned the same number of rows as the previous SELECT statement.  
-- Why did you get the same result with and without specifying the grouping columns for the PIVOT operator?
-- 
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 3
-- 
--1-- Define a CTE named PivotCustGroups based on a query that retrieves the custid, country, 
-- and custgroup columns from the Sales.CustGroups view. Write a SELECT statement against the CTE, 
-- using a PIVOT operator to retrieve the same result as in task 1. 
--1--
WITH CTE_PivotCustGroups
as
(Select [custid]  CustomerId, [A],[B],[C]
From (SELECT 
	custid,
	CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,
	country,
	city,
	contactname
FROM Sales.Customers) AS c
PIVOT (COUNT(country) FOR custgroup IN ([A],[B],[C])) AS pvt
)
Select * From CTE_PivotCustGroups
GO
--2--
WITH CTE_PivotCustGroupss
as
(SELECT 
	c.custid as CustomerID,
	CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,
	c.country as Country,
	c.city,
	c.contactname
FROM Sales.Customers as c
)

Select CustomerID , pvg.[A],pvg.[B],pvg.[C]
FROM CTE_PivotCustGroupss AS pv
PIVOT(COUNT(pv.Country) FOR pv.custgroup IN ([A],[B],[C])) AS pvg
GO
--3--
WITH CTE_PivotCustGroups
as
(Select [country] , [A] ,[B] ,[C]
From (SELECT custid,CHOOSE(custid % 3 + 1, N'A', N'B', N'C') AS custgroup,country,city,
	contactname
FROM Sales.Customers
) as sel
PIVOT(COUNT(custid) FOR custgroup IN ([A],[B],[C]) ) AS pvt 
)
Select * From CTE_PivotCustGroups
GO

--2-- Execute the written T-SQL code and compare the results that you got with the desired results 
-- shown in the file 55 - Lab Exercise 1 - Task 3 Result.txt.
-- Is this result the same as the one returned by the last query in task 1? Can you explain why?
--
-- Why do you think it is beneficial to use the CTE when using the PIVOT operator?
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 4
-- 
--1-- For each customer, write a SELECT statement to retrieve the total sales amount for each product category. 
-- Display each product category as a separate column. Here is how to accomplish this task:
-- Create a CTE named SalesByCategory to retrieve the custid column from the Sales.Orders table as a calculated column 
-- based on the qty and unitprice columns and the categoryname column from the table Production.Categories. 
-- Filter the result to include only orders in the year 2008.
-- You will need to JOIN tables Sales.Orders, Sales.OrderDetails, Production.Products and Production.Categories.
WITH CTE_SalesByCategory
AS
(Select sl.CustomerID as CustomerId, SUM(sl.totalSalesOrder) as TotalSales ,sl.CategoryId ,sl.CategoryName 
From(
Select o.custid as CustomerID ,o.orderid, SUM((od.unitprice*od.qty)*(1-od.discount)) as totalSalesOrder, 
pc.categoryid CategoryId,pc.categoryname CategoryName
From Sales.Orders o   inner join Sales.OrderDetails od ON o.orderid = od.orderid 
                       inner join Production.Products pp ON od.productid =  pp.productid
					   inner join Production.Categories pc ON pp.categoryid = pc.categoryid
Where year(o.orderdate) = 2008
Group By o.custid,o.orderid , pc.categoryid , pc.categoryname) as sl
--Order By c.custid
Group By sl.CustomerID,sl.CategoryId ,sl.CategoryName  
--Order By CustomerID
)

Select [CustomerId], pvt.[Beverages],pvt.[Condiments],pvt.[Confections],pvt.[Dairy_Products],pvt.[Grains/Cereals],pvt.[Meat/Poultry],pvt.[Produce],pvt.[Seafood]
From CTE_SalesByCategory as ctcs
PIVOT(SUM(ctcs.TotalSales) FOR categoryname IN ([Beverages],[Condiments],[Confections],[Dairy_Products]
,[Grains/Cereals],[Meat/Poultry],[Produce],[Seafood])) as pvt
Order By CustomerId
GO


--2-- Write a SELECT statement against the CTE that returns a row for each customer (custid) and a column 
-- for each product category, with the total sales amount for the current customer and product category. 
-- Display the following product categories: Beverages, Condiments, Confections, [Dairy Products], 
-- [Grains/Cereals], [Meat/Poultry], Produce, and Seafood..
-- Execute the complete T-SQL code (the CTE and the SELECT statement).
-- Observe and compare the results that you got with the desired results shown 
-- in the file 56 - Lab Exercise 1 - Task 4 Result.txt. 
---------------------------------------------------------------------

---------------------------------------------------------------------
-- LAB 14
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--1-- Execute the provided T-SQL code to generate the Sales.PivotCustGroups view:
--2-- Write a SELECT statement to retrieve the country, A, B, and C columns from the Sales.PivotCustGroups view.
-- Execute the written statement and compare the results that you got with the desired results 
-- shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt. 
---------------------------------------------------------------------
--1--
CREATE VIEW Sales.PivotCustGroups AS

(
	SELECT 
		custid,
		country,
		custgroup
	FROM Sales.CustGroups
)
GO
--2--
SELECT country,p.A,p.B,p.C
FROM Sales.PivotCustGroups pp
PIVOT (COUNT(custid) FOR custgroup IN (A, B, C)) AS p

GO
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement against the Sales.PivotCustGroups view that returns the following:
--  A row for each country and customer group. 
--  The column country.
--  Two new columns—custgroup and numberofcustomers. The custgroup column should hold the names 
--  of the source columns A, B, and C as character strings, and 
-- the numberofcustomers column should hold their values (i.e., number of customers).
-- Execute the T-SQL code and compare the results that you got with the recommended result 
-- shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt. 
---------------------------------------------------------------------
Select pcg.custgroup,count(pcg.custid) as numberOfCustomers
From Sales.PivotCustGroups pcg
group by pcg.custgroup
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 3
-- 
-- Remove the created views by executing the provided T-SQL code. Execute this code exactly as written inside a query window.
---------------------------------------------------------------------

DROP VIEW Sales.CustGroups;
DROP VIEW Sales.PivotCustGroups;
---------------------------------------------------------------------
---------------------------------------------------------------------
-- LAB 14
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement against the Sales.Customers table and retrieve the country column,
--  the city column, and a calculated column noofcustomers as a count of customers. 
-- Retrieve multiple grouping sets based on the country and city columns, the country column, 
-- the city column, and a column with an empty grouping set.
-- Execute the written statement and compare the results that you got with the recommended 
-- result shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt. 
---------------------------------------------------------------------
Select sc.country , sc.city ,noofcustomers = COUNT(sc.custid)
From Sales.Customers sc
GROUP BY --sc.country , sc.city
GROUPING SETS ((sc.country) , (sc.city),())
order by sc.country , sc.city
--------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement against the view Sales.OrderValues and retrieve these columns:
--  Year of the orderdate column as orderyear
--  Month of the orderdate column as ordermonth
--  Day of the orderdate column as orderday
--  Total sales value using the val column as salesvalue
-- Return all possible grouping sets based on the orderyear, ordermonth, and orderday columns.
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt. Notice the total number of rows in your results.
---------------------------------------------------------------------
Select year(ov.orderdate) as orderyear , month(ov.orderdate) as ordermonth,
 day(ov.orderdate) as orderday,Sum(ov.val) as salesValue
From Sales.OrderValues ov
Group by 
Grouping Sets((year(ov.orderdate)),(month(ov.orderdate)),(day(ov.orderdate)),())
---------------------------------------------------------------------
-- Task 3
-- 
-- Copy the previous query and modify it to use the ROLLUP subclause instead of the CUBE subclause.
--
Select year(ov.orderdate) as orderyear , month(ov.orderdate) as ordermonth,
 day(ov.orderdate) as orderday,Sum(ov.val) as salesValue
From Sales.OrderValues ov
Group by rollup
((year(ov.orderdate)),(month(ov.orderdate)),(day(ov.orderdate)))

-- Execute the modified query and compare the results that you got with the recommended result shown in the file 74 - Lab Exercise 3 - Task 3 Result.txt. Notice the number of rows in your results.
--
-- What is the difference between the ROLLUP and CUBE subclauses?
--using CUBE
Select year(ov.orderdate) as orderyear , month(ov.orderdate) as ordermonth,
 day(ov.orderdate) as orderday,Sum(ov.val) as salesValue
From Sales.OrderValues ov
Group by cube
((year(ov.orderdate)),(month(ov.orderdate)),(day(ov.orderdate)))
Order By orderyear , ordermonth,orderday
-- Which is the more appropriate subclause to use in this example?
rollup
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 4
-- 
-- Write a SELECT statement against the Sales.OrderValues view and retrieve these columns:
--  Calculated column with the alias groupid (use the GROUPING_ID function with the order year 
-- and order month as the input parameters) Year of the orderdate column as orderyear
--  Month of the orderdate column as ordermonth
--  Total sales value using the val column as salesvalue.
-- Since year and month form a hierarchy, return all interesting grouping sets based on the orderyear 
-- and ordermonth columns and sort the result by groupid, orderyear, and ordermonth.
-- Execute the written statement and compare the results that you got with the recommended result 
-- shown in the file 75 - Lab Exercise 3 - Task 4 Result.txt. 
---------------------------------------------------------------------
--1--
Select  GROUPING_ID(year(ov.orderdate),month(ov.orderdate)) groupid,year(ov.orderdate) as orderyear,
month(ov.orderdate) as ordermonth, SUM(ov.val) as salesvalue
From Sales.OrderValues ov
Group by ROLLUP( year(ov.orderdate),month(ov.orderdate))
order by groupid,orderyear,ordermonth
go
--2--
Select  GROUPING_ID(year(ov.orderdate),month(ov.orderdate)) groupid,year(ov.orderdate) as orderyear,
month(ov.orderdate) as ordermonth, SUM(ov.val) as salesvalue
From Sales.OrderValues ov
Group by cube( year(ov.orderdate),month(ov.orderdate))
order by groupid,orderyear,ordermonth
go
--3--
Select  GROUPING_ID(year(ov.orderdate),month(ov.orderdate)) groupid,year(ov.orderdate) as orderyear,
month(ov.orderdate) as ordermonth, SUM(ov.val) as salesvalue
From Sales.OrderValues ov
Group by 
GROUPING SETS ((year(ov.orderdate),month(ov.orderdate)),
              (year(ov.orderdate)),
              (month(ov.orderdate)))
order by groupid,orderyear,ordermonth
go