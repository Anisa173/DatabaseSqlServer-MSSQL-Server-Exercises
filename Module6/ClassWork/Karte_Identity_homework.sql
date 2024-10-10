use AdventureWorks
go
--I40224009J
-- Do të ndërtoni ID e kartave të identitetit të punonjësve tanë sipas akteve nënligjore në fuqi
--1- DatëLindje H->1970 - 1979 , I -> 1980-1989,J->1990-1999..
--2- Viti_lindjes ,1986 -> 6(1 karakter)
--3- Muaji i Lindjes jane dy gërmat e tjera. Kujdes duhet te mbani dy germa 02 per Shkurti, 12 dhjetorin
-- Supozojmë datëlindja është 1992-03-17 -> 03 dhe nëse është femër le ta mbledhim me 50 pra 50 + 3
--4- Dy germat e tjera jane dita e lindjes.Le të supozojme se datëlindja është 1992-03-16 -> 16
--5- Tre germat e tjera jane nr rendor, kujdes: gjithmone tre shifra. 001,002,003,004... sipas ID që kanë punonjësit e kompanise


Select * From HumanResources.Employee
Select e.BirthDate,e.Gender,CONCAT(case when year(e.BirthDate) between 1990 and 1999 then 'M' 
when year(e.BirthDate) between 1980 and 1989 then 'L'                                    
when year(e.BirthDate) between 1970 and 1979 then 'K'
when year(e.BirthDate) between 1960 and 1969 then 'J'
when year(e.BirthDate) between 1950 and 1959 then 'I'
when year(e.BirthDate) between 1940 and 1949 then 'H'
else '' END,RIGHT(year(e.BirthDate),1),RIGHT(concat('0',IIF((e.Gender='F'),month(e.BirthDate)+50,month(e.BirthDate))),2),
RIGHT(concat('0',day(e.BirthDate)),2),
RIGHT(CONCAT('00',e.BusinessEntityID),3),case when year(e.BirthDate) between 1995 and 1999 then 'J' 
when year(e.BirthDate) between 1987 and 1994 then 'I'
when year(e.BirthDate) between 1981 and 1986 then 'H'                                    
when year(e.BirthDate) between 1975 and 1980 then 'G'
when year(e.BirthDate) between 1969 and 1974 then 'F'
when year(e.BirthDate) between 1962 and 1968 then 'E'
when year(e.BirthDate) between 1956 and 1961 then 'D'
when year(e.BirthDate) between 1950 and 1955 then 'C'
when year(e.BirthDate) between 1945 and 1949 then 'B'
when year(e.BirthDate) between 1939 and 1944 then 'A'
else '' END ) as personal_ID_No
From HumanResources.Employee as e
--Order by e.BirthDate 

