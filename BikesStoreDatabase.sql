use SendOrders
Go
create schema BikesStore
go
create table [BikesStore].[Customers]
(customer_id int not null identity(1,1),
first_name [nvarchar](15) not null,
last_name [nvarchar](10) not null,
phone int not null,
email nvarchar(15) not null,
street nvarchar(40) not null,
city nvarchar(10) not null,
state nvarchar(15) not null,
zip_code nvarchar(5) not null,
Primary Key (customer_id) 
)

create table [BikesStore].[Orders]
( order_id int not null IDENTITY(1,1),
order_status nvarchar(12) not null,
order_date datetime2 not null,
required_date datetime2 not null,
shipped_date datetime2 not null,
PRIMARY KEY(order_id),
customerId int ,
--Foreign key (customerId) References [BikesStore].[Customers] (customer_id)
--on DELETE SET NULL ON UPDATE CASCADE
)
ALTER Table  [BikesStore].[Orders]
ADD  customerId int not null

ALTER Table  [BikesStore].[Orders]
ADD  CONSTRAINT FK_Customer_Orders FOREIGN KEY (customerId) REFERENCES [BikesStore].[Customers](customer_id)

Alter table [BikesStore].[Orders]
Add staffID int not null

Alter table [BikesStore].[Orders]
ADD CONSTRAINT FK_Staffs_Orders FOREIGN KEY (staffID) REFERENCES [BikesStore].[Staffs](staff_id)

Alter table [BikesStore].[Orders]
Add storeID INT NOT NULL

Alter table [BikesStore].[Orders]
Add CONSTRAINT FK_Stores_Orders FOREIGN KEY(storeID) REFERENCES [BikesStore].[Stores](store_id)

create table [BikesStore].[Staffs]
( staff_id int not null identity(1,1),
first_name nvarchar(14) not null,
last_name nvarchar(15) not null,
email nvarchar(11) not null,
phone int not null,
active bit not null,
PRIMARY KEY(staff_id)
)
Alter table [BikesStore].[Staffs]
Add store_id int not null

Alter table [BikesStore].[Staffs]
ADD CONSTRAINT FK_Stores_Staffs FOREIGN KEY (store_id) REFERENCES [BikesStore].[Stores](store_id)

Alter table [BikesStore].[Staffs]
Add managerId int not null

Alter table [BikesStore].[Staffs]
Add constraint FK_Manager_Staffs FOREIGN KEY(managerId) REFERENCES [BikesStore].[Staffs](staff_id)

create table [BikesStore].[Stores]
(
store_id int not null identity(1,1),
store_name nvarchar(20) not null ,
phone int not null,
email nvarchar(12) not null,
street nvarchar(8) not null,
city nvarchar(10) not null,
state nvarchar(10) not null,
zip_code nvarchar(4) not null,
PRIMARY KEY(store_id)
)
create table [BikesStore].[OrderItems]
(order_id int not null,
item_id int not null identity(1,1),
productID int not null,
quantity int not null,
list_price int not null,
discount decimal not null,
PRIMARY KEY(item_id,order_id),
FOREIGN KEY(order_id)  REFERENCES [BikesStore].[Orders](order_id)
ON DELETE CASCADE ON UPDATE CASCADE
)
Alter table [BikesStore].[OrderItems]
Add constraint FK_Products_OrderItems Foreign Key(productID) references [BikesStore].[Products](product_id)


create table [BikesStore].[Categories]
(category_id int not null identity(1,1),
category_name nvarchar(15) not null,
PRIMARY KEY(category_id)
)
create table [BikesStore].[Products]
(product_id int not null identity(1,1),
product_name nvarchar(25) not null,
brand_id int not null,
categoryId int not null,
model_year nvarchar(25) not null,
list_price decimal not null,
Primary key (product_id),
Foreign key(categoryId) REFERENCES [BikesStore].[Categories](category_id)
)
Alter table [BikesStore].[Products]
Add constraint FK_Brands_Products Foreign key(brand_id) references [BikesStore].[Brands](brand_id)


create table [BikesStore].[Stocks]
(	
store_id int not null,
product_id int not null,
quantity int not null,
PRIMARY KEY(store_id,product_id),
foreign key (store_id) references [BikesStore].[Stores](store_id)
on delete no action on update cascade,
foreign key (product_id) references [BikesStore].[Products](product_id)
on delete no action on update cascade
)
create table [BikesStore].[Brands]
(
brand_id int not null identity(1,1),
brand_name nvarchar(20) not null,
PRIMARY KEY(brand_id)

)
















