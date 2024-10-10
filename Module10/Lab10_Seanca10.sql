---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 1
---------------------------------------------------------------------
USE TSQL;
GO
---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement to return the maximum order data from the table Sales.Orders.
-- Execute the written statement and compare the results that you got with
-- the desired results shown in the file 52 - Lab Exercise 1 - Task 1 Result.txt.
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
-- Detyra 1
-- 
-- Ktheni maksimunin e e dates se porosise nga tabela Sales.Orders.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet
-- e deshiruara te treguara ne dokumentin 52 - Lab Exercise 1 - Task 1 Result.txt.
---------------------------------------------------------------------
Select max(o.orderdate) as maximumOrderDate
From Sales.Orders as o
---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to return the orderid, orderdate, empid, and custid 
-- columns from the Sales.Orders table. Filter the results to include only orders 
-- where the date order equals the last order date. 
-- (Hint: Use the query in task 1 as a self-contained subquery.)
-- Execute the written statement and compare the results that you got 
-- with the desired results shown in the file 53 - Lab Exercise 1 - Task 2 Result.txt.
---------------------------------------------------------------------
-- Detyra 2
-- 
-- Selektoni kolonat orderid, orderdate, empid, dhe custid nga tabela Sales.Orders. 
-- Filtro rezultatin per te perfshire vetem porosite ku date order eshte e barabarte   
-- me last order date.(Ndihme: Perdor query ne detyren 1 si self-contained subquery.)
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet 
-- e deshiruara te treguara ne dokumentin 53 - Lab Exercise 1 - Task 2 Result.txt.
---------------------------------------------------------------------
Select TOP(2)  o.orderdate , o.orderid ,o.empid , o.custid
From Sales.Orders o
Order by o.orderdate DESC
---------------------------------------------------------------------
-- Task 3
-- 
-- The IT department has written a T-SQL statement that retrieves the orders for all customers 
-- whose contact name starts with a letter I: 
-- Execute the query and observe the result.
--
-- Modify the query to filter customers whose contact name starts with a letter B.
--
-- Execute the query. What happened? What is the error message? Why did the query fail?
--
-- Apply the needed changes to the T-SQL statement so that it will run without an error.
--
-- Execute the written statement and compare the results that you got with the desired results 
-- shown in the file 54 - Lab Exercise 1 - Task 3 Result.txt.
---------------------------------------------------------------------
SELECT
	orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE 
	custid = 
	(
		SELECT custid
		FROM Sales.Customers
		WHERE contactname LIKE N'I%'
	);
--
SELECT
	o.orderid, o.orderdate, o.empid, o.custid,c.contactname as customerContactName
FROM Sales.Orders o INNER JOIN Sales.Customers c ON o.custid = c.custid
WHERE c.contactname LIKE 'B%'

