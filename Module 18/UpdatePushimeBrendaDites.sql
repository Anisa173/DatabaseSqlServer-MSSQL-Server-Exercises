Use AdventureWorks
go
---Pushimet brenda 1 dite
Create PROCEDURE [HumanResources].[updateEmpVacationH_SickHours_ReportDay]
(@empID as int,
 @SickHours int,
 @VacationHours INT,
 @dateFrom datetime
 )
as
BEGIN
    Begin try
    Begin transaction
	          IF((@SickHours > 0) and (@VacationHours = 0))
	             Begin
	               Print N'Define your SickHours'
				   UPDATE [HumanResources].[Employee]
                   SET SickLeaveHours = SickLeaveHours - @SickHours 
		           Where BusinessEntityID = @empID
				 End
              IF((@VacationHours > 0) and (@SickHours = 0))
	             Begin
	               PRINT N'Define your VacationHours'
				   UPDATE [HumanResources].[Employee]
                   SET VacationHours = VacationHours - @VacationHours
		           Where BusinessEntityID = @empID
				 End
	 Commit transaction
	 End Try
	 Begin CATCH
	     IF(XACT_STATE() = -1)
          Begin
            Print N'An error occurred!A user uncommitable transaction is pending,ROLLBACK Transaction...'
	      End
         IF(XACT_STATE() = 1)	
	      Begin
	        Print N'A user Commitable transaction is pending,COMMIT Transaction...'
	      End
         IF(XACT_STATE() = 0)	
	      Begin
	        Print N'There is not any user transaction with status pending,No action Needed!'
	      End
	 End CATCH

END
GO
---Pushimet e marrura nga punonjesi per nje interval te caktuar kohe
GO

ALTER PROCEDURE [HumanResources].[updateEmpVacationH_SickHours_ReportDayss]
(@empID as int,
 @TypeOf nvarchar(20),
 @dateFrom date,
 @noDays int ,
 @dateTo date OUTPUT)
  as
  BEGIN
      Begin try
         Begin transaction
                     DECLARE @SickHours int ,@VacationHours INT
                     SET @VacationHours = @noDays*8 
                     SET @SickHours = @noDays*8
					 SET  @dateTo = CAST(DATEADD(day,@noDays,@dateFrom) as date)
					IF(@TypeOf = N'vacationHours')
                          Begin
              if @VacationHours>(select VacationHours from HumanResources.Employee as e 
                     WHERE   BusinessEntityID= @empID)
	                  throw 500001, 'not enough days',0;
			           --IF((@SickHours = 0) AND (@VacationHours > 0))
						Begin
					                 UPDATE [HumanResources].[Employee]
                                     SET VacationHours = VacationHours - @VacationHours
                                     FROM [HumanResources].[Employee] he
                                     WHERE BusinessEntityID =@empID  
                            End        
                     End
                   Else if(@TypeOf = N'sickleaveHours')
                          Begin                 
                     if  @SickHours <=(select SickLeaveHours from HumanResources.Employee as e 
					     WHERE   BusinessEntityID= @empID)
					     throw 50001,'not enough sick hours',0;
                               Begin
							        UPDATE [HumanResources].[Employee]
                                    SET SickLeaveHours = SickLeaveHours - @SickHours
                                    FROM [HumanResources].[Employee] he
                                    WHERE   he.BusinessEntityID= @empID                       
                                End
	                      END
            
	     Commit transaction
       End Try
       Begin CATCH 
         IF(XACT_STATE() = -1)
          Begin
            Print N'An error occurred!A user uncommitable transaction is pending,ROLLBACK Transaction...'
	        RollBack transaction
	      End
        IF(XACT_STATE() = 1)	
	      Begin
	        Print N'A user Commitable transaction is pending,COMMIT Transaction...'
			    
	    RollBack Transaction
		 End
        IF(XACT_STATE() = 0)	
	      Begin
	        Print N'There is not any user transaction with status pending,No action Needed!'
	      End
    
    End CATCH
end
GO

Declare @employeeId int = 4 ,@TypeOfVacation nvarchar(40)=N'vacationHours' , @firstdate date = '2006-05-05',
@vacationDays int = 24 ,@lastdate date 
Execute [HumanResources].[updateEmpVacationH_SickHours_ReportDayss] @empID = @employeeId,@TypeOf = @TypeOfVacation,
@dateFrom  = @firstdate ,@noDays = @vacationDays ,@dateTo = @lastdate OUTPUT
SELECT @employeeId  empID ,@TypeOfVacation VacationType , @firstdate dateFrom , @vacationDays as noDays ,
@lastdate dateTo 

Select * From HumanResources.Employee