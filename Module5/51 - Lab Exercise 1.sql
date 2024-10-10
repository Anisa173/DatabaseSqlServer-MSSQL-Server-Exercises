---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement that will return the custid, companyname, contactname, address, city, country, and phone columns from the Sales.Customers table. 
-- Filter the results to include only the customers from the country Brazil.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab Exercise  Task 1 Result.txt.
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyre 1 
-- 
-- Selektoni kolonat  custid, companyname, contactname, address, city, country, dhe phone nga tabela Sales.Customers. 
-- Filtro rezultatin per te perfshire vetem klientet nga shteti i Brazilit.
--
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 52 - Lab Exercise  Task 1 Result.txt.
---------------------------------------------------------------------
Select sc.custid CustomerId,sc.companyname CompanyName , sc.contactname ContactName,sc.address Address,sc.city City , sc.country Country,sc.phone Phone
From Sales.Customers sc
Select * From Sales.Customers sc Where sc.country='Brazil'

---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement that will return the custid, companyname, contactname, address, city, country, and phone columns from the Sales.Customers table. 
-- Filter the results to include only customers from the countries Brazil, UK, and USA.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 2 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyre 2
-- 
-- Selektoni kolonat custid, companyname, contactname, address, city, country, dhe phone nga tabela Sales.Customers. 
-- Filtro rezultatin per te perfshire vetem klientet nga shtetet Brazil, UK, dhe USA.
--
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 53 - Lab Exercise 1 - Task 2 Result.txt.
---------------------------------------------------------------------
Select sc.custid CustomerId,sc.companyname CompanyName , sc.contactname ContactName,sc.address Address,
sc.city City , sc.country Country,sc.phone Phone
From Sales.Customers sc
Where sc.country IN ('Brazil','UK','USA')
---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement that will return the custid, companyname, contactname, address, city, country, and phone columns from the Sales.Customers table. 
-- Filter the results to include only the customers with a contact name starting with the letter A.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 - Task 3 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyre 3
-- 
-- Selektoni kolonat custid, companyname, contactname, address, city, country, dhe phone nga tabela Sales.Customers. 
-- Filtro rezultatin per te perfshire vetem emrat e kontakteve qe fillojne me shkronjen "A".
--
-- Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 54 - Lab Exercise 1 - Task 3 Result.txt.
---------------------------------------------------------------------
Select sc.custid CustomerId,sc.companyname CompanyName , sc.contactname ContactName,
sc.address Address,sc.city City , sc.country Country,sc.phone Phone
From Sales.Customers sc
Where ContactName Like 'A%'
---------------------------------------------------------------------
-- Task 4a
-- 
-- The IT department has written a T-SQL statement that retrieves the custid and companyname columns from the Sales.Customers 
-- table and the orderid column from the Sales.Orders table.
-- Execute the query. Notice two things: 
--  First, the query retrieves all the rows from the Sales.Customers table. 
--  Second, there is a comparison operator in the ON clause specifying that the city column should be equal to the value “Paris”.
---------------------------------------------------------------------

SELECT
	c.custid, c.companyname, o.orderid
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid AND c.city = N'Paris';

---------------------------------------------------------------------
-- Task 4b
-- 
-- Copy the provided T-SQL statement and modify it to have a comparison operator for the city column in the WHERE clause. Execute the query. 
-- 
-- Compare the results that you got with the desired results shown in the file 55 - Lab Exercise 1 - Task 4 Result.txt. 
--
-- Is the result the same as in the first T-SQL statement? Why? What is the difference between specifying the predicate in the ON clause and in the WHERE clause?
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 4a
-- 
-- Departamenti i IT ka shkruar nje kod  T-SQL qe nxjerr kolonat custid dhe companyname 
-- nga tabela Sales.Customers dhe kolonen orderid nga tabela Sales.Orders.
-- Ekzekuto query. Vëre  dy gjera: 
--  Se pari, query nxjerr te gjitha rrjeshtat nga tabela Sales.Customers. 
--  Se dyti, eshte nje operator krahasimi ne klazulen On duke specifikuar qe kolona city duhet te jene e barabarte me vleren "Paris".
---------------------------------------------------------------------
--Si duhet shkruar query qe te mos ekzekutohet me error
SELECT c.custid, c.companyname, o.orderid
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o ON c.custid = o.custid 
WHERE c.city = N'Paris'
SELECT c.custid, c.companyname, o.orderid,c.city
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o ON c.custid = o.custid 
WHERE c.city = N'Paris'
--Querite e meposhtme jane te gabuara ... asnje kolone nuk duher te jete 'null'
SELECT *
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid AND c.city = N'Paris';

SELECT
	c.custid, c.companyname, o.orderid
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid AND c.city = N'Paris';

---------------------------------------------------------------------
-- Detyra 4b
-- 
-- Kopjo kodin T-SQL  dhe modifikoje ate per te patur nje operator krahasimi per kolonen city ne klazulen WHERE. Ekzekuto query. 
-- 
-- Krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 55 - Lab Exercise 1 - Task 4 Result.txt. 
--
-- A eshte rezultati i njejte si ne kodin e pare te T-SQL? Pse? Cila eshte diferenca midis specifikimit te predicate ne klazulen ON dhe specifikimit ne klazulen WHERE?
---------------------------------------------------------------------
***u Krye me siper ne 4a
---------------------------------------------------------------------
-- Task 5
-- 
-- Write a T-SQL statement to retrieve customers from the Sales.Customers table that do not have matching orders in the Sales.Orders table. 
-- Matching customers with orders is based on a comparison between the customer’s custid value and the order’s custid value. 
-- Retrieve the custid and companyname columns from the Sales.Customers table. 
-- (Hint: Use a T-SQL statement that is similar to the one in the previous task.)
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 56 - Lab Exercise 1 - Task 5 Result.txt.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 5
-- 
-- Shkruani nje T-SQL per te nxjerre klientet nga tabela the Sales.Customers qe nuk kane perputhje porosish nga tabela  Sales.Orders. 
-- Kombinimi i klienteve me porosite eshte i bazuar ne krahasimin midis the vleres se customer’s custid dhe vleres se order’s custid. 
-- Nxjerr kolonat custid dhe companyname nga tabela Sales.Customers. 
-- (Udhezim: Perdor nje T-SQL qe eshte e ngjashme me ate te detyres me para.)
--
--  Ekzekuto veprimet dhe krahaso rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 56 - Lab Exercise 1 - Task 5 Result.txt.
---------------------------------------------------------------------
Select * From Sales.Customers c LEFT OUTER JOIN Sales.Orders  o ON c.custid=o.custid
Where o.orderid IS NULL 

Select c.companyname CompanyName,c.custid CustomerId From Sales.Customers c LEFT OUTER JOIN Sales.Orders  o ON c.custid=o.custid
Where o.orderid IS NULL 

