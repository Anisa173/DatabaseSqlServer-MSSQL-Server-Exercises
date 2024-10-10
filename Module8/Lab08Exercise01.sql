---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a SELECT statement against the Production.Products table to retrieve a calculated column named productdesc. The calculated column should be based on the columns productname and unitprice and look like this:
--  The unit price for the Product HHYDP is 18.00 $.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 - Task 1 Result.txt. 
--
-- Did you use the CAST or the CONVERT function? Which one do you think is more appropriate to use?
---------------------------------------------------------------------


---------------------------------------------------------------------
-- Detyra 1
-- 
-- Shkruani nje query ne lidhje me tabelen Production.Products per te marre nje kolone te perllogaritur me emrin productdesc. 
-- Kolona e perllogaritur duhet te bazohet ne kolonat productname e unitprice dhe te shfaqet si kjo me poshte:
-- Cmimi njesi per Product HHYDP eshte 18.00 $.
--
-- Ekzekuto veprimet e mesiperme dhe krahaso rezultatin qe ju moret me rezultatin e deshiruar te treguar ne dokumentin 52 - Lab Exercise 1 - Task 1 Result.txt. 
--
-- Perdoret funksionin CAST apo CONVERT? Cili funksion mendoni qe eshte me e pershtatshme per tu perdorur?
---------------------------------------------------------------------
Select productDescr = CONCAT(CONCAT('Çmimi njesi per ',p.productname ),CONCAT(CONCAT(' ', 'eshte '),CONCAT(p.unitprice,' $.')))
From Production.Products p
---------------------------------------------------------------------
Select * From Production.Products p
-- Task 2
-- 
-- The US marketing department has supplied you with a start date 4/1/2007 (using US English form, read as April 1, 2007) and an end date 11/30/2007 (using US English form, read as November 30, 2007). Write a SELECT statement against the Sales.Orders table to retrieve the orderid, orderdate, shippeddate, and shipregion columns. Filter the result to include only rows with the order date between the specified start date and end date and have more than 30 days between the shipped date and order date. Also check the shipregion column for missing values. If there is a missing value, then return the value ‘No region’.
--
-- In this SELECT statement, you can use the CONVERT function with a style parameter or the new PARSE function.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 2 Result.txt. 
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyre 2
-- 
--1-- Departamenti i Marketingut ne US ju ka furnizuar me daten 4/1/2007 ne fillim (duke perdorur formularin ne anglisht,   
-- Nentor 30, 2007). Shkruani nje query ne lidhje me tabelen the Sales.Orders per te nxjerre kolonat
-- orderid, orderdate, shippeddate, dhe shipregion. Filtro rezultatin per te perfshire vetem rrjeshtat me date porosie midis 
-- dates se fillimit te specifikuar dhe dates se perfundimit dhe  ka me shume se 30 dite midis dates se derguar dhe dates se porositur. 
--2-- Gjithashtu shiko kolonen shipregion per vlerat e munguara. Ne qoftese ka ndonje vlere te munguar,atehere kthe vleren ‘No region’.
-- Ne kete query, ju mund te perdorni funksionin CONVERT me nje parameter ose funksionin e ri PARSE.
--
-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatin qe moret me rezultatin e deshiruar te treguar  
-- ne dokumentin 53 - Lab Exercise 1 - Task 2 Result.txt.
---------------------------------------------------------------------
--1--
Declare @date1 datetime = convert(datetime,'2007-01-04')
Declare @date2 datetime = convert(datetime,DATEADD(DAY,30,'2007-01-04'))
Select o.orderid,o.orderdate,o.shippeddate,o.shipregion                                 
From Sales.Orders o
Where o.orderdate >= @date1 And o.orderdate <= @date2                                                  
Order By o.orderdate
--2--

Select o.orderid,o.orderdate,o.shippeddate,o.shipregion,shipRegion = ( case when o.shipregion = NULL then 'No region'                      
 else o.shipregion end )           
From Sales.Orders o
Where o.orderdate >= convert(datetime,'2007-01-04') And o.orderdate <= convert(datetime,DATEADD(DAY,30,'2007-01-04'))                                                 
Order By o.orderdate
Select * From Sales.Orders
---------------------------------------------------------------------
-- Task 3
-- 
-- The IT department would like to convert all the information about phone numbers in the Sales.Customers table to integer values. The IT staff indicated that all hyphens, parentheses, and spaces have to be removed before the conversion to an integer data type. 
--
-- Write a SELECT statement to implement the requirement of the IT department. Replace all the specified characters in the phone column of the Sales.Customers table and then convert the column from the nvarchar datatype to the int datatype. The T-SQL statement must not fail if there is a conversion error, but rather it should return a NULL. (Hint: First try writing a T-SQL statement using the CONVERT function and then use the new functionality in SQL Server 2012). Use the alias phoneasint for this calculated column.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 3 - Task 3 Result.txt. 
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyre 3
-- 
--1-- Departamenti i IT deshiron te konvertoje te gjithe informacionin e numrave te telefonit ne tabelen the Sales.Customers 
-- ne vlera integer(numra te plote).Stafi i IT tregoi qe te gjitha lidhjet, kllapat dhe hapesirat 
-- duhen te hiqen perpara konvertimit ne numra te plote.Shkruani nje query per te realizuar keto kerkesa qe ka departamenti i IT.    
--2-- Zevendesoni te gjitha karakteret e specifikuara ne kolonen phone te tabeles the Sales.Customers
-- dhe pastaj konverto kolonen nga tipi i te dhenes nvarchar ne tipin e te dhenes int.
-- Veprimet në  T-SQL  nuk duhet te deshtojne neqoftese ka ndonje gabim ne konvertim, por duhet te ktheje nje vlere NULL.
-- (Ndihme: Se pari duhet te shkruani veprimet T-SQL duke perdorur funksionin CONVERT 
-- dhe pastaj perdor funksionalitetet e reja ne SQL Server 2012). Perdor alias 'phoneasint' per kete kolone te perllogaritur.
--3-- Ekzekutoni veprimet e mesiperme dhe krahasoni rezultatin qe moret me rezultatin e deshiruar te treguar ne dokumentin 54 - Lab Exercise 3 - Task 3 Result.txt. 
---------------------------------------------------------------------
--1--
Select C.phone From Sales.Customers C
Select phoneasint = Replace((Replace((Replace((Replace((Replace(c.phone,SUBSTRING(c.phone,1,
CHARINDEX('(',c.phone,1)),'')),')','')),'.','')),'-','')),' ','')
From Sales.Customers c
--2--
Select phoneasint = CONVERT(Bigint,Replace((Replace((Replace((Replace((Replace(c.phone,SUBSTRING(c.phone,1,
CHARINDEX('(',c.phone,1)),'')),')','')),'.','')),'-','')),' ',''))
From Sales.Customers c


