---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- In order to better understand the needed tasks, you will first write a SELECT statement against the HR.Employees table showing the empid, lastname, firstname, title, and mgrid columns.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt. Notice the values in the mgrid column. The mgrid column is in a relationship with empid column. This is called a self-referencing relationship. 
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Detyre 1
-- 
-- Qe te kuptoni me mire detyrat e kerkuara, fillimisht selektoni kolonat empid, lastname, firstname, 
-- title dhe mgrid nga tabela HR.Employees.
-- Ekzekutoni veprimet dhe krahasoni rezultatet qe moret me rezultatet e rekomanduara ne dokumentin 72 - Lab Exercise 3 - Task 1 Result.txt. 
-- Vereni vlerat ne kolonen mgrid. Kolona mgrid eshte e lidhur me kolonen empid.Kjo eshte e quajtur lidhja vete-referim. 
---------------------------------------------------------------------

Select hrEmp.empid,hrEmp.firstname EmployeeFirstName,hrEmp.lastname EmployeeLastName,hrEmp.title Employee_Title,
hrMgr.mgrid,hrMgr.firstname ManagerFirstName,hrMgr.lastname ManagerLastName,hrMgr.title ManagerTitle,*
From HR.Employees hrEmp INNER JOIN HR.Employees hrMgr ON hrEmp.empid=hrMgr.mgrid
----------
Select hrEmp.empid,hrEmp.firstname EmployeeFirstName,hrEmp.lastname EmployeeLastName,hrEmp.title Employee_Title,
hrMgr.mgrid,hrMgr.firstname ManagerFirstName,hrMgr.lastname ManagerLastName,hrMgr.title ManagerTitle
From HR.Employees hrEmp INNER JOIN HR.Employees hrMgr ON hrEmp.empid=hrMgr.mgrid
---------------------------------------------------------------------
-- Task 2
-- 
-- Copy the SELECT statement from task 1 and modify it to include additional columns for the manager information (lastname, firstname) using a self-join. Assign the aliases mgrlastname and mgrfirstname, respectively, to distinguish the manager names from the employee names.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt. Notice the number of rows returned.
--
-- Is it mandatory to usetable aliases when writing a statement with a self-join? Can you use a full source table name as alias? Please explain.
--
-- Why did you get fewer rows in the T-SQL statement under task 2 compared to task 1?
---------------------------------------------------------------------


---------------------------------------------------------------------
-- Detyre 2
-- 
-- Kopjo veprimet nga Detyra 1 dhe  modifiko ate duke shtuar kolona duke shfaqur informacion mbi manaxherin (lastname, firstname)duke perdorur nje self-join. Perdorni alias mgrlastname dhe mgrfirstname, respektivisht, per te dalluar emrat e manaxhereve nga emrat e punonjesve.
--
-- Ekzekutoni veprimet dhe krahasoni rezultatet qe moret me rezultatet e rekomanduara ne dokumentin  73 - Lab Exercise 3 - Task 2 Result.txt. Vereni numrin e rrjeshtave qe kthehen.Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt. Notice the number of rows returned.
--
-- A eshte e detyrueshme perdorimi i alias te tabelave kur jeni duke perdorur nje self-join? A mund te perdoresh nje tabele te plote me emra si alias? Shpjego.
--
-- Pse kemi me pak rrjeshta ne  T-SQL statement ne Detyren 2 krahasuar me Detyren 1?
---------------------------------------------------------------------
Select hrEmp.empid EmployeeId,hrEmp.firstname EmployeeFirstName,hrEmp.lastname EmployeeLastName,hrEmp.title Employee_Title,
hrMgr.mgrid ManagerId,hrMgr.firstname mgrfirstname,hrMgr.lastname mgrlastname,hrMgr.title mgrTitle
From HR.Employees hrEmp INNER JOIN HR.Employees hrMgr ON hrEmp.empid=hrMgr.mgrid
