
--	Detyre per fundjaven:
--		Ne tabelat 1) Production.WorkOrder dhe 2) Production.WorkOrderRouting tregohen detyrat qe u jane dhene punonjesve
--		 te kompanise. Ne rastin e kompanise AdventureWorks, tabelat tregojne detyrat e punonjesve te magazines.

--	Duam te bejme nje analize te detyrave te kryera nga punonjesit dhe magazines.
--	1. Tregoni sa sasi produktesh jane bere Scrap, dhe sa perqind e Scrap nga Stocked Quantity
--	a. Sa lek kemi hedhur poshte duke shumezuar cmimin e produktit (nga tabela Production.Product) me sasine e Scrapit.
--	2. Analizoni Planned Cost vs Actual Cost te taskeve ne tabelen Production.WorkOrderRouting
--	a. Mesatarisht sa dite me vonese e fillojne punonjesit punen per taskun duke krahasuar 
--     ScheduledStart vs Actual StartDate.

Use AdventureWorks
Go
--1--M1---
go
alter procedure Production.workerorderScrap(@ProductId int )
as
Begin
Select pp.ProductID as Id_Product,wo.ScrappedQty as ScrappedQuantity , percentScrapStock = (wo.ScrappedQty/wo.StockedQty)*100,
ScrapAmountMoney = wo.ScrappedQty * pp.ListPrice
From Production.WorkOrder wo inner join Production.Product pp on wo.ProductID = pp.ProductID
WHERE pp.ProductID>@ProductId
Order by pp.ProductID
end
GO
EXEC Production.workerorderScrap @ProductId = 0
GO
--Select * From Production.WorkOrder where ProductID = 3
--Select * From Production.Product
--M2--
go
Create procedure Production.workerorderScrap1(@ProductId int )
as
Begin
Select pp.ProductID as Id_Product,Sum(wo.ScrappedQty) as ScrappedQuantity , percentScrapStock = (sum(wo.ScrappedQty)/sum(wo.StockedQty))*100,
ScrapAmountMoney = Sum(wo.ScrappedQty * pp.ListPrice)
From Production.WorkOrder wo inner join Production.Product pp on wo.ProductID = pp.ProductID
WHERE pp.ProductID>@ProductId
group by pp.ProductID
Order by pp.ProductID
end
GO
------
Commands completed successfully.

Completion time: 2024-09-08T17:02:07.1974866+02:00
------
EXEC Production.workerorderScrap1 @ProductId = 0
GO
--M3-------------
go
Create procedure Production.workerorderScrapTotal
as
Begin
Select Sum(wo.ScrappedQty) as ScrappedQuantity , percentScrapStock = (sum(wo.ScrappedQty)/sum(wo.StockedQty))*100,
ScrapAmountMoney = Sum(wo.ScrappedQty * pp.ListPrice)
From Production.WorkOrder wo inner join Production.Product pp on wo.ProductID = pp.ProductID
end
GO
EXEC Production.workerorderScrapTotal 
GO
--2--
go 
alter procedure Production.workOrderRoutingg(@TaskId int)
as 
begin
Select WorkOrderID TaskId,diteShteseFillimi=Sum(datediff(day,ScheduledStartDate,ActualStartDate)), 
diteShtesePerfundimi =Sum(datediff(day,ScheduledEndDate,ActualEndDate)),kostoShtese = Sum(ActualCost - PlannedCost)
From Production.WorkOrderRouting 
Where WorkOrderID>@TaskId
group by WorkOrderID
end
go
---------------------------------------------------------
Commands completed successfully.

Completion time: 2024-09-08T16:34:34.9853179+02:00
---------------------------------------------------------
exec Production.workOrderRoutingg @TaskId = 0
go
--Select * From Production.WorkOrderRouting

