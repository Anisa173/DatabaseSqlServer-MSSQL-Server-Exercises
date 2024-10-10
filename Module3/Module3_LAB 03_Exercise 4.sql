use TSQL
GO
-- Write a SELECT statement to display the categoryid and productname columns from the Production.Products 
-- table
Select p.categoryid Category_Id , p.productname ProductName
From Production.Products p
-- shkruani te njejtat veprime si ne Detyren 1 duke shtuar nje CASE expression, 
-- qe gjeneron si rezultat nje kolone te quajtur categoryname.
-- Kolona e re duhet te mbaje perkthimin e kategorise ID respektivisht me kategorine name, 
-- bazuar ne tablen mapping te dhene. Perdor vleren “Other” per cdo kategori te IDs 
-- qe nuk gjendet ne tabelen mapping.
Select pP.categoryid Category_Id , pC.categoryname CategoryName,
pP.productname ProductName,
case when pP.categoryid='' then 'pC.categoryname' 
else 'OTHER' END as [nuk_ekziston]
From Production.Products pP INNER JOIN Production.Categories pC ON pP.categoryid=pC.categoryid

-- Modify the SELECT statement in task 2 by adding a new column named iscampaign.   
-- This will show the description “Campaign Products” for the categories Beverages, Produce, and Seafood
-- and the description “Non-Campaign Products” for all other categories.

Select pP.categoryid Category_Id , pC.categoryname CategoryName,
pP.productname ProductName,case when pC.categoryname='Beverages' then 'Campaign Products'
 when pC.categoryname='Produce' then 'Campaign Products' when pC.categoryname='Seafood' then 'Campaign Products' 
else 'Non-Campaign Products' END as [isCampaign]
From Production.Products pP INNER JOIN Production.Categories pC ON pP.categoryid=pC.categoryid




