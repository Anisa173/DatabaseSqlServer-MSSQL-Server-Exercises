---------------------------------------------------------------------
-- LAB 18
--
-- copy-paste text about lab from doc file
--
-- Exercise 1
---------------------------------------------------------------------
USE TSQL;
GO
---------------------------------------------------------------------
-- Task 1
-- 
-- The IT department has provided the following T-SQL code.
--
--1-- This code inserts two rows into the HR.Employees table. By default, SQL Server treats each 
-- individual statement as a transaction. In other words, by default, SQL Server automatically commits 
-- the transaction at the end of each individual statement. So in this case the default behavior would be 
-- two transactions since you have two INSERT statements. (Do not worry about the details of the INSERT statements 
-- because they are only meant to provide sample code for the transaction scenario.)
-- In this example, you would like to control the transaction and execute both INSERT statements inside one transaction.
-- Before the supplied T-SQL code, write a statement to open a transaction. After the supplied
-- INSERT statements, write a statement to commit the transaction. Highlight all of the T-SQL code and execute it.
-- Observe and compare the results that you got with the desired results shown in
-- the file 52 - Lab Exercise 1 - Task 1_1 Result.txt.
--2-- Write a SELECT statement to retrieve the empid, lastname, and firstname columns from the HR.Employees table.
-- Order the employees by the empid column in descending order. Execute the SELECT statement.
-- Observe and compare the results that you got with the desired results shown in the file 53 
-- - Lab Exercise 1 - Task 1_2 Result.txt. Notice the two new rows in the result set.
---------------------------------------------------------------------
go
CREATE PROCEDURE insertData
AS
Begin
     BEGIN TRY
               BEGIN TRANSACTION
              INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
               city, region, postalcode, country, phone, mgrid)
              VALUES (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101', N'Some Address 18', 
               N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
              INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
               city, region, postalcode, country, phone, mgrid)
              VALUES (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '20110601', N'Some Address 22', 
               N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);
               COMMIT TRANSACTION
     END TRY
     Begin CATCH
			 SELECT ERROR_MESSAGE() as errMsg,ERROR_SEVERITY() as errSeverity , ERROR_STATE() errState , ERROR_NUMBER() errNumb 
			 ROLLBACK TRANSACTION
	 END CATCH
    
END
GO

exec insertData
go

Select * From HR.Employees
--2--
GO
CREATE PROCEDURE selectEmployeeRecorde(@empId int)
as
BEGIN
   begin try
      BEGIN TRANSACTION
	      SELECT e.empid , e.firstname , e.lastname
		  FROM HR.Employees as e
          WHERE e.empid > @empId
		  ORDER BY e.empid desc
	  COMMIT TRANSACTION
   end try
   begin catch
   Select ERROR_MESSAGE() AS ERROR_MESSAGE, ERROR_PROCEDURE() AS ERROR_PROCEDURE,ERROR_NUMBER() AS ERROR_NUMBER,
   ERROR_SEVERITY() AS ERROR_SEVERITY, ERROR_STATE() AS ERROR_STATE
   ROLLBACK TRANSACTION
   end catch
END
GO

EXEC selectEmployeeRecorde @empId = 0 
GO
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 2
-- 
-- Execute the provided T-SQL code to delete rows inserted from the previous task.
---------------------------------------------------------------------
DELETE HR.Employees
WHERE empid IN (10, 11);
DBCC CHECKIDENT ('HR.Employees', RESEED, 9);
----
GO
CREATE procedure deleteEmployee(@EmployeeID INT)
as
BEGIN
    BEGIN TRY
	   BEGIN TRANSACTION
	      DELETE HR.Employees
          WHERE empid=@EmployeeID
         -- DBCC CHECKIDENT ('HR.Employees', RESEED, 9);
	   COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() as ErrorMessage,ERROR_NUMBER() as ERROR_NUMBER,ERROR_PROCEDURE() as ERROR_PROCEDURE ,
     ERROR_SEVERITY() as ERROR_SEVERITY
	ROLLBACK TRANSACTION
	END CATCH
END
GO

EXEC deleteEmployee @EmployeeID = 10
GO
EXEC deleteEmployee @EmployeeID = 11
GO

Select * from HR.Employees

---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 3
-- 
--1-- The IT department has provided T-SQL code (which happens to the same code as in task 1). 
--  Before the provided T-SQL code, write a statement to start a transaction.
-- Highlight the written statement and the provided T-SQL code, and execute it.
--2-- Write a SELECT statement to retrieve the empid, lastname, and firstname columns from the
--  HR.Employees table. Order the employees by the empid column.
-- Execute the written SELECT statement and notice the two new rows in the result set.
-- Observe and compare the results that you got with the desired results shown in
-- the file 54 - Lab Exercise 1 - Task 3_1 Result.txt.
--3-- After the written SELECT statement, write a ROLLBACK statement to cancel the
--  transaction. Execute only the ROLLBACK statement.

--  Highlight and again execute the written SELECT statement against the HR.Employees table.
-- Observe and compare the results that you got with the desired results shown in the file 55
-- - Lab Exercise 1 - Task 3_2 Result.txt. Notice that the two new rows are no longer present in the table. 
---------------------------------------------------------------------

INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
city, region, postalcode, country, phone, mgrid)
VALUES (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101', N'Some Address 18', 
N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
city, region, postalcode, country, phone, mgrid)
VALUES (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '20110601', N'Some 
Address 22', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);
---E njejte me kerkesen ne TASK1
--1--
GO
CREATE PROCEDURE insertDatas
AS
Begin
     BEGIN TRY
               BEGIN TRANSACTION
              INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
               city, region, postalcode, country, phone, mgrid)
              VALUES (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101', N'Some Address 18', 
               N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
              INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
               city, region, postalcode, country, phone, mgrid)
              VALUES (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '20110601', N'Some Address 22', 
               N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);
               COMMIT TRANSACTION
     END TRY
     Begin CATCH
			 SELECT ERROR_MESSAGE() as errMsg,ERROR_SEVERITY() as errSeverity , ERROR_STATE() errState , ERROR_NUMBER() errNumb 
			 ROLLBACK TRANSACTION
	 END CATCH
END
GO

exec insertDatas
GO

Select * From HR.Employees
---2--
Select e.lastname , e.firstname , e.empid
From HR.Employees	e
--3--
GO
CREATE PROCEDURE insertData3
AS
Begin
     BEGIN TRY
         BEGIN TRANSACTION
              INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
               city, region, postalcode, country, phone, mgrid)
              VALUES (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101', N'Some Address 18', 
               N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
              INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, 
               city, region, postalcode, country, phone, mgrid)
              VALUES (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '20110601', N'Some Address 22', 
               N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);
         COMMIT TRANSACTION
      END TRY
     Begin CATCH
	   IF(XACT_STATE() = -1)
        BEGIN
            PRINT N'An error occurred!It is a user UNCOMMITABLE Transaction.It should be done "ROLLBACK" '
        END
	        SELECT ERROR_MESSAGE() as errMsg,ERROR_SEVERITY() as errSeverity , ERROR_STATE() errState , ERROR_NUMBER() errNumb 
			 ROLLBACK TRANSACTION
	 END CATCH
END
GO
exec insertData3
go
Select * From HR.Employees
--OSE 'TO CANCEL TRANSACTION' ONLYYY ROLLBACK
GO
ALTER PROCEDURE insertData4
AS
Begin
     SET XACT_ABORT ON
       
        PRINT N'An error occurred!It is a user UNCOMMITABLE Transaction.It should be done "ROLLBACK" '
               BEGIN TRANSACTION
              
               COMMIT TRANSACTION
         END
     
GO
exec insertData4
go
Select * From HR.Employees

---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 4
-- 
-- Execute the provided T-SQL code.
---------------------------------------------------------------------

DBCC CHECKIDENT ('HR.Employees', RESEED, 9);
---------------------------------------------------------------------
---------------------------------------------------------------------
-- LAB 18
--
-- copy-paste text about lab from doc file
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
--1-- The IT department has provided T-SQL code that is similar to the code in the previous exercise.
-- Execute only the SELECT statement.
-- Observe and compare the results that you got with the desired results shown in the file 62
-- - Lab Exercise 2 - Task 1_1 result.txt. Notice the number of employees in the HR.Employees table.
--2--  Execute the part of the T-SQL code that starts with a BEGIN TRAN statement and ends with the COMMIT TRAN
-- statement. You will get a conversion error in the second INSERT statement. 
--3--  Again execute only the SELECT statement.
--  Observe and compare the results that you got with the desired results shown in the file 63
-- - Lab Exercise 2 - Task 1_2 Result.txt. Notice that although you got an error inside the
--  transaction block, one new row was added to the HR.Employees table based on the first INSERT statement.
--   
---------------------------------------------------------------------
--1--
SELECT empid, lastname, firstname
FROM HR.Employees
ORDER BY empid DESC;

GO
Select * From HR.Employees E
ORDER BY E.empid DESC
---
SELECT COUNT(*) AS noEmployee FROM HR.Employees 
--2--
BEGIN TRAN;

INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, 
address, city, region, postalcode, country, phone, mgrid)
VALUES (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101', N'Some 
Address 18', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, 
address, city, region, postalcode, country, phone, mgrid)
VALUES (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '10110601', 
N'Some Address 22', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);
COMMIT TRAN;

GO
--3--
SELECT empid, lastname, firstname
FROM HR.Employees
ORDER BY empid DESC;

GO


---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 2
-- 
-- Execute the provided T-SQL code to delete the row inserted from the previous task.
-- Note that this is a cleanup code that will not be explained in this course.
---------------------------------------------------------------------

