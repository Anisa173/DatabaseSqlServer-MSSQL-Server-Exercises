---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- 
-- Write a SELECT statement against the Sales.Orders table and retrieve the orderid and orderdate columns. 
-- Retrieve the 20 most recent orders, ordered by orderdate.
--
-- Execute the written statement and compare the results that you got with the recommended result 
-- shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyre 1
-- Selektoni kolonat orderid dhe orderdate nga tabela Sales.Orders. 
-- Nxjerr 20 porosite me te fundit, te radhitura sipas orderdate.
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara
-- ne dokumentin 72 - Lab Exercise 3 - Task 1 Result.txt.
---------------------------------------------------------------------
Select  TOP(20) o.orderid , o.orderdate
From Sales.Orders o
Order By o.orderdate DESC
-- Afisho të gjitha porositë duke u nisur nga veprimet më të fundit
Select  o.orderid , o.orderdate
From Sales.Orders o
Order By o.orderdate DESC

---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to retrieve the same result as in task 1, but use the OFFSET-FETCH clause.
--
-- Execute the written statement and compare the results that you got with the results from task 1.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
-- 
-- Realizoni te njejtat veprime si ne Detyren 1, por perdorni OFFSET-FETCH clause.
--
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet nga Detyra 1.
---------------------------------------------------------------------
Select  o.orderid , o.orderdate
From Sales.Orders o
Order By o.orderdate DESC
OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY

-- Afisho të gjitha porositë duke u nisur nga veprimet më të fundit
Select  o.orderid , o.orderdate
From Sales.Orders o
Order By o.orderdate DESC

---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement to retrieve the productname and unitprice columns 
-- from the Production.Products table.
-- Execute the T-SQL statement and notice the number of the rows returned.
-- 
-- Modify the SELECT statement to include only the top 10 percent 
-- of products based on unitprice ordering.
-- Execute the written statement and compare the results that you got with 
-- the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt. 
-- Notice the number of rows returned.
-- Is it possible to implement this task with the OFFSET-FETCH clause?
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 3
-- 
--1-- Selektoni kolonat productname dhe unitprice nga tabela Production.Products.
--2-- Ekzekuto kodin T-SQL dhe vini re numrin e rrjeshtave qe u kthyen.
--3-- Modifiko kodin qe te perfshije vetem 10 perqind te produkteve me te mira 
   -- duke u bazuar ne unitprice ordering.
--5-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara 
-- -- ne dokumentin 73  - Lab Exercise 3 - Task 2 Result.txt. Notice the number of rows returned.
--6-- A eshte e mundur te implementohet kjo detyre me OFFSET-FETCH clause?
---------------------------------------------------------------------
--1--
select p.productname,p.unitprice
from Production.Products p
--2- U ekzekutua me sukses query e mesiperme
--3--
select TOP(10) PERCENT p.productname,p.unitprice
From Production.Products p
Order by p.unitprice DESC
--5-- U ekzekutua me sukses
--6--
select p.productname,p.unitprice
From Production.Products p
Order by p.unitprice DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY
