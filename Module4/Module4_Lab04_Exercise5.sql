---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 5
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--  Execute the T-SQL code under Task 1. Do not worry if you do not understand the provided T-SQL code,
--  as it is used here to provide a more realistic example for a cross join in the next task. 
---------------------------------------------------------------------
SET NOCOUNT ON;

IF OBJECT_ID('HR.Calendar') IS NOT NULL 
	DROP TABLE HR.Calendar;

CREATE TABLE HR.Calendar (
	calendardate DATE CONSTRAINT PK_Calendar PRIMARY KEY
);

DECLARE 
	@startdate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 1, 1),
	@enddate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31);

WHILE @startdate <= @enddate
BEGIN
	INSERT INTO HR.Calendar (calendardate)
	VALUES (@startdate);

	SET @startdate = DATEADD(DAY, 1, @startdate);
END;

SET NOCOUNT OFF;

GO
-- observe the HR.Calendar table
SELECT 
	calendardate
FROM HR.Calendar;
---------------------------------------------------------------------
-- Detyre 1
-- 
-- Ekzekutoni kodin T-SQL poshte ne Detyren 1. Mos u shqetesoni ne qoftese nuk kuptoni kodin e ofruar te  T-SQL code, 
-- pasi eshte perdorur ketu  per te ofruar nje shembull me realistik per cross join ne detyren tjeter. 
---------------------------------------------------------------------
SET NOCOUNT ON;

IF OBJECT_ID('HR.Calendar') IS NOT NULL 
	DROP TABLE HR.Calendar;

CREATE TABLE HR.Calendar (
	calendardate DATE CONSTRAINT PK_Calendar PRIMARY KEY
);

DECLARE 
	@startdate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 1, 1),
	@enddate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31);

WHILE @startdate <= @enddate
BEGIN
	INSERT INTO HR.Calendar (calendardate)
	VALUES (@startdate);

	SET @startdate = DATEADD(DAY, 1, @startdate);
END;

SET NOCOUNT OFF;

GO
-- observe the HR.Calendar table
SELECT 
	calendardate
FROM HR.Calendar;
---------------------------------------------------------------------
-- Task 2
-- 
--1-- Write a SELECT statement to retrieve the empid, firstname, and lastname columns from the HR.Employees table 
-- and the calendardate column from the HR.Calendar table.
--2-- Execute the written statement and compare the results that you got with the recommended result shown in the file 92 - Lab Exercise 5 - Task 2 Result.txt. 
--
--3-- What is the number of rows returned by the query? There are nine rows in the HR.Employees table. Try to calculate the total number of rows in the HR.Calendar table.
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyre 2
-- 
--1-- Selektoni kolonat empid, firstname, dhe lastname nga tabela HR.Employees dhe kolonen calendardate nga tabela HR.Calendar.
--
--2-- Ekzekutoni veprimet dhe krahasoni rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 92 - Lab Exercise 5 - Task 2 Result.txt. 
--
--3-- Sa eshte numri i rrjeshtave qe nxjerr query? Jane 9 rrjeshta ne tabelen HR.Employees. Perpiquni te llogaritni numrin total te rrjeshtave ne tabelen in the HR.Calendar.
---------------------------------------------------------------------
Select e.empid,e.firstname,e.lastname,c.calendardate
From HR.Employees e CROSS JOIN HR.Calendar c 
--Order By concat(e.firstname,' ',e.lastname) 
--numri i rreshtave eshte :9x366=3294 pra çdo punonjës në çdo ditë të vitit

---------------------------------------------------------------------
-- Task 3
-- 
-- Execute the provided T-SQL statement to remove the HR.Calendar table.
---------------------------------------------------------------------

IF OBJECT_ID('HR.Calendar') IS NOT NULL 
	DROP TABLE HR.Calendar;

---------------------------------------------------------------------
-- Detyre 3
-- 
-- EKzekutoni kodin T-SQL per te hequr tabelen the HR.Calendar.
---------------------------------------------------------------------

IF OBJECT_ID('HR.Calendar') IS NOT NULL 
	DROP TABLE HR.Calendar;
