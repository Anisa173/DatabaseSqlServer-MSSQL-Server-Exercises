---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement to retrieve the contactname column from the Sales.Customers table. Based on this column, add a calculated column named lastname, which should consist of all the characters before the comma.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 82 - Lab Exercise 4 - Task 1 Result.txt. 
---------------------------------------------------------------------
Select lastName = SUBSTRING(sc.contactname,1,CHARINDEX(',',sc.contactname,1))
From Sales.Customers as sc
Select sc.contactname From Sales.Customers sc
---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to retrieve the contactname column from the Sales.Customers table and replace the comma in the contact name with an empty string. Based on this column, add a calculated column named firstname, which should consist of all the characters after the comma.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 83 - Lab Exercise 4 - Task 2 Result.txt. 
---------------------------------------------------------------------
Select FirstName = Replace(SUBSTRING(sc.contactname,1,CHARINDEX(',',sc.contactname,1)),',','')
From Sales.Customers as sc
Select sc.contactname From Sales.Customers sc
---------------------------------------------------------------------
-- Task 3
-- 
--1 Write a SELECT statement to retrieve the custid column from the Sales.Customers table. 
--2 Add a new calculated column to create a string representation of the custid as a fixed-width (6 characters) customer code prefixed
-- with the letter C and leading zeros. For example, the custid value 1 should look like C00001.
--3 Execute the written statement and compare the results that you got with the recommended result shown in the file 84 - Lab Exercise 4 - Task 3 Result.txt. 
---------------------------------------------------------------------
--1- 
Select sc.custid FROM Sales.Customers as sc
--2-
Select c.custid , customerCode = CONCAT('C',CONVERT(nvarchar(5),(IIF(c.custid<10 ,concat('0000',convert(nvarchar(2),c.custid)),IIF(c.custid <100,concat('000',convert(nvarchar(1),c.custid))))))
From Sales.Customers as c
----------------------------------------------------------------------------------------------------------------------------
Select c.custid,customerCode = ( case when c.custid < 10 then CONCAT('C0000',CAST(c.custid AS NVARCHAR(1))) 
when c.custid < 100 then CONCAT('C000',CONVERT(NVARCHAR(2),c.custid))  
ELSE '' END )
FROM Sales.Customers c

---------------------------------------------------------------------
-- Task 4
--
--1- Write a SELECT statement to retrieve the contactname column from the Sales.Customers table.  
--2- Add a calculated column, which should count the number of occurrences of the character ‘a’ inside the contact name. 
--3- (Hint: Use the string functions REPLACE and LEN.) Order the result from rows with the highest occurrences to lowest.
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 85 - Lab Exercise 4 - Task 4 Result.txt. 
--1-
Select sc.contactname
From Sales.Customers as sc
--2- Në TOTAL
Select COUNT(CHARINDEX('a',sc.contactname,1)) as Ocurrences
From Sales.Customers sc
Where sc.custid = custid
--2.1- Për çdo rresht
--Select sc.contactname , ROW_NUMBER() OVER(PARTITION BY sc.custid Order By sc.contactname DESC) ,
--as Occurrences
--From Sales.Customers as sc

---------------------------------------------------------------------
