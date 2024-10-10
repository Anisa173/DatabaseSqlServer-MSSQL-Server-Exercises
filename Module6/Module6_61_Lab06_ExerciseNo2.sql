---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement to retrieve distinct values for the custid column from the Sales.Orders table. 
-- Filter the results to include only orders placed in February 2008.
-- Execute the written statement and compare the results that you got with the desired results shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyra 1
-- 
-- Gjeni vlerat unike per kolonen custid nga tabela Sales.Orders. Filtroni rezultatet per te perfshire vetem porosite 
-- te kryera ne Shkurt te 2008.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 62-Lab Exercise 2- Task 1 Result.txt.
---------------------------------------------------------------------
Select  so.custid ,so.orderid,DATEPART(year,so.orderdate) as year,DATEPART(month,so.orderdate) as month
FROM Sales.Orders as so  WHERE DATEPART(year,so.orderdate) = 2008 and DATEPART(month,so.orderdate) = 2
Order BY so.custid

---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement with these columns:
--  Current date and time
--  First date of the current month
--  Last date of the current month
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt. The results will differ because they rely on the current date.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
-- 
--Selektoni keto kolona:
--1--  Data dhe koha aktuale
--2--  Daten e pare te muajit aktuale
--3--  Daten e fundit te muajit aktuale
--4- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e rekomanduara ne dokumentin 63-Lab Exercise 2- Detyre 2 Results.txt. Rezultate do jene te ndryshme sepse ato varen ne daten aktuale.
---------------------------------------------------------------------
--1--
Select CAST(GETDATE() AS DATE) as dataAktuale, CONVERT(time,getdate()) as kohaAtuale  
--ose--
SELECT CAST(GETDATE() AS DATETIME) as data_kohaAktuale 
--2--
SELECT DATEFROMPARTS(year(GETDATE()),month(GETDATE()),'01') as dite_PareMuajiAktual 
--3--
SELECT EOMONTH((GETDATE())) as dita_funditMuajiAktual 

---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement against the Sales.Orders table and retrieve the orderid, custid, and orderdate columns. 
-- Filter the results to include only orders placed in the last five days of the order month.
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 - Task 3 Result.txt.
---------------------------------------------------------------------
--1--
Select so.orderid,so.custid,so.orderdate
From Sales.Orders as so Order By so.orderdate DESC
--2--
Select so.orderid,so.custid,so.orderdate as OrderDate
From Sales.Orders as so
WHERE so.orderdate between DATEADD(DAY,-5,EOMONTH(so.orderdate)) and EOMONTH(so.orderdate)
Order By so.orderdate DESC
---------------------------------------------------------------------
-- Task 4
-- 
--1-- Write a SELECT statement against the Sales.Orders and Sales.OrderDetails tables and retrieve all the distinct values for the productid column.
--2-- Filter the results to include only orders placed in the first 10 weeks of the year 2007.
--3-- Execute the written statement and compare the results that you got with the recommended result shown in the file 65 - Lab Exercise 2 - Task 4 Result.txt.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1--Distinct values for productId
SELECT DISTINCT sod.productid
FROM Sales.Orders as so INNER JOIN Sales.OrderDetails as sod ON so.orderid = sod.orderid
ORDER BY sod.productid
--2--
SELECT DISTINCT sod.productid,so.orderid
FROM Sales.Orders as so INNER JOIN Sales.OrderDetails as sod ON so.orderid = sod.orderid
--------------------------------------------------------------------------------------------------
SELECT so.orderdate as OrderDate ,so.orderid
From Sales.Orders as so
WHERE so.orderdate between DATEFROMPARTS('2007','01','01') And DATEADD(week,10,'2007-01-01')


---------------------------------------------------------------------
