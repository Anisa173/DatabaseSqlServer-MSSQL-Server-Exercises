---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 2
-- 
--1-- Write a SELECT statement that will return groups of customers that made a purchase. 
-- The SELECT clause should include the custid column from the Sales.Orders table and the contactname column 
-- from the Sales.Customers table. from the Sales.Customers table.
--2-- Group by both columns and filter only the orders from the employee's sales whose empid equals five.
--3-- Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 - Task 1 Result.txt.
---------------------------------------------------------------------
--1--
--M1--
Select c.custid , c.contactname
From Sales.Customers c  
Where c.custid IN(
               Select o.custid
               From Sales.Orders o INNER JOIN Sales.Customers c ON o.custid = c.custid
               having(count(o.orderid))= 1              
)
order by c.custid,c.contactname
--M2--
Select c.custid , c.contactname,COUNT(o.orderid) as order_per_Client
From Sales.Customers c  INNER JOIN Sales.Orders o ON o.custid = c.custid
group by c.custid,c.contactname
having(count(o.orderid))= 1              
--2--
--m1--
Select  c.custid , c.contactname
From Sales.Customers c INNER JOIN Sales.Orders o On c.custid = o.custid
Where o.empid IN (Select e.empid
                   From Sales.Orders o INNER JOIN HR.Employees e ON o.empid = e.empid 
                   Having(count(o.orderid))=5
)
order by c.custid,c.contactname
--M2
Select  c.custid , c.contactname,count(o.orderid) as numriPorosiveClient
From Sales.Customers c INNER JOIN Sales.Orders o On c.custid = o.custid
                       INNER JOIN HR.Employees e ON o.empid = e.empid 
group by c.custid,c.contactname
Having(count(o.orderid))=5

-----------------------------------------------------------------------------------------------
-- Detyra 2
-- 
-- Nxjerrni grupin e personave qe kane bere blerje. Veprimi SELECT duhet te perfshije kolonen custid nga tabela Sales.Orders dhe kolonen contactname nga tabela Sales.Customers. Grupoj te dy kolonat dhe filtro vetem porosite nga te cilat shitja e punonjesve eshte e barabarte me 5. 
--
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 52 - Lab Exercise 1 - Task 1 Result.txt.
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 3
-- 
-- Copy the T-SQL statement in task 2 and modify it to include the city column from the Sales.Customers table in the SELECT clause. 
--
-- Execute the query. You will get an error. What is the error message? Why?
--
-- Correct the query so that it will execute properly.
--
-- Execute the query and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 2 Result.txt.
---------------------------------------------------------------------

-- error

---------------------------------------------------------------------
-- Detyra 3
-- 
-- Kopjoni veprimet T-SQL ne detyren 2  dhe modifikojeni ate per te perfshire kolonen city nga tabela Sales.Customers  
-- ne veprimin SELECT.
-- Ekzekutoni query-in. Ju do keni nje gabim. Cfare eshte ky mezash gabimi? Pse?
--
-- Rregulloni query qe te ekzekutohet ahtu sic duhet.
--
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 53 - Lab Exercise 1 - Task 2 Result.txt.
---------------------------------------------------------------------
--1--
Select c.custid,c.city,c.contactname,COUNT(o.orderid) as order_per_Client
From Sales.Customers c  INNER JOIN Sales.Orders o ON o.custid = c.custid
group by c.custid,c.contactname,c.city
having(count(o.orderid))= 1 
--2--
Select  c.custid,c.city , c.contactname,count(o.orderid) as numriPorosiveClient
From Sales.Customers c INNER JOIN Sales.Orders o On c.custid = o.custid
                       INNER JOIN HR.Employees e ON o.empid = e.empid 
group by c.custid,c.contactname,c.city
Having(count(o.orderid))=5
---------------------------------------------------------------------
-- Task 4
-- 
-- Write a SELECT statement that will return groups of rows based on the custid column and a calculated column orderyear representing the order year based on the orderdate column from the Sales.Orders table. Filter the results to include only the orders from the sales employee whose empid equal five.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 - Task 3 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 4
-- 
-- Nxirrni nje grup rreshta te bazuara ne kolonen custid dhe kolonen e perllogaritur orderyear qe perfaqeson vitin 
-- bazuar ne kolonen orderdate nga tabela Sales.Orders. 
-- Filtro rezultatin per te perfshire vetem porosite nga shitjet e punonjesve te cilat empid eshte e barabarte me 5.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 54 - Lab Exercise 1 - Task 3 Result.txt.
---------------------------------------------------------------------
Select  c.custid,c.city , c.contactname,count(o.orderid) as numriPorosiveClient,Month(o.orderdate) as orderyear
From Sales.Customers c INNER JOIN Sales.Orders o On c.custid = o.custid
                       INNER JOIN HR.Employees e ON o.empid = e.empid 
group by c.custid,c.contactname,c.city,Month(o.orderdate)
Having(count(o.orderid))=5

---------------------------------------------------------------------
-- Task 5
-- 
-- Write a SELECT statement to retrieve groups of rows based on the categoryname column in the Production.Categories table. Filter the results to include only the product categories that were ordered in the year 2008.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 55 - Lab Exercise 1 - Task 4 Result.txt. 
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 5
-- 
-- Nxirrni nje grup rreshta te bazuara ne kolonen 'categoryname' ne tabelen Production.Categories. 
-- Filtro rezultatin per te perfshire vetem kategorite e produkteve qe ishin porositur ne vitin 2008.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret 
-- me rezultatet e deshiruara te treguara ne dokumentin 55 - Lab Exercise 1 - Task 4 Result.txt. 
---------------------------------------------------------------------
  Select c.categoryname,year(o.orderdate) as Year,p.productid
  From Production.Categories c inner join Production.Products p ON c.categoryid = p.categoryid
                               inner join Sales.OrderDetails od ON p.productid = od.productid
							   inner join Sales.Orders o ON od.orderid = o.orderid
  Where YEAR(o.orderdate) = 2008

