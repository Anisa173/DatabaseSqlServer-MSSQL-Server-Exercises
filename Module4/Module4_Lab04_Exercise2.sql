---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--
-- Execute the query exactly as written inside a query window and observe the result.
--
-- You get an error. What is the error message? Why do you think you got this error? 
---------------------------------------------------------------------
Select * From Sales.Customers INNER JOIN Sales.Orders ON Customers.custid = Orders.custid;

SELECT 
	custid, contactname, orderid
FROM Sales.Customers  
INNER JOIN Sales.Orders ON Customers.custid = Orders.custid;

---------------------------------------------------------------------
--  Detyre 1
-- 
--
-- Ekzekuto query ekzaktesisht ashtu sic eshte shkruar brenda ne dritaren e query-se dhe observo rezultatin .
--
-- Ju do keni nje gabim. Cfare eshte mesazhi i gabimit? Pse mendoni qe e keni kete gabim? 
---------------------------------------------------------------------

SELECT 
	custid, contactname, orderid
FROM Sales.Customers  
INNER JOIN Sales.Orders ON Customers.custid = Orders.custid;
  
--Raporte të renditura si me poshtë
Select cust.custid CustomerId,cust.contactname ContactName,ord.orderid OrderId
From Sales.Customers cust INNER JOIN Sales.Orders ord ON cust.custid = ord.custid  
Order By OrderId

Select *
From Sales.Customers cust INNER JOIN Sales.Orders ord ON ord.custid = cust.custid  
Order By ord.orderid
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 2
-- 
-- Notice that there are full source table names written as table aliases. 
--
-- Apply the needed changes to the SELECT statement so that it will run without an error. Test the changes by executing the T-SQL statement.
--
-- Observe and compare the results that you got with the recommended result shown in the file 62 - Lab Exercise 2 - Task 2 Result.txt. 
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyre 2
-- 
-- Vini re se ekzistojne plote emra te tabelave te burimit te shkruara si alias te tabelave. 
--
-- Beni ndryshimet e duhura te veprimet e mesiperme qe te ekzekutohet pa asnje gabim. Testoni ndryshimet duke ekzekutuar T-SQL statement.
--
-- Observo dhe krahaso rezultatet qe ju moret me rezultatet e rekomanduara te treguara ne dokumentin 62 - Lab Exercise 2 - Task 2 Result.txt. 
---------------------------------------------------------------------

Select cust.custid CustomerId,cust.contactname ContactName,ord.orderid OrderId
From Sales.Customers cust INNER JOIN Sales.Orders ord ON cust.custid = ord.custid  

Select *
From Sales.Customers cust INNER JOIN Sales.Orders ord ON cust.custid = ord.custid
--Raporte të renditura si me poshtë
Select cust.custid CustomerId,cust.contactname ContactName,ord.orderid OrderId
From Sales.Customers cust INNER JOIN Sales.Orders ord ON cust.custid = ord.custid  
Order By OrderId

Select *
From Sales.Customers cust INNER JOIN Sales.Orders ord ON cust.custid = ord.custid  
Order By ord.orderid

---------------------------------------------------------------------
-- Task 3
-- 
-- Copy the T-SQL statement from task 2 and modify it to use the table aliases “C” for the Sales.Custumers table and “O” for the Sales.Orders table.
--
-- Execute the written statement and compare the results with the results in task 2.
--
-- Change the prefix of the columns in the SELECT statement with full source table names and execute the statement.
--
-- You get an error. Why?
--
-- Change the SELECT statement to use the table aliases written at the beginning of the task.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyre 3
-- 
-- Kopjo T-SQL statement nga Detyra 2 dhe modefikojeni ate duke perdorur alias-in “C” per tabelen the Sales.Custumers dhe “O” per tabelen Sales.Orders.
-- Ekzekutoni keto veprime dhe krahasoni rezultatet me rezultatet ne Detyren 2.
-- Ndryshoni prefix e kolonave  me emrat e plote te burimeve dhe ekzekutoni keto veprime.
-- Ju del nje gabim. Pse?
-- Beni ndryshime duke perdorur alias e tabelave te shkruajtuara si ne fillim te detyres. 
---------------------------------------------------------------------
Select C.custid CustomerId,C.contactname ContactName,O.orderid OrderId
From Sales.Customers C INNER JOIN Sales.Orders O ON C.custid = O.custid  
Select *
From Sales.Customers C INNER JOIN Sales.Orders O ON C.custid = O.custid  
---------------------------------------------------------------------
-- Task 4
-- 
-- Copy the T-SQL statement from task 3 and modify it to include three additional columns from the Sales.OrderDetails table: productid, qty, and unitprice.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 4 Result.txt. 
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyre 4
-- 
-- Kopjo T-SQL statement nga Detyra 3 dhe modefikoni ate duke perfshire tre kolona nga tabela Sales.OrderDetails: productid, qty, dhe unitprice.
--
-- Ekzekutoni veprimet dhe krahasoni rezultatet qe ju moret me rezultatet e rekomanduara ne dokumentin 63 - Lab Exercise 2 - Task 4 Result.txt. 
---------------------------------------------------------------------
Select cust.custid CustomerId,cust.contactname ContactName,ord.orderid OrderId,orderD.productid ProductId,orderD.qty Qty,orderD.unitprice UnitPrice
From Sales.Orders  ord INNER JOIN Sales.Customers cust ON ord.custid = cust.custid  
INNER JOIN Sales.OrderDetails orderD ON ord.orderid = orderD.orderid 

Select *
From Sales.Orders  ord INNER JOIN Sales.Customers cust ON ord.custid = cust.custid  
INNER JOIN Sales.OrderDetails orderD ON ord.orderid = orderD.orderid 