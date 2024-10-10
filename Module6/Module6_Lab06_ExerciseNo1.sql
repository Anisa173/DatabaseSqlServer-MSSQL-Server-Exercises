---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- 
-- Write a SELECT statement to return columns that contain:
--1-  The current date and time. Use the alias currentdatetime.
--2-  Just the current date. Use the alias currentdate.
--3-  Just the current time. Use the alias currenttime.
--4-  Just the current year. Use the alias currentyear.
--4-  Just the current month number. Use the alias currentmonth.
--5-  Just the current day of month number. Use the alias currentday.
--6-  Just the current week number in the year. Use the alias currentweeknumber.
--  The name of the current month based on the currentdatetime column. Use the alias currentmonthname.
-- 
-- Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 - Task 1 Result.txt. Your results will be different because of the current date and time value.
--
-- Can you use the alias currentdatetime as the source in the second column calculation (currentdate)? Please explain.
---------------------------------------------------------------------

Select currentdatetime = (convert(datetime,GETDATE())),currentdate = cast(GETDATE() AS DATE),currenttime = cast(GETDATE() AS TIME),   
currentyear = DATEPART(year,GETDATE()) ,currentmonth = DATEPART(month,GETDATE()),currentday = DATEPART(day,GETDATE()),
currentweeknumber = DATEPART(WEEK,GETDATE()),currentmonthname = DATENAME(month,GETDATE())

--9-
DECLARE @orderdate DATETIME = (convert(datetime,GETDATE()))
Select currentdate = cast(@orderdate AS date) 
--jo nuk mund te ekzekutohet
DECLARE @orderdate DATETIME = currentdatetime
Select currentdate = cast(@orderdate AS date)
---------------------------------------------------------------------
-- Task 2
--  
-- Write December 11, 2015, as a column with a data type of date. Use the different possibilities inside the T-SQL language (cast, convert, specific function, etc.) and use the alias somedate.
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 2
--  
--1-- Shkruani December 11, 2015, si një kolonë me tipin e te dhenave date.  
--2-- Përdorni mundësitë e ndryshme brenda gjuhës T-SQL (cast, convert, specific function, etc, dhe përdorni alias somedate.
---------------------------------------------------------------------
--1--
Select cast('2015-December-11' AS DATE) AS somedate
--2--
Select convert(Date,'2015-12-11') as somedate
---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement to return columns that contain:
--  Three months from the current date and time. Use the alias threemonths.
--  Number of days between the current date and the first column (threemonths). Use the alias diffdays.
--  Number of weeks between April 4, 1992, and September 16, 2011. Use the alias diffweeks.
--  First day in the current month based on the current date and time. Use the alias firstday.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 3 Result.txt. Some results will be different because of the current date and time value.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Detyra 3
-- 
-- Selektoni kolonat qe permbajne:
--1--  Tre muaj nga data dhe ora aktuale. Perdorni alias threemonths.
--2--  Numrin e diteve midis dates aktuale dhe kolones (threemonths). Perdorni alias diffdays.
--3--  Numrin e javeve midis April 4, 1992, dhe September 16, 2011. Perdorni aliass diffweeks.
--4--  Diten e pare te muajit aktual bazuar ne daten dhe oren aktuale. Perdorni alias firstday.
--
-- Ekzekutoni query dhe krahasojeni me rezultatet ne file 53 - Lab Exercise 1 - Task 3 Result.txt. Disa rezualate do te jene te ndryshme per shkak te dates dhe ores aktuale.
---------------------------------------------------------------------
--1-- 
Select threemonths = EOMONTH(GETDATE(),3)
--
DECLARE @D1 DATETIME2 = GETDATE()  
SELECT THREEMONTHS = DATEADD(MONTH,3,@D1)
--
--2--
select DATEDIFF(day,GETDATE(),DATEADD(MONTH,3,GETDATE())) AS diffdays
--3--
select DATEDIFF(week,(convert(DATE,'1992-April-04')),(cast('2011-September-16' AS DATE))) as diffweeks
--4--
SELECT firstday = DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1)

---------------------------------------------------------------------
-- Task 4
-- The IT department has written a T-SQL statement that creates and populates a table named Sales.Somedates. 
-- Execute the provided T-SQL statement.
-- Write a SELECT statement against the Sales.Somedates table and retrieve the isitdate column. Add a new column named converteddate with a new date data type value based on the column isitdate. If the column isitdate cannot be converted to a date data type for a specific row, then return a NULL. 
-- Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 - Task 4 Result.txt. 
-- What is the difference between the SYSDATETIME and CURRENT_TIMESTAMP functions?
-- What is a language-neutral format for the DATE type?
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Detyra 4
--1-- Ekzekutoni query e meposhtme
--2-- Nxjerrni isitdate nga tabela Sales.Somedates, shtoni nje kolone te re te quajtur converteddate me nje tip te ri date bazuar ne kolonen isitdate. 
----- Nese kolona isitdate nuk mund te konvertohet ne tipin date per ndonje resht specifik, atehere ktheni vleren NULL. 
--3-- Ekzekutoni query dhe krahasojeni me rezultatet ne file 54 - Lab Exercise 1 - Task 4 Result.txt. 
--4-- Cila eshte diferenca midis funksioneve SYSDATETIME dhe CURRENT_TIMESTAMP?
--5-- Çfarë është një format neutral gjuhesor për tipin DATE?
---------------------------------------------------------------------

SET NOCOUNT ON;

DROP TABLE IF EXISTS Sales.Somedates;

CREATE TABLE Sales.Somedates (
	isitdate varchar(9)
);

INSERT INTO Sales.Somedates (isitdate) VALUES 
	('20110101'),
	('20110102'),
	('20110103X'),
	('20110104'),
	('20110105'),
	('20110106'),
	('20110107Y'),
	('20110108');

SET NOCOUNT OFF;

--2--
SELECT isitdate
FROM Sales.Somedates;

SELECT isitdate ,converteddate = (case when ISDATE(CONVERT(DATE,sal.isitdate)) = '1' then 'date' else 'NULL' END)
FROM Sales.Somedates sal
---
Alter table Sales.Somedates
Alter column isitdate varchar(9) not null
--4--
--CURRENT_TIMESTAMP nuk merr parameter eshte me shume si percaktues i nje tipi te dhene sic eshte koha lokale ne database ,
--eshte e tipit DATETIME dhe gjeneron të njëjtin rezultat sikurse GETDATE()
--SYSDATETIME() eshte sikurse CURRENT_TIMESTAMP ,koha e sistemit te operimit ne te cilin SQL DATABASE IS RUNNING ,
--karakterizohet nga titpi i te dhenes DATETIME2
---------------------------------------------------------------------

-- Task 5
-- 
-- copy-paste text about lab from doc file
---------------------------------------------------------------------
-- drop the table 

DROP TABLE Sales.Somedates;

---------------------------------------------------------------------
-- Detyra 5
-- 
-- Kopjoni tekstin rreth laboratorit nga file doc
---------------------------------------------------------------------
-- Fshini tabelen 

DROP TABLE Sales.Somedates;
-- STATEMENT u ekzekutua me sukses!!!