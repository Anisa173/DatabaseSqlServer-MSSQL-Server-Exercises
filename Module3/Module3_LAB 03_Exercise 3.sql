USE TSQL
GO
Select C.contactname,C.contacttitle
From Sales.Customers C
Select * From Sales.Customers sc 
SELECT concat(sc.city,' ' + sc.region) city_region
FROM Sales.Customers sc;
Select sc.city City,sc.country Country From Sales.Customers sc
Select sc.contactname Name,sc.contacttitle Title,sc.companyname CompanyName
From Sales.Customers sc
Select * From Production.Products Order By Production.Products.productname
Select P.productname Product_Name
From Production.Products P