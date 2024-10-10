---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--1-- Write a SELECT statement against the Sales.Customers table and retrieve the custid and contactname columns. 
--2-- Add a calculated column named segmentgroup using a logical function IIF with the value “Target group” 
--2.1 for customers that are from Mexico and have in the contact title the value “Owner”. 
--2.2 Use the value “Other” for the rest of the customers. 
-- Execute the written statement and compare the results that you got with the desired 
-- results shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------
Select sc.custid,sc.contactname,sc.country,sc.contacttitle , 
segmentgroup =(IIF((sc.country = 'Mexico' AND sc.contacttitle = 'Owner'),'Target group','Other'))
From Sales.Customers as sc
Order By sc.country,sc.contacttitle DESC
Select * From Sales.Customers
---------------------------------------------------------------------
-- Task 2
-- 
-- Modify the T-SQL statement from task 1 to change the calculated column to show the value “Target group” 
-- for all customers without a missing value in the region attribute or with the value “Owner” in the contact title attribute.
-- with the value “Owner” in the contact title attribute.
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt. 
---------------------------------------------------------------------
-- Detyre 2
-- 
-- Modifiko veprimet T-SQL nga detyra 1 per te ndryshuar kolonen e perllogaritur per te treguar vleren “Target group” 
-- per te gjithe klientet pa patur ndonje vlere te munguar ne atributin region ose vleren “Owner” ne atributin e contact title.
-- Ekzekuto veprimet e mesiperme dhe krahaso rezultatin qe ju moret me rezultatin e deshiruar te treguar 
-- ne dokumentin 63 - Lab Exercise 2 - Task 2 Result.txt. 
---------------------------------------------------------------------
Select sc.custid,sc.contactname,sc.country,sc.contacttitle , 
segmentgroup =(IIF((sc.country = 'Mexico' AND sc.contacttitle = 'Owner'),'Target group','Other'))
From Sales.Customers as sc
Where sc.country = 'Mexico' and sc.contacttitle ='Owner'
Order By sc.custid  DESC
Select * From Sales.Customers

---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement against the Sales.Customers table and retrieve the custid and contactname columns. 
-- Add a calculated column named segmentgroup using the logic function CHOOSE with four possible descriptions 
-- (“Group One”, “Group Two”, “Group Three”, “Group Four”). Use the modulo operator on the column custid. 
-- (Use the expression custid % 4 + 1 to determine the target group.)
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 - Task 3 Result.txt.
---------------------------------------------------------------------
--------------------------------------------------------------------
-- Detyre 3
-- 
-- Nxjerr kolonat custid dhe contactname nga tabela Sales.Customers. Perdor operatorin modulo ne kolonen custid. 
-- Shto nje kolone te perllogaritur te quajtur segmentgroup duke perdorur funksionin logjik 
-- CHOOSE me kater mundesi pershkrimi(“Group One”, “Group Two”, “Group Three”, “Group Four”).
-- (Perdor shprehjen  custid % 4 + 1 per te percaktuar target group.)
-- Ekzekuto veprimet e mesiperme dhe krahaso rezultatin qe ju moret me rezultatin e deshiruar te treguar ne dokumentin 64 - Lab Exercise 2 - Task 3 Result.txt.
---------------------------------------------------------------------
  Select sc.custid , sc.contactname ,group_i = ((sc.custid%4)+1) ,segmentgroup = (IIF((((sc.custid%4)+1)>0),
  CHOOSE(((sc.custid%4)+1),'Group One','Group Two','Group Three','Group Four'),'NULL'))
  From Sales.Customers as sc
   Order By sc.custid