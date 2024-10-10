---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 3
---------------------------------------------------------------------
USE TSQL;
GO
---------------------------------------------------------------------
-- Task 1
-- 
--
-- Write a SELECT statement against the Sales.Customers table and retrieve the contactname and city columns. 
-- Concatenate both columns so that the new column looks like this:  Allen, Michael (city: Berlin)
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt. 
---------------------------------------------------------------------
Select sc.contactname ,sc.city , concat(sc.contactname +' ',concat('(city: ',sc.city,')')) as FullName
From Sales.Customers as sc
---------------------------------------------------------------------
-- Task 2
--1-- Copy the T-SQL statement in task 1 and modify it to extend the calculated column with new information from the region column. 
--2-- Treat a NULL in the region column as an empty string for concatenation purposes. 
--3-- When the region is NULL, the modified column should look like this:
--4--  Allen, Michael (city: Berlin, region: )
--5-- When the region is not NULL, the modified column should look like this
--  Richardson, Shawn (city: Sao Paulo, region: SP)
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt.
---------------------------------------------------------------------
--1--
Select sc.contactname ,sc.city ,Fullname = ( concat(sc.contactname +' ',concat('(city: ',sc.city,',',' ','region:',' ',sc.region,')') ))  
From Sales.Customers as sc

--2&3&4--
Select sc.contactname ,sc.city ,FullName = (case when sc.region = 'NULL' then concat(sc.contactname +' ',concat('(city: ',sc.city,',',
' ','region:',' ',')')) 
else concat(sc.contactname +' ',concat('(city: ',sc.city,',',' ','region:',' ',sc.region,')')) end )
From Sales.Customers as sc


---------------------------------------------------------------------
-- Task 3
-- 
--1-- Write a SELECT statement to retrieve the contactname and contacttitle columns from the Sales.Customers table. 
--2-- Return only rows where the first character in the contact name is ‘A’ through ‘G’.
--3-- Execute the written statement and compare the results that you got with the recommended result shown in the file 74 - Lab Exercise 3 - Task 3 Result.txt. Notice the number of rows returned.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyrat 3
-- 
--1-- Nxirrni contactname dhe contacttitle nga tabela Sales.Customers. 
--2-- Te nxirren vetem rreshtat qe karakteri i pare i emrit eshte ‘A’ through ‘G’.
--3-- Ekzekutoni query dhe krahasoni resultatet me rezultatet e file 74 - Lab Exercise 3 - Task 3 Result.txt. Notice the number of rows returned.
---------------------------------------------------------------------
--1--
Select sc.contactname , sc.contacttitle
From Sales.Customers as sc
Order by sc.contactname asc
--2--
Select sc.contactname , sc.contacttitle 
From Sales.Customers as sc 
Where sc.contactname <= 'G'
Order By sc.contactname ASC