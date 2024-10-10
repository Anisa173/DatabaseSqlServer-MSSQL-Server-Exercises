---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement to retrieve the orderid column from the Sales.Orders table and the total sales amount per orderid.  
-- (Hint: Multiply the qty and unitprice columns from the Sales.OrderDetails table.) Use the alias salesmount 
-- for the calculated column. Sort the result by the total sales amount in descending order.
-- Execute the written statement and compare the results that you got with the desired results 
-- shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt.
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- Detyra 1
-- 
-- Selektoni kolonen orderid nga tabela Sales.Orders dhe shumen totale te shitjeve per orderid. 
-- (Ndihme: Shumezo kolonat qty dhe unitprice nga tabela Sales.OrderDetails.). Perdor alias salesmount per kolonen e perllogaritur.
-- Vendose rezultatin ne rendin zbrites sipas shumes totale te shitjeve.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara 
-- ne dokumentin 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------
Select o.orderid ,SUM(od.unitprice*od.qty) as salesmount
From Sales.Orders o INNER JOIN Sales.OrderDetails od ON o.orderid = o.orderid
group by o.orderid
order By salesmount desc
---------------------------------------------------------------------
-- Task 2
-- 
-- Copy the T-SQL statement in task 1 and modify it to include the total number of order lines for each order and the average order line sales amount value within the order. Use the aliases nooforderlines and avgsalesamountperorderline, respectively.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt. 
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
-- 
-- Kopjoni veprimet T-SQL ne detyren 1 dhe modifikojeni ate per te perfshire numrin total 
-- te order_lines per çdo porosi dhe vleren mesatare te shitjeve order line duke perfshire edhe porosite. 
-- Perdor alias nooforderlines and avgsalesamountperorderline.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 63 - Lab Exercise 2 - Task 2 Result.txt. 
---------------------------------------------------------------------
Select od.orderid ,count(p.productid) as nooforderlines,SUM((od.unitprice*od.qty)*(1-od.discount)) as salesmount,
AVG((od.unitprice*od.qty)*(1-od.discount)) as avgsalesamountperorderline
From Production.Products p INNER JOIN Sales.OrderDetails od ON od.orderid = od.orderid
group by od.orderid
order By salesmount desc


---------------------------------------------------------------------
-- Task 3
-- 
-- Write a select statement to retrieve the total sales amount for each month. The SELECT clause should include a calculated column named yearmonthno (YYYYMM notation) based on the orderdate column in the Sales.Orders table and a total sales amount (multiply the qty and unitprice columns from the Sales.OrderDetails table). Order the result by the yearmonthno calculated column.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 - Task 3 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 3
-- 
-- Nxirrni shumen totale te shitjeve per cdo muaj. Veprimi Select duhet te perfshije nje kolone te perllogaritur 
-- te quajtur yearmonthno (YYYYMM) e bazuar ne kolonen orderdate nga tabela Sales.Orders dhe 
-- shuma totale e shitjeve(shumezimi i kolonave qty dhe unitprice nga tabela Sales.OrderDetails). 
-- Rendit rezultatin sipas kolones se perllogaritur yearmonthno.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 64 - Lab Exercise 2 - Task 3 Result.txt.
---------------------------------------------------------------------
Select  SUM((od.qty * od.unitprice)*(1- od.discount)) as TotalSum_perMonth ,
yearmonth = Concat(Concat( DATENAME(YEAR,o.orderdate),' '), Concat('- ',DATENAME(MONTH,o.orderdate))) 
From Sales.OrderDetails od INNER JOIN Sales.Orders o ON od.orderid = o.orderid
Group by o.orderdate
Order By o.orderdate DESC
---------------------------------------------------------------------
-- Task 4
-- 
-- Write a select statement to retrieve all the customers (including those that did not place any orders) and their total sales amount, maximum sales amount per order line, and number of order lines. 
--
-- The SELECT clause should include the custid and contactname columns from the Sales.Customers table and four calculated columns based on appropriate aggregate functions:
--  totalsalesamount, representing the total sales amount per order
--  maxsalesamountperorderline, representing the maximum sales amount per order line
--  numberofrows, representing the number of rows (use * in the COUNT function)
--  numberoforderlines, representing the number of order lines (use the orderid column in the COUNT function)
--
-- Order the result by the totalsalesamount column.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 65 - Lab Exercise 2 - Task 4 Result.txt. 
--
-- Notice that the custid 22 and 57 rows have a NULL in the columns with the SUM and MAX aggregate functions. What are their values in the COUNT columns? Why are they different?
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 4
-- 
-- Afishoni te gjithe klientet (perfshire edhe ata qe nuk kane bere ndonje porosi) dhe shumen e tyre totale te shitjeve, 
-- shumen maksimale te shitjes per çdo order line, dhe numrin e order lines. 
-- The SELECT clause should include the custid and contactname columns from the Sales.Customers table and 
-- four calculated columns based on appropriate aggregate functions:
-- totalsalesamount, representing the total sales amount per order
-- maxsalesamountperorderline, representing the maximum sales amount per order line
-- numberofrows, representing the number of rows (use * in the COUNT function)
-- numberoforderlines, representing the number of order lines (use the orderid column in the COUNT function)
--
-- Rendit rezultatin sipas kolones totalsalesamount.
--
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 65 - Lab Exercise 2 - Task 4 Result.txt. 
--
-- Vini re qe custid ne rrjeshtat 22 dhe 57 ka NULL ne kolonat me funksione agregate te SUM dhe MAX. 
-- Cilat jane vlerat e tyre ne kolonen COUNT? Pse jane ato te ndryshme?
----------------------------------------------------------------------------
Select c.custid,c.contactname,p.productid,SUM((od.unitprice * od.qty)*(1 - od.discount)) as totalsalesamount , 
MAX((od.unitprice * od.qty)*(1 - od.discount)) as maxsalesamountperorderline,Count(p.productid) as numberoforderlines 
From Production.Products p INNER JOIN Sales.OrderDetails od ON p.productid = od.productid
                           INNER JOIN Sales.Orders o ON od.orderid = o.orderid
						   right join Sales.Customers c ON o.custid = c.custid					   
 Group by c.custid,c.contactname,p.productid
 Order by totalsalesamount Desc