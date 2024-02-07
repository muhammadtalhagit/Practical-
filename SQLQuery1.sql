-- create database practical
create database practical

-- Create a table named Customers with columns: CustomerID, FirstName, LastName, Email, and PhoneNumber.

create table customers (
CustomerId int primary key,
Firstname varchar(255),
Lastname varchar (255),
Email varchar (255),
Phonenumber bigint
);

 
INSERT INTO customers (CustomerId, Firstname, Lastname, Email, Phonenumber) VALUES
(1, 'Ali', 'Khan', 'alikhan@example.com', 923001234567),
(2, 'Fatima', 'Ahmed', 'fatima.ahmed@example.com', 923451234567),
(3, 'Hassan', 'Raza', 'hassan.raza@example.com', 923801234567),
(4, 'Ayesha', 'Malik', 'ayesha.malik@example.com', 923201234567),
(5, 'Usman', 'Ali', 'usman.ali@example.com', 923701234567),
(6, 'Sana', 'Khan', 'sana.khan@example.com', 923501234567),
(7, 'Bilal', 'Khan', 'bilal.khan@example.com', 923601234567),
(8, 'Nida', 'Shah', 'nida.shah@example.com', 923101234567),
(9, 'Fahad', 'Hassan', 'fahad.hassan@example.com', 923901234567),
(10, 'Sadia', 'Akhtar', 'sadia.akhtar@example.com', 923701234567);

select * from customers

-- Create a table named Orders with columns: OrderID, CustomerID, OrderDate, and TotalAmount.
create table Orders (
OrderId int primary key,
CustomerId int,
Orderdate date,
Totalamount varchar (212),
FOREIGN KEY (CustomerId) REFERENCES customers(CustomerId)
);

INSERT INTO Orders (OrderId, CustomerId, Orderdate, Totalamount) VALUES
(1, 1, '2024-02-07', '100.00'),
(2, 2, '2024-02-06', '75.50'),
(3, 3, '2024-02-05', '200.25'),
(4, 4, '2024-02-04', '150.75'),
(5, 5, '2024-02-03', '180.20'),
(6, 6, '2024-02-02', '90.30'),
(7, 7, '2024-02-01', '110.50'),
(8, 8, '2024-01-31', '300.00'),
(9, 9, '2024-01-30', '50.75'),
(10, 10, '2024-01-29', '95.25');

select * from Orders

 -- Create a table named Products with columns: ProductID, ProductName, UnitPrice, and InStockQuantity.
 create table products (
ProductId int primary key,
Productname varchar(255),
Unitprice int,
Instockquantity int
);

INSERT INTO products (ProductId, Productname, Unitprice, Instockquantity) VALUES
(1, 'Rice', '100', '50'),
(2, 'Bread', '20', '100'),
(3, 'Milk', '50', '75'),
(4, 'Eggs', '10', '200'),
(5, 'Chicken', '200', '30'),
(6, 'Potatoes', '30', '80'),
(7, 'Tomatoes', '25', '100'),
(8, 'Apples', '40', '120'),
(9, 'Bananas', '35', '150'),
(10, 'Oranges', '30', '100');

select * from products

-- Create a table named OrderDetails with columns: OrderDetailID, OrderID, ProductID, Quantity, and UnitPrice.
create table Ordersdetail (
OrdersdetailId int primary key,
OrderId int,
ProductId int,
Quntity int,
Unitprice varchar (255),
FOREIGN KEY (OrderId) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductId) REFERENCES products(ProductId)
);

 INSERT INTO Ordersdetail (OrdersdetailId, OrderId, ProductId, Quntity, Unitprice)
VALUES 
(1, 1, 1, 5, '10'),
(2, 2, 2, 3, '15'),
(3, 3, 3, 2, '20'),
(4, 4, 4, 4, '8'),
(5, 5, 5, 6, '12'),
(6, 6, 6, 1, '25'),
(7, 7, 7, 7, '9'),
(8, 8, 8, 3, '18'),
(9, 9, 9, 2, '22'),
(10, 10, 10, 5, '11');

select * from Ordersdetail

-- 1) Create a new user named Order_Clerk with permission to insert new orders and update order details in the Orders and OrderDetails tables.
create login Order_Clerk with password = 'order'
create user Order_Clerk for login Order_Clerk
grant update,insert on dbo.Orders to Order_Clerk

-- 2) Create a trigger named Update_Stock_Audit that logs any updates made to the InStockQuantity column of the Products table into a Stock_Update_Audit table.
create trigger Update_Stock_Audit ON products
For update
as
begin
 print 'Data update'
end

update products set Productname = 'Basmati' where ProductId = 1


 -- 3) Write a SQL query that retrieves the FirstName, LastName, OrderDate, and TotalAmount of orders along with the customer details by joining the Customers and Orders tables

select Firstname,Lastname,Orderdate,Totalamount from customers as c join Orders as o on c.CustomerId = o.CustomerId;

--4) Write a SQL query that retrieves the ProductName, Quantity, and TotalPrice of products ordered in orders with a total amount greater than the average total amount of all orders.
 
 select * from products as p join Ordersdetail as oo on p.ProductId = oo.ProductId join Orders as o on o.OrderId = oo.OrderId;

 select count(Totalamount), Productname, Quntity, Totalamount from products as p join Ordersdetail as oo on p.ProductId = oo.ProductId join Orders as o on o.OrderId = oo.OrderId;

 -- 5) Create a stored procedure named GetOrdersByCustomer that takes a CustomerID as input and returns all orders placed by that customer along with their details

 create procedure GetOrdersByCustomer 
 @id varchar(255)
 as 
 begin
 select * from customers where CustomerId = @id;

 end

 exec GetOrdersByCustomer @id = '2'

 -- 6) Write a SQL query to create a view named OrderSummary that displays the OrderID, OrderDate, CustomerID, and TotalAmount from the Orders table.

 create view STD_OrderSummary as 
 select OrderID, OrderDate, CustomerID,TotalAmount from Orders 

 -- 7) Create a view named ProductInventory that shows the ProductName and InStockQuantity from the Products table.
 
 create view STD_ProductInvetory as 
 select Productname, InStockQuantity from products 


 -- 8) Write a SQL query that joins the OrderSummary view with the Customers table to retrieve the customer's first name and last name along with their order details.
 
 create view Summary as 
 select Firstname , Lastname from customers as c join Orders as O on c.CustomerId = O.CustomerId 