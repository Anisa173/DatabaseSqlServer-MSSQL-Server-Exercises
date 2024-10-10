---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--
--1-- Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers
--  table and the orderid and orderdate columns from the Sales.Orders table.
--2-- Filter the results to include only orders placed on or after April, 1 2008 (filter the orderdate column). 
--3-- Then sort the result by orderdate in descending order and custid in ascending order.
-- 
--4-- Execute the written statement and compare the results that you got with the desired results 
-- shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------
-- Detyre 1
-- 
--1-- Selektoni kolonat custid and contactname nga tabela Sales.Customers
-- dhe kolonat orderid dhe orderdate nga tabela Sales.Orders. 
--2-- Filtroni rezultatin per te perfshire vetem porosite e bera ne ose pas 1 Prill 2008. (filtro kolonen orderdate). 
--3-- Pastaj vendos rezultatin sipas orderdate ne rendin zbrites dhe sipas custid ne rendin rrites.
--4-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara
--  ne dokumentin 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------
--1--2--
Select *
From Sales.Customers c inner join Sales.Orders o ON c.custid=o.custid
Order By o.orderdate
--Filtro kolonen orderdate
Select c.custid,c.contactname,o.orderid,o.orderdate
From Sales.Customers c inner join Sales.Orders o ON c.custid=o.custid
Where o.orderdate >'2008-04-01'
Select c.custid,c.contactname,o.orderid
From Sales.Customers c inner join Sales.Orders o ON c.custid=o.custid
Where o.orderdate > '2008-04-01'
--3--Ne rendin zbrites
Select c.custid,c.contactname,o.orderid,o.orderdate
From Sales.Customers c inner join Sales.Orders o ON c.custid=o.custid
Where o.orderdate > '2008-04-01'
Order by o.orderdate desc
--3--Ne rendin rrites
Select c.custid,c.contactname,o.orderid,o.orderdate
From Sales.Customers c inner join Sales.Orders o ON c.custid=o.custid
Where o.orderdate > '2008-04-01'
Order by o.orderdate asc

---------------------------------------------------------------------
-- Task 2
-- 
-- Execute the query exactly as written inside a query window and observe the result.
--
-- You get an error. What is the error message? Why do you think you got this error? (Tip: Remember the logical processing order of the query.)
--
-- Apply the needed changes to the SELECT statement so that it will run without an error. Test the changes by executing the T-SQL statement.
--
-- Observe and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt.
---------------------------------------------------------------------

SELECT
	e.empid, e.lastname, e.firstname, e.title, e.mgrid,
	m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = m.empid
WHERE
	mgrlastname = N'Buck';

---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 2
-- 
-- Ekzekuto query ekzaktesisht ashtu sic tregohet ne dritaren e query dhe observo rezultatin.
--
-- Ju del nje error. Cfare eshte mesazhi i gabimit? Pse mendoni qe e keni kete mesazh gabimi? (Keshille: Kujtoni procesimin logjike sipas radhes te query.)
--
-- Apliko ndryshimet e duhura qe te ekzekutohet pa asnje gabim. Testo ndyshimet duke ekzekutuar kodin T-SQL.
--
-- Observo dhe krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 63 - Lab Exercise 2 - Task 2 Result.txt.
---------------------------------------------------------------------
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid,
	m.lastname AS mgrlastname, m.firstname AS mgrfirstname From HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = m.empid
SELECT
	e.empid, e.lastname, e.firstname, e.title, e.mgrid,
	m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = m.empid
Where m.lastname= N'Buck'

---------------------------------------------------------------------
-- Task 3a
-- 
-- Copy the existing T-SQL statement from task 2 and modify it so that the result will return all employees and be ordered by the manager’s first name. 
-- Try first to use the source column name
--
---------------------------------------------------------------------


---------------------------------------------------------------------
-- Task 3b

-- Now try to use the alias column name.
--
-- Execute the written statement and compare the results with the recommended result shown in the file 64 - Lab Exercise 2 - Task 3 Result.txt.
--
-- Why were you equally able to use a source column name or an alias column name? 
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 3a
-- 
-- Kopjo kodin ekzistues T-SQL nga Detyra 2 dhe modefiko ate qe rezulati te ktheje 
-- te gjithe punonjesit dhe te radhitet sipas emrit te pare te manaxherit. 
-- Provo ne fillim te perdoresh emrin e kolones se burimit.
---------------------------------------------------------------------
SELECT e.empid, e.lastname, e.firstname, e.title, m.mgrid,
m.lastname AS mgrlastname, m.firstname AS mgrfirstname From HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = m.empid
--Rradhitja sipas emrit të parë të menaxherit--
SELECT e.empid, e.lastname, e.firstname, e.title, m.mgrid,
m.lastname AS mgrlastname, m.firstname AS mgrfirstname From HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = m.empid
Order By m.firstname asc


---------------------------------------------------------------------
-- Detyre 3b

-- Tani provo te perdoresh emrin e kolones alias.
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara 
-- ne dokumentin 64 - Lab Exercise 2 - Task 3 Result.txt.
SELECT e.empid, e.lastname, e.firstname, e.title, m.mgrid,
m.lastname AS mgrlastname, m.firstname AS mgrfirstname From HR.Employees AS e
INNER JOIN HR.Employees AS m ON m.mgrid = e.empid
--Rradhitja sipas emrit të parë të menaxherit--
SELECT e.empid, e.lastname, e.firstname, e.title, m.mgrid,
m.lastname AS mgrlastname, m.firstname AS mgrfirstname From HR.Employees AS e
INNER JOIN HR.Employees AS m ON m.mgrid = e.empid
Order By mgrfirstname asc
-- Pse ishit ne gjendje te perdorni ne menyre te barabarte nje emer 
-- te kolones se burimit ose nje emer te kolones alias? 
---------------------------------------------------------------------
SELECT e.empid, e.lastname, e.firstname, e.title, m.mgrid,
m.lastname AS mgrlastname, m.firstname AS mgrfirstname From HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = e.empid
--Rradhitja sipas emrit të parë të menaxherit--
SELECT e.empid, e.lastname, e.firstname, e.title, m.mgrid,
m.lastname AS mgrlastname, m.firstname AS mgrfirstname From HR.Employees AS e
INNER JOIN HR.Employees AS m ON m.mgrid = m.empid
Order By mgrfirstname asc