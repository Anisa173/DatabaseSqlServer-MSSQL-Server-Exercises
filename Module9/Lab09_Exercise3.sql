---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- A junior analyst prepared a T-SQL statement to retrieve the number of orders and the number of customers for each order year. Observe the provided T-SQL statement and execute it:
--
-- Observe the result and notice that the number of orders is the same as the number of customers. Why?
--
-- Correct the T-SQL statement to show the correct number of customers that placed an order for each year.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt. 
---------------------------------------------------------------------

SELECT
	YEAR(orderdate) AS orderyear, 
	COUNT(orderid) AS nooforders, 
	COUNT(custid) AS noofcustomers
FROM Sales.Orders 
GROUP BY YEAR(orderdate);
---------------------------------------------------------------------
-- Detyra 1
-- 
-- Nje analist fillestar pergatiti veprimet T-SQL per te nxjerre numrin e porosive dhe  
-- numrin e klienteve per cdo order year.Observo veprimet T-SQL dhe ekzekutojini ato:
-- Observoni rezultatin dhe vini re qe numri i porosive eshte i njejte me numrin e klienteve. Pse?
-- Korrigjoni veprimet T-SQL per te treguar numrin e sakte te klienteve qe kryejne porosi per cdo vit.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara ne dokumentin 72 - Lab Exercise 3 - Task 1 Result.txt. 
---------------------------------------------------------------------
SELECT
	YEAR(orderdate) AS orderyear, 
	COUNT(orderid) AS nooforders, 
	COUNT(custid) AS noofcustomers
FROM Sales.Orders 
GROUP BY YEAR(orderdate)
ORDER BY YEAR(orderdate);
---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to retrieve the number of customers based on the first letter of the values 
-- in the contactname column from the Sales.Customers table. Add an additional column to show the 
-- total number of orders placed by each group of customers. Use the aliases firstletter, noofcustomers and nooforders. 
-- Order the result by the firstletter column.
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
-- 
-- Nxirrni 'numrin e klienteve' bazuar ne shkronjen e pare te vleres ne kolonen contactname nga tabela Sales.Customers. 
-- Shto nje kolone shtese per te treguar numrin total te porosive qe kane ndodhur nga cdo grup i klienteve.
-- Perdor si aliases firstletter, noofcustomers dhe nooforders. Rendit rezultatin sipas kolones firstletter.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara te treguara 
-- ne dokumentin 73 - Lab Exercise 3 - Task 2 Result.txt.
---------------------------------------------------------------------
Select SUBSTRING(c.contactname,1,1) as firstLetter , count(Distinct c.custid) as noofcustomers , count(o.orderid) as nooforders
From Sales.Customers as c Inner Join Sales.Orders as o ON c.custid = o.custid 
Group by SUBSTRING(c.contactname,1,1)
--
Select * From Sales.Customers c inner join Sales.Orders o ON c.custid = o.custid 
Order By c.contactname asc
---------------------------------------------------------------------
-- Task 3
-- 
-- Copy the T-SQL statement in exercise 1, task 4, and modify to include the following information about 
-- for each product category: total sales amount, number of orders, and average sales amount per order. 
-- Use the aliases totalsalesamount, nooforders, and avgsalesamountperorder, respectively.
-- Execute the written statement and compare the results that you got with the recommended 
-- result shown in the file 74 - Lab Exercise 3 - Task 3 Result.txt. 
------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 3
-- Kopjoni veprimet T-SQL ne ushtrimin 1, detyra 4, dhe modifikojeni per te perfshire informacionin 
-- qe vijon rreth cdo product category: total sales amount , number of orders dhe average sales amount per order. 
-- Perdor alias totalsalesamount, nooforders, dhe avgsalesamountperorder.
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatet qe ju moret me rezultatet e deshiruara 
-- te treguara ne dokumentin 74 - Lab Exercise 3 - Task 3 Result.txt. 
---------------------------------------------------------------------
Select  c.custid, c.city, c.contactname,count(o.orderid) as nooforders,DATEPART(year,o.orderdate)  as orderyear,
SUM((od.unitprice * od.qty)*(1- od.discount)) as totalsalesamount , 
AVG((od.unitprice * od.qty)*(1- od.discount)) AS avgsalesamountperorder
From Sales.Orders o INNER JOIN Sales.Customers c On c.custid = o.custid         
                    INNER JOIN HR.Employees e ON o.empid = e.empid
					INNER JOIN Sales.OrderDetails od ON o.orderid = od.orderid
Where od.productid IN(Select p.productid
From Sales.OrderDetails od INNER JOIN Production.Products p ON od.productid = p.productid
                           INNER JOIN Production.Categories pc ON p.categoryid = pc.categoryid
)
group by c.custid,c.contactname,c.city,DATEPART(year,o.orderdate) 
Having(count(o.orderid))=5
Order by orderyear