orderid	 orderdate	           empid	custid	   customerContactName
-----------------------------------------------------------------------
10259	2006-07-18 00:00:00.000	 4	      13	    Benito, Almudena
10265	2006-07-25 00:00:00.000	 2	       7	    Bansal, Dushyant
10297	2006-09-04 00:00:00.000	 5	       7	    Bansal, Dushyant
10360	2006-11-22 00:00:00.000	 4	       7	    Bansal, Dushyant
10364	2006-11-26 00:00:00.000	 1	      19	    Boseman, Randall
10389	2006-12-20 00:00:00.000	 4	      10	    Bassols, Pilar Colome
10400	2007-01-01 00:00:00.000	 1	      19	    Boseman, Randall
10410	2007-01-10 00:00:00.000	 3	      10	    Bassols, Pilar Colome
10411	2007-01-10 00:00:00.000	 9	      10	    Bassols, Pilar Colome
10431	2007-01-30 00:00:00.000	 4	      10	    Bassols, Pilar Colome
10435	2007-02-04 00:00:00.000	 8	      16	    Birkby, Dana
10436	2007-02-05 00:00:00.000	 3	       7	    Bansal, Dushyant
10449	2007-02-18 00:00:00.000	 3	       7	    Bansal, Dushyant
10462	2007-03-03 00:00:00.000	 2	      16	    Birkby, Dana
10492	2007-04-01 00:00:00.000	 3	      10	    Bassols, Pilar Colome
10532	2007-05-09 00:00:00.000	 7	      19	    Boseman, Randall
10559	2007-06-05 00:00:00.000	 6	       7	    Bansal, Dushyant
10566	2007-06-12 00:00:00.000	 9	       7	    Bansal, Dushyant
10584	2007-06-30 00:00:00.000	 4	       7	    Bansal, Dushyant
10628	2007-08-12 00:00:00.000	 4	       7	    Bansal, Dushyant
10679	2007-09-23 00:00:00.000	 8	       7	    Bansal, Dushyant
10726	2007-11-03 00:00:00.000	 4	      19	    Boseman, Randall
10742	2007-11-14 00:00:00.000	 3	      10	    Bassols, Pilar Colome
10826	2008-01-12 00:00:00.000	 6	       7	    Bansal, Dushyant
10848	2008-01-23 00:00:00.000	 7	      16	    Birkby, Dana
10918	2008-03-02 00:00:00.000	 3	      10	    Bassols, Pilar Colome
10944	2008-03-12 00:00:00.000	 6	      10	    Bassols, Pilar Colome
10949	2008-03-13 00:00:00.000	 2	      10	    Bassols, Pilar Colome
10975	2008-03-25 00:00:00.000	 1	      10	    Bassols, Pilar Colome
10982	2008-03-27 00:00:00.000	 2	      10	    Bassols, Pilar Colome
10987	2008-03-31 00:00:00.000	 8	      19	    Boseman, Randall
11024	2008-04-15 00:00:00.000	 4	      19	    Boseman, Randall
11027	2008-04-16 00:00:00.000	 1	      10	    Bassols, Pilar Colome
11045	2008-04-23 00:00:00.000	 6	      10	    Bassols, Pilar Colome
11047	2008-04-24 00:00:00.000	 7	      19	    Boseman, Randall
11048	2008-04-24 00:00:00.000	 7	      10	    Bassols, Pilar Colome
11056	2008-04-28 00:00:00.000	 8	      19	    Boseman, Randall

---------------------------------------------------------------------
-- Detyra 3
-- 
-- Departamenti i IT ka shkruar veprime T-SQL qe nxjerr te gjitha porosite per te gjithe 
-- klientet te cilet contact name fillon me shkronjen I: 
-- Ekzekuto query dhe observo rezultatin.
--
-- Modifikoni query per te filtruar klientet te cileve contact name fillon me shkronjen B.
--
-- Ekzekutoni query. Çfare ndodhi? Cfare eshte mesazhi i gabimit? Pse deshtoi query?
--
-- Aplikoni ndryshimet e nevojshme ne veprimet T-SQL ne menyre qe te ekzekutohet pa ndonje gabim.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet
-- e deshiruara te treguara ne dokumentin 54 - Lab Exercise 1 - Task 3 Result.txt.
---------------------------------------------------------------------

SELECT
	orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE 
	custid = 
	(
		SELECT custid
		FROM Sales.Customers
		WHERE contactname LIKE N'B%'
	);
---------------------------------------------------------------------------------------------------------------------------------------------------------
Msg 512, Level 16, State 1, Line 133
Subquery returned more than 1 value. This is not permitted when the subquery follows =, !=, <, <= , >, >= or 
when the subquery is used as an expression.

Completion time: 2024-08-01T11:52:12.4798139+02:00
---------------------------------------------------------------------
-- Task 4
-- 
-- Write a SELECT statement to retrieve the orderid column from the Sales.Orders 
-- table and the following calculated columns: 
-- totalsalesamount (based on the qty and unitprice columns in the Sales.OrderDetails table) 
-- salespctoftotal (percentage of the total sales amount for each order divided by  
-- the total sales amount for all orders in specific period)
-- Filter the results to include only orders placed in May 2008.
-- Execute the written statement and compare the results that you got with the desired
-- results shown in the file 55 - Lab Exercise 1 - Task 4 Result.txt. 
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
-- Detyra 4
-- 
-- Selektoni kolonen orderid nga tabela Sales.Orders dhe kolonat e perllogaritura si me poshte: 
-- totalsalesamount (bazuar ne kolonat qty dhe unitprice nga tabela Sales.OrderDetails) 
-- salespctoftotal (perqindja e shumes totale te shitjeve per cdo porosi pjestuar 
-- me shumen totale te shitjeve te te gjithe porosive ne nje periudhe te caktuar) 
-- Filtroni rezultatin per te perfshire vetem porosite qe kane ndodhur ne Maj te 2008.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet
-- e deshiruara te treguara ne dokumentin 55 - Lab Exercise 1 - Task 4 Result.txt. 
---------------------------------------------------------------------------------------------------------------------------
Select o.orderid , SUM((odd.qty)*(odd.unitprice)) as totalsalesamount ,salespctoftotal1.salespctoftotalPërqindje ,
month(o.orderdate) as muaji , year(o.orderdate) as viti
From Sales.Orders o  INNER JOIN Sales.OrderDetails odd ON o.orderid = odd.orderid
                     INNER JOIN (Select od.orderid,(SUM(od.qty * od.unitprice)/
                                (Select  SUM(sod.qty * sod.unitprice) as totalsalesamount1 From Sales.OrderDetails sod 
                                 )*100) as salespctoftotalPërqindje From Sales.OrderDetails od  
 Group By od.orderid) as salespctoftotal1 ON o.orderid = salespctoftotal1.orderid 
