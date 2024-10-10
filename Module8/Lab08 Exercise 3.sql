---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement to retrieve the contactname and fax columns from the Sales.Customers table. If there is a missing value in the fax column, return the value ‘No information’.
--
-- Write two solutions, one using the COALESCE function and the other using the ISNULL function.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt. 
--
-- What is the difference between the ISNULL and COALESCE functions?
---------------------------------------------------------------------
--------------------------------------------------------------------
-- Detyre 1
-- 
-- Nxjerr kolonat contactname dhe fax  nga tabela the Sales.Customers. Ne qoftese ka ndonje vlere qe mungon ne kolonen fax, 
-- te ktheje vleren ‘No information’.
-- Shkruaj dy zgjidhje, nje duke perdorur funksionin COALESCE dhe tjetra duke perdorur funksionin ISNULL.
--
-- Ekzekuto veprimet e mesiperme dhe krahaso rezultatin qe ju moret me rezultatin e deshiruar te treguar ne dokumentin 72 - Lab Exercise 3 - Task 1 Result.txt. 
--
--Cili eshte ndyshime midis funksioneve ISNULL and COALESCE?
---------------------------------------------------------------------
Select c.contactname ,Fax =  (case when ISNULL((c.fax),'null')= 'null' then 'No_information' else c.fax  end)
From Sales.Customers c
--------------------------------
Select c.contactname ,Fax =  (case when COALESCE((c.fax),'NULL')= 'null' then 'No_information' else c.fax  end)
From Sales.Customers c
---------------------------------------------------------------------
-- Task 2
-- 
-- Update the provided T-SQL statement with a WHERE clause to filter the region column using the provided variable @region, which can have a value or a NULL. Test the solution using both provided variable declaration cases.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyre 2
-- 
-- Perditeso veprimet T-SQL me nje klause 'WHERE' duke perdorur variablin e ofruar @region, 
-- e cila mund te kete nje vlere ose eshte NULL. Testo zgjidhjen duke perdorur te dyja variablat e ofruar ne deklarim.
---------------------------------------------------------------------
--DECLARE @region AS NVARCHAR(30) = NULL; 
Select * From Sales.Customers
SELECT 
	custid, region
FROM Sales.Customers
Where isnull(Sales.Customers.region,'null')= 'null'
GO
-----------------------------------------------------------------------
--DECLARE @region AS NVARCHAR(30) = N'WA'; 
SELECT 
	custid, region
FROM Sales.Customers
Where isnull(Sales.Customers.region,'null')= N'WA'
GO
---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement to retrieve the contactname, city, and region columns from the Sales.Customers table. 
-- Return only rows that do not have two characters in the region column, including those with an inapplicable region (where the region is NULL).
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 - Task 3 Result.txt. Notice the number of rows returned.
---------------------------------------------------------------------
--------------------------------------------------------------------
-- Detyre 3
-- Nxjerr kolonat contactname, city, dhe region nga tabela Sales.Customers. 
-- Kthe vetem rrjeshtat qe nuk kane dy karaktere ne kolonen region, duke perfshire ato me nje region te papershtatshem(ku region eshte NULL).
-- Ekzekuto veprimet e mesiperme dhe krahaso rezultatin qe ju moret me rezultatin e deshiruar te treguar ne dokumentin 73 - Lab Exercise 3 - Task 3 Result.txt. Vere numrin e rrjeshtave qe u kthyen.
---------------------------------------------------------------------
Select c.contactname , c.region , c.city
From Sales.Customers c
Where  not isnull(c.region,'null')='null'