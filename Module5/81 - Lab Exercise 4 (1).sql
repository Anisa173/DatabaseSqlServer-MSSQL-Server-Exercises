---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--
-- Write a SELECT statement to retrieve the custid, orderid, and orderdate columns from the Sales.Orders table. Order the rows by orderdate and orderid. Retrieve the first 20 rows.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 82 - Lab Exercise 4 - Task 1 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 1
-- Selektoni kolonat custid, orderid, dhe orderdate nga tabela Sales.Orders table.
-- Rradhit rrjeshtat sipas orderdate dhe orderid. Nxjerr 20 rrjeshtat e pare.
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 82 - Lab Exercise 4 - Task 1 Result.txt.
---------------------------------------------------------------------
Select TOP(20) o.custid,o.orderdate
From Sales.Orders o
Order By o.orderdate,o.orderid 
---------------------------------------------------------------------
-- Task 2
-- 
-- Copy the SELECT statement in task 1 and modify the OFFSET-FETCH clause to skip the first 20 rows and fetch the next 20 rows.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 83 - Lab Exercise 4 - Task 2 Result.txt. 
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
-- 
--Kopjo kodin e Detyres 1 dhe modifiko OFFSET-FETCH clause te kalosh 20 rrjeshtat e pare dhe te nxjerresh 20 rrjeshtat e tjere.
--
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 83 - Lab Exercise 4 - Task 2 Result.txt. 
---------------------------------------------------------------------
Select o.custid,o.orderdate
From Sales.Orders o
Order By o.orderdate,o.orderid
OFFSET 0 ROWS FETCH FIRST 20 ROWS ONLY
---Query në 'Detyra2' gjeneron të njëjtin rezultat me atë në 'Detyra1'
Select o.custid,o.orderdate
From Sales.Orders o
Order By o.orderdate,o.orderid
OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY
---Query gjeneron 20 rreshtat e dytë ndryshe nga query e taskut të mesiperm

---------------------------------------------------------------------
-- Task 3
-- 
-- You are given the parameters @pagenum for requested page number and @pagesize for requested page size. Can you work out how to write a generic form of the OFFSET-FETCH clause using those parameters? (Do not worry about not being familiar with those parameters yet.)
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra  3
-- 
--Te jane dhene parametrat @pagenum per numrin e kerkuar te faqes dhe @pagesize per madhesine e kerkuar te faqes. Mund ta zgjidhni se si mund te shkruajme nje forme gjenerike te OFFSET-FETCH clause duke perdorur keto parametra? (Mos u shqetesoni prej faktit qe nuk jeni njohur me keto parametra.)
---------------------------------------------------------------------