Where Month(o.orderdate) = '5' and YEAR(o.orderdate) = 2008
Group by o.orderid,month(o.orderdate), year(o.orderdate) ,salespctoftotal1.salespctoftotalPërqindje

----m2-----------------------------------------------------------------------------------------------------
 Select SUM((od.qty)*(od.unitprice)) as totalsalesamount, od.orderid,(SUM(od.qty * od.unitprice)/
                                (Select  SUM(sod.qty * sod.unitprice) as totalsalesamount1 From Sales.OrderDetails sod 
                                 )*100) as salespctoftotalPërqindje From Sales.OrderDetails od  
INNER JOIN Sales.Orders o ON od.orderid = o.orderid
Where Month(o.orderdate) = '5' and YEAR(o.orderdate) = 2008
Group By od.orderid

---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 2
---------------------------------------------------------------------
USE TSQL;
GO
---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement to retrieve the productid and productname columns from  
-- the Production.Products table. Filter the results to include only products that 
-- were sold in high quantities (more than 100 products) for a specific order line.
-- Execute the written statement and compare the results that you got with the desired 
-- results shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyra 1
-- 
-- Selektoni kolonat productid dhe productname nga tabela Production.Products. 
-- Filtroni rezultatin per te perfshire vetem produktet qe jane shitur ne sasi 
-- te medhaja (me shume se 100 produkte) ne nje linje te percaktuar porosish. 
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me 
-- rezultatet e deshiruara te treguara ne dokumentin 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------
Select pp.productid , pp.productname , od.qty
From Production.Products pp inner join Sales.OrderDetails od ON pp.productid = od.productid
Where od.qty > 100
Order by pp.productid , pp.productname
---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table. 
-- Filter the results to include only those customers that do not have any placed orders.
-- Execute the written statement and compare the results that you got with the 
-- recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt. Remember the number of rows in the result.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
-- 
-- Selektoni kolonat custid dhe contactname nga tabela Sales.Customers. 
-- Filtroni rezultatin per te perfshire ato kliente qe nuk kane bere ndonje porosi.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara 
-- te treguara ne dokumentin 63 - Lab Exercise 2 - Task 2 Result.txt. Remember the number of rows in the result.
---------------------------------------------------------------------
Select c.custid ,c.contactname,o.orderid
From Sales.Customers c left join Sales.Orders o ON c.custid = o.custid
Where o.orderid is null
-------------------------------------------------------------------------------
--Për ta verifikuar e kontrollojmë si me poshtë:
Select *
From Sales.Customers c left join Sales.Orders o ON c.custid = o.custid

---------------------------------------------------------------------
-- Task 3
-- 
-- The IT department has written a T-SQL statement that inserts an additional row 
-- in the Sales.Orders table. This row has a NULL in the custid column.
-- Execute this query exactly as written inside a query window.
-- Copy the T-SQL statement you wrote in task 2 and execute it. 
-- Observe the result. How many rows are in the result? Why?
-- Modify the T-SQL statement to retrieve the same number of rows as in task 2. 
-- (Hint: You have to remove the rows with an unknown value in the custid column.)
-- Execute the modified statement and compare the results that you got with 
-- the recommended result shown in the file 64 - Lab Exercise 2 - Task 3 Result.txt.
---------------------------------------------------------------------

INSERT INTO Sales.Orders (
custid, empid, orderdate, requireddate, shippeddate, shipperid, freight, 
shipname, shipaddress, shipcity,shippostalcode, shipcountry)
VALUES
(NULL, 1, '20111231', '20111231', '20111231', 1, 0, 
'ShipOne', 'ShipAddress', 'ShipCity', '1000', 'USA');

