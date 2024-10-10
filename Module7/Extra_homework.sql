USE AdventureWorks
GO 
--Extra Detyra ne databazen AdventureWorks
--1-- Nga tabela HumanResources.Departments perditesoni GroupName nga 'Executive General Administration" ne "General Administration"
--2-- Duam te perditesojme pagen e punonjesit me shtese prej 15% per punonjesit qe kane
--    mbi 10 vite të punesuar. Data e punesimit gjendet tek tabela HumanResources.Employees
--    ndersa paga gjendet tek EmployeePayHistory.

--1--
UPDATE HumanResources.Department 
SET GroupName = 'General Administration'
OUTPUT
inserted.DepartmentID,
deleted.GroupName as old_value,
inserted.GroupName as new_value
WHERE GroupName = 'Executive General and Administration'
GO

Select * From HumanResources.Department 
Select e.BusinessEntityID,eph.Rate,DATEDIFF(year,edh.StartDate,edh.EndDate) as experience  
From HumanResources.EmployeePayHistory eph INNER JOIN HumanResources.EmployeeDepartmentHistory 
edh ON eph.BusinessEntityID = edh.BusinessEntityID
           INNER JOIN HumanResources.Employee e ON edh.BusinessEntityID = e.BusinessEntityID
                                         Where DATEDIFF(year,edh.StartDate,GETDATE()) >10
Select * From HumanResources.EmployeeDepartmentHistory

--2--
Update HumanResources.EmployeePayHistory
SET Rate = Rate*(1+ 0.15)
OUTPUT
inserted.BusinessEntityID,
deleted.Rate as oldSalary,
inserted.Rate as newSalary
Where BusinessEntityID IN(
                Select e.BusinessEntityID
From HumanResources.EmployeePayHistory eph INNER JOIN HumanResources.EmployeeDepartmentHistory edh ON eph.BusinessEntityID = edh.BusinessEntityID
                                         INNER JOIN HumanResources.Employee e ON edh.BusinessEntityID = e.BusinessEntityID
                                         Where DATEDIFF(year,edh.StartDate,edh.EndDate) >10
)

go


--2. Perditesojme vetem pagat e punonjesve te departamentit te "Production"
Select * From HumanResources.EmployeePayHistory eph INNER JOIN HumanResources.Employee e ON eph.BusinessEntityID = e.BusinessEntityID
                                            INNER JOIN HumanResources.EmployeeDepartmentHistory d ON e.BusinessEntityID = D.BusinessEntityID
											INNER JOIN HumanResources.Department dep ON d.DepartmentID = dep.DepartmentID
Where dep.Name = 'Production'
----------------------------------------------------
update HumanResources.EmployeePayHistory 
set Rate = Rate*(1 + 0.15)
OUTPUT 
inserted.BusinessEntityID ,
deleted.Rate as oldSalary,
inserted.Rate as newSalary
where EXISTS (
Select e.BusinessEntityID
From HumanResources.EmployeePayHistory eph INNER JOIN HumanResources.Employee e ON eph.BusinessEntityID = e.BusinessEntityID
                                            INNER JOIN HumanResources.EmployeeDepartmentHistory d ON e.BusinessEntityID = D.BusinessEntityID
											INNER JOIN HumanResources.Department dep ON d.DepartmentID = dep.DepartmentID
Where dep.Name = 'Production'
)

--Neser do fillojme te shesim disa produkte te reja, te cilat duhen importuar nga databaza TSQL 
--ne databazen AdventureWorks. Databaza AdventureWorks ka kategori dhe subcategory; kete plotesojeni 
--me emrin e kategorise se databazes TSQL; vendosini njesoj edhe category dhe subcategory.
--Cmimin do e vendosni 25% me te larte se cmimi i databazes TSQL. StandartCost njesoj si cmimi i databazes TSQL.
--Ndersa productnumber vendose TSQL-dy germa nga fjala e dyte e emrit te produktit-10- - - 
--dhe filloni me 10001 deri sa te kete produkte ne numer rendor.
--Ne disa kolona si MakeFlag dhe FinishedGoods thjeshte vendosni numrin 1. 
--Ne kolona te tjera si reorderpoint etj vendosni vete nje numer si 900.

