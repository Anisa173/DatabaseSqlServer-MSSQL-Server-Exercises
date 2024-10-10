---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- 1- Write a SELECT statement that will return the productname column from the Production.Products table (use table alias “p”)
--    and the categoryname column from the Production.Categories table (use table alias “c”) using an inner join. 
-- 2- Execute the written statement and compare the results that you got with the desired results 
-- Which column did you specify as a predicate in the ON clause of the join? Why?
-- 3- Let us say that there is a new row in the Production.Categories table and this new product
-- category does not have any products associated with it in the Production.Products table. 
-- 4- Would this row be included in the result of the SELECT statement written in task 1? Please explain.
----------------------------------------------------------------------------------------------------------------------------------------
Select p.productname ProductName,c.categoryname CategoryName
From Production.Products p INNER JOIN Production.Categories c ON p.categoryid = c.categoryid
SELECT * From Production.Products p INNER JOIN Production.Categories c ON p.categoryid = c.categoryid
Insert into Production.Categories(categoryname,description)
VALUES('Homemade sweets','Coconut ice,Chocolate Biscuit cake,Chocolate Salame,Popcorn Bars')
Select * From Production.Categories