GO
-------------------------------------------
(1 row affected)

Completion time: 2024-08-01T13:36:49.7127454+02:00
------------------------------------------------------------------------
Select c.custid ,c.contactname,o.orderid
From Sales.Customers c left join Sales.Orders o ON c.custid = o.custid
Where o.orderid is null
--***Rezultati eshte i njejte***
Select *
From Sales.Orders o
---***Nese ekzekutojme kete query do te shtohet nje rekord ne 'Orders' ku custid is null
---------------------------------------------------------------------

---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table. 
-- Add a calculated column named lastorderdate that contains the last order date from 
-- the Sales.Orders table for each customer. (Hint: You have to use a correlated subquery.)
-- Execute the written statement and compare the results that you got with the recommended  
-- result shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 1
-- 
-- Selektoni kolonat custid dhe contactname nga tabela Sales.Customers.Shto nje kolone 
-- te perllogaritut te quajtur lastorderdate qe permban last order date nga tabela 
-- Sales.Orders per cdo klient. (Ndihme: ju duhet te perdorni nje subquery te koreluar.)
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret 
-- me rezultatet e deshiruara te treguara ne dokumentin 72 - Lab Exercise 3 - Task 1 Result.txt. 
---------------------------------------------------------------------
Select MAX(o.orderdate) as lastorderdate ,sc.custid,sc.contactname
From Sales.Customers sc inner join Sales.Orders o ON sc.custid = o.custid
group by sc.custid,sc.contactname
Order by lastorderdate DESC
-- 89 kliente pasi 2 nuk kane bere porosi
Select *
From  Sales.Customers sc Left join Sales.Orders o ON sc.custid = o.custid
Where o.orderid is null
Order by sc.custid Desc
---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to retrieve all customers that do not have any orders 
-- in the Sales.Orders table, similar to the request in exercise 2, task 3. 
-- However, this time use the EXISTS predicate to filter the results to include only 
-- those customers without an order. Also, you do not need to explicitly check that 
-- the custid column in the Sales.Orders table is not NULL.
-- Execute the written statement and compare the results that you got with 
-- the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt. 
--
-- Why didn’t you need to check for a NULL?
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
-- 
-- Nxirrni te gjithe klientet qe nuk kane ndonje porosi ne tabelen Sales.Orders, e ngjashme si ne ushtrimin 2, 
-- detyra 3.Gjithsesi, kete here perdor predicate EXISTS per te filtruar rezultatin per te perfshire 
-- vetem ato kliente pa ndonje porosi. Gjithashti, ju nuk keni te nevojshme te kontrolloni kolonen custid nga 
-- tabela Sales.Orders qe nuk eshte NULL.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara 
-- te treguara ne dokumentin 73 - Lab Exercise 3 - Task 2 Result.txt. 
-- Pse nuk keni nevoje te kontrolloni per vlera NULL?
---------------------------------------------------------------------
Select c.custid , c.contactname
From Sales.Customers c 
Where not EXISTS(
	Select c.custid
	From Sales.Orders o 
	Where o.custid = c.custid
) --AND NOT EXISTS()
---------------------------
Select c.custid , c.contactname
From Sales.Customers c 
Where  EXISTS(
	Select c.custid
	From Sales.Orders o 
	Where o.custid = c.custid  and o.orderid >8
)


custid |contactname
------------------------------------------
22	   |  Bueno, Janaina Burdan, Neville
57	   |  Tollevsen, Bjørn


---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table. 
-- Filter the results to include only customers that placed an order on or after April 1, 2008, 
-- and ordered a product with a price higher than $100.
-- Execute the written statement and compare the results that you got with the recommended result 
-- shown in the file 74 - Lab Exercise 3 - Task 3 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 3
-- 
-- Selektoni kolonat custid dhe contactname nga tabela Sales.Customers. 
-- Filtro rezultatin per te perfshire vetem  klientet qe kane bere porosi 
-- ne ose mbas dates April 1, 2008, dhe kane porositur nje produkt me nje cmim me shume se $100.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me 
-- rezultatet e deshiruara te treguara ne dokumentin 74 - Lab Exercise 3 - Task 3 Result.txt.
---------------------------------------------------------------------
Select c.custid ,c.contactname,o.orderdate
From Sales.Customers c inner join Sales.Orders o ON c.custid = o.custid
Where o.orderid IN (
                     Select o.orderid
					 From Sales.Orders o inner join Sales.OrderDetails od ON o.orderid = od.orderid
					                     inner join Production.Products pp ON pp.productid = od.productid
Where o.orderdate >= '2008-04-01' AND od.unitprice >100
)

