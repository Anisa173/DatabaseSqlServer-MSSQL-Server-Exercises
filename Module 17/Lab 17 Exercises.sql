USE TSQL;
GO
--EXERCISE I
--Task 1: Write a Basic TRY/CATCH construct

SELECT CAST(N'Some text' AS int);

---------------------------------------------

Create procedure printText
as 
BEGIN
    BEGIN TRY
    SELECT CAST(N'Some text' AS int)
	End TRY
	Begin CATCH
	SELECT 
	ERROR_MESSAGE() AS ErrorMessage,
	ERROR_SEVERITY()  AS ErrorSeverity,
	ERROR_STATE() AS ErrorState,
	ERROR_LINE() AS errorLine,
    ERROR_NUMBER() AS errorNumber,
	ERROR_PROCEDURE() AS errorProcedure
	END CATCH
END
go

EXEC printText
GO

--Task 2: Display an error number and an error message

------------------
CREATE PROCEDURE printNum(@num varchar(20) ='0')
as Begin
     BEGIN TRY
       PRINT (5. / CAST(@num AS numeric(10,4)));
     END TRY
     BEGIN CATCH
             Select
	            ERROR_NUMBER() errNumber,ERROR_MESSAGE() as errMessage
	 END CATCH
END
GO
EXEC printNum
GO


--Task 3: Add conditional logic to a CATCH block

CREATE PROCEDURE printNumaa(@num varchar(20) = 'A')
as
BEGIN
    BEGIN TRY
        DECLARE @num1 as INT = (5. / CAST(@num AS numeric(10,4)));
         IF(@num1>0)
               Begin
                PRINT @num1 ;
               End
         ELSE
            BEGIN
             PRINT N''
            END

    END TRY
    BEGIN CATCH
       PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
       PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH
END
GO

exec printNumaa
go

--Task 4: Execute a stored procedure in the CATCH block

--Create Procedure
CREATE PROCEDURE dbo.GetErrorInfo 
AS
Begin
    BEGIN TRY
       DECLARE @num varchar(20),@numInt int ;
       SET @num = '0'
       SET @numInt = (5. / CAST(@num AS numeric(10,4)))
       PRINT @numInt;
   END TRY
   BEGIN CATCH
       PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
       PRINT 'Error Message: ' + ERROR_MESSAGE();
       PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS varchar(10));
       PRINT 'Error State: ' + CAST(ERROR_STATE() AS varchar(10));
       PRINT 'Error Line: ' + CAST(ERROR_LINE() AS varchar(10));
       PRINT 'Error Proc: ' + COALESCE(ERROR_PROCEDURE(), 'Not within procedure');
   END CATCH
End
GO
EXECUTE dbo.GetErrorInfo 
GO

--	EXERCISE II
--Task1
-- Re-throw the existing error back to a client
CREATE Procedure reThrowError(@num varchar(20),@numInt int OUTPUT)
AS
BEGIN 

BEGIN TRY
SET @numInt = (5. / CAST(@num AS numeric(10,4)))
PRINT @numInt
END TRY
BEGIN CATCH
Print N'An Error occurred'+'---- ' + ERROR_MESSAGE() ;
THROW;
END CATCH;
END
GO
DECLARE @a1 varchar(20) = '0',@num1 int
EXEC reThrowError @num = @a1,@numInt = @num1 OUTPUT
Select @a1 as teksti , @num1 as result
GO

--Task 2: Add an error handling routine

create procedure GetError(@num varchar(20),@numInt int OUTPUT)
AS
BEGIN 

BEGIN TRY

IF(@@ERROR>8134)
BEGIN
SET @numInt = (5. / CAST(@num AS numeric(10,4)))
PRINT N'Handling division by zero...';
End
Else 
BEGIN
PRINT N'Throwing original Error'
End
END TRY
BEGIN CATCH
Print N'An Error occurred'+'---- ' + ERROR_MESSAGE() ;
throw;
END CATCH;
END
GO
-------------------------------------------
Commands completed successfully.

Completion time: 2024-08-28T22:03:32.3924491+02:00
--------------------------------------------------------

DECLARE @a1 varchar(20) = '0',@num1 int
EXEC GetError @num = @a1,@numInt = @num1 OUTPUT
Select @a1 as teksti , @num1 as result
GO

--Task 3: Add a different error handling routine

DECLARE @msg NVARCHAR(2048) = FORMATMESSAGE(N'You are doing the exercise for Module 17 on ' + 
	FORMAT(CURRENT_TIMESTAMP, 'MMMM d, yyyy', 'en-US') + 
	'.It''s not an error but it means that you are near the final module!');

THROW 50001, @msg,1


--Task 4: Remove the stored procedure
DROP  PROCEDURE dbo.GetErrorInfo

--Detyra 4: Hiq procedurën e ruajtur
DROP  PROCEDURE dbo.GetErrorInfo
