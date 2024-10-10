---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--
-- Write a SELECT statement to retrieve the custid and contactname columns from the Sales. 
-- Customers table and the orderid column from the Sales.Orders table.
-- The statement should retrieve all rows from the Sales.Customers table.
-- Execute the written statement and compare the results that you got with 
-- the recommended result shown in the file 82 - Lab Exercise 4 - Task 1 Result.txt. 
-- Notice the values in the column orderid. Are there any missing values (marked as NULL)? Why? 
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyre 1
-- Selektoni kolonat custid and contactname nga tabela Sales.Customers dhe kolonen orderid nga tabela Sales.Orders. 
-- Veprimet e shkruara duhet te nxjerrin te gjitha rrjeshtat nga tabela Sales.Customers.
-- Ekzekutoni veprimet dhe krahasoni rezultatet qe moret me rezultatet e rekomanduara 
-- ne dokumentin 82 - Lab Exercise 4 - Task 1 Result.txt. 
--
-- Vereni vlerat ne kolonen orderid. A ka ndonje vlere qe mungon (te shenuara si NULL)? Pse? 
---------------------------------------------------------------------
Select c.custid cId ,c.contactname ContactName,o.orderid OrderId 
From Sales.Customers c INNER JOIN Sales.Orders o ON c.custid=o.custid 