---------------------------------------------------------------------

-- Task 4
-- 
--1-- Running aggregates are aggregates that accumulate values over time. Write a SELECT statement 
-- to retrieve the following information for each year:
--  The order year
--  The total sales amount
--  The running total sales amount over the years. That is, for each year, return the sum of 
--  sales amount up to that year. So, for example, for the earliest year (2006) return the total sales amount, 
-- for the next year (2007), return the sum of the total sales amount for the previous year and  the year 2007.

-- Execute the T-SQL code and compare the results that you got with the
-- recommended result shown in the file 75 - Lab Exercise 3 - Task 4 Result.txt.
---------------------------------------------------------------------
--1--
--Vetem RunningSalesAmount
(Select  SUM((od.unitprice * od.qty)) as runningSalesAmount 
                                 From Sales.Orders o  inner join Sales.OrderDetails od ON o.orderid = od.orderid
								 Where  year(o.orderdate)<=2006
UNION
Select  SUM((od.unitprice * od.qty)) as runningSalesAmount2007 
                                 From Sales.Orders o  inner join Sales.OrderDetails od ON o.orderid = od.orderid
								 Where  year(o.orderdate)<=2007 								 
UNION
Select  SUM((od.unitprice * od.qty)) as runningSalesAmount2008
                                 From Sales.Orders o  inner join Sales.OrderDetails od ON o.orderid = od.orderid
								 Where  year(o.orderdate)<=2008)

--RunningSalesAmount dhe Shuma totale per te gjitha vitet qe eshte e njevlereshme me runningSalesAmount2008
Select SUM(od.qty*od.unitprice) totalSalesAmount ,(Select  SUM((od.unitprice * od.qty)) as runningSalesAmount 
                                 From Sales.Orders o  inner join Sales.OrderDetails od ON o.orderid = od.orderid
								 Where  year(o.orderdate)<=2006) as  runningSalesAmount2006,(Select  SUM((od.unitprice * od.qty)) as runningSalesAmount2007 
                                 From Sales.Orders o  inner join Sales.OrderDetails od ON o.orderid = od.orderid
								 Where  year(o.orderdate)<=2007 ) as runningSalesAmount2007 
,(Select  SUM((od.unitprice * od.qty)) as runningSalesAmount 
                                 From Sales.Orders o  inner join Sales.OrderDetails od ON o.orderid = od.orderid
								 Where  year(o.orderdate)<=2008) as runningSalesAmount2008

From Sales.OrderDetails od
Where exists(Select year(o.orderdate) From Sales.Orders o Where o.orderid = od.orderid Group by year(o.orderdate))
--Afishimi i Shumes totale per çdo vit
Select year(o.orderdate) as viti ,SUM(od.qty*od.unitprice) totalSalesAmountperYEAR
From Sales.Orders o inner join Sales.OrderDetails od ON o.orderid = od.orderid
group by year(o.orderdate)
order by year(o.orderdate)
----------------------------------------------------------------------------------------------------------------------------
--Menyra e Rezartit --kapitulli 13
select sum(totalsalesamount2006) over (order by y ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) rt,y
from(
Select SUM(od.qty*od.unitprice) as totalsalesamount2006 , year(o.orderdate) y
                               From Sales.OrderDetails od inner join Sales.Orders o  ON o.orderid = od.orderid
group by year(o.orderdate) )a

---------------------------------------------------------------------
-- Task 5
-- 
-- Delete the row added in exercise 2 using the provided SQL statement. 
-- Execute this query exactly as written inside a query window.
---------------------------------------------------------------------

DELETE Sales.Orders
WHERE custid IS NULL;
---------------------------------------------------------------------
-- Detyra 5
-- 
-- Fshini rrjeshtin e shtuar ne ushtrimin 2 duke perdorur SQL e ofruar. 
-- Ekzekutoni kete query ashtu sic eshte e shkruar brenda ne dritaren e query.
---------------------------------------------------------------------

DELETE Sales.Orders
WHERE custid IS NULL;

(4 rows affected)

Completion time: 2024-08-01T16:42:23.7885918+02:00
--**Mqs une kam tentuar ta shtoj 4 here kete rreshtin kur custid is null