DELETE HR.Employees
WHERE empid IN (10, 11);
DBCC CHECKIDENT ('HR.Employees', RESEED, 9);
----
Select * From HR.Employees
--------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 3
-- 
--1-- Modify the provided T-SQL code to include a TRY / CATCH block that rolls back the entire 
--    transaction if any of the INSERT statements throws an error:
--    In the CATCH block, include a PRINT statement that prints the message “Rollback the transaction…” 
--    if an error occurred and the message “Commit the transaction…” if no error occurred. 
--2-- Execute the modified T-SQL code.
--    Observe and compare the results that you got with the recommended result shown in the file 64
--    Lab Exercise 2 - Task 3_1 Result.txt.
--3-- Write a SELECT statement against the HR.Employees table to see if any new rows
--    were inserted (like you did in exercise 1). Execute the SELECT statement.
--    Observe and compare the results that you got with the recommended result shown
--    in the file 65 - Lab Exercise 2 - Task 3_2 Result.txt.
---------------------------------------------------------------------
--1--
GO
CREATE PROCEDURE insertDatas5(
@lastname NVARCHAR(20) = 'Johnson',
@firstname nvarchar(10) = 'Test 1',
@title nvarchar(30) = 'Sales Manager',
@titleofcourtesy nvarchar(25) = 'Mr.',
@birthday datetime = '19700101',
@hiredate datetime = '20110101',
@address nvarchar(60)='Some Address 18',
@city nvarchar(15)='Ljubljana',
@region nvarchar(15) = 'null',
@postalcode nvarchar(10) = '1000',
@country nvarchar(15) = 'Slovenia',
@phone nvarchar(24) = '(386) 113322' ,
@mgrid int = 2
)
AS
BEGIN
      BEGIN TRY
       BEGIN TRANSACTION
         INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, 
         address, city, region, postalcode, country, phone, mgrid)
         VALUES (@lastname, @firstname, @title,@titleofcourtesy, @birthday, @hiredate,@address,
          @city, @region, @postalcode, @country, @phone, @mgrid);
        
	--	INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, 
    --     address, city, region, postalcode, country, phone, mgrid)
     --    VALUES (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '10110601',
     --     N'Some Address 22', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);
       COMMIT TRANSACTION
      END TRY
	  BEGIN CATCH
         IF(XACT_STATE() = -1)
		 BEGIN
		 PRINT N'An error occurred,RollBack Transaction...'
		 END
     ELSE IF(XACT_STATE() = 1)
         BEGIN
	     PRINT N'A user commitable transaction is waiting,COMMIT TRANSACTION...'
	     END
     ELSE IF(XACT_STATE() = 0)
	  BEGIN
	   PRINT N'No action needed!'
	  END
     ELSE 
     BEGIN
	 PRINT N''
	 END
	 ROLLBACK TRANSACTION
	  END CATCH
END
GO
Commands completed successfully.

Completion time: 2024-08-31T11:31:30.1240443+02:00

--2--
EXECUTE insertDatas5
GO
--Kontrollojme nese eshte shtuar rekordi
SELECT * FROM HR.Employees
--Insertojmë rreshtin e dytë
GO
ALTER PROCEDURE insertDatas5(
              @lastname NVARCHAR(20) ,
              @firstname nvarchar(10) ,
              @title nvarchar(30) ,
              @titleofcourtesy nvarchar(25),
              @birthday datetime ,
              @hiredate datetime ,
              @address nvarchar(60),
              @city nvarchar(15),
              @region nvarchar(15) ,
              @postalcode nvarchar(10) ,
              @country nvarchar(15) ,
              @phone nvarchar(24)  ,
              @mgrid int 
)
   AS
   BEGIN
      BEGIN TRY
       BEGIN TRANSACTION
         INSERT INTO HR.Employees (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, 
         address, city, region, postalcode, country, phone, mgrid)
         VALUES (@lastname, @firstname, @title,@titleofcourtesy, @birthday, @hiredate,@address,
          @city, @region, @postalcode, @country, @phone, @mgrid);
       
       COMMIT TRANSACTION
      END TRY
	  BEGIN CATCH
         IF(XACT_STATE() = -1)
		 BEGIN
		 PRINT N'An error occurred,RollBack Transaction...'
		 END
     ELSE IF(XACT_STATE() = 1)
         BEGIN
	     PRINT N'A user commitable transaction is waiting,COMMIT TRANSACTION...'
	     END
     ELSE IF(XACT_STATE() = 0)
	  BEGIN
	   PRINT N'No action needed!'
	  END
     ELSE 
     BEGIN
	 PRINT N''
	 END
	 ROLLBACK TRANSACTION
	  END CATCH
END
GO
----
Commands completed successfully.

Completion time: 2024-08-31T13:28:51.8084490+02:00
---
--2--
EXECUTE insertDatas5 @lastname = N'Robertson' , @firstname = N'Test 2',
@title = N'Sales Representative',@titleofcourtesy = N'Mr.' , @birthday = '1985-01-01',
@hiredate = '2011-06-01',@address = N'Some Address 22' , @city = N'Ljubljana',
@region = 'NULL', @postalcode = N'1000' ,@country = N'Slovenia' ,@phone = N'(386) 553344',@mgrid = 10
     
GO
Select * From HR.Employees



---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 4
-- 
-- Execute the provided T-SQL code.
---------------------------------------------------------------------

DBCC CHECKIDENT ('HR.Employees', RESEED, 9);
---------------------------------------------------------------------
