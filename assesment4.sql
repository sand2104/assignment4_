--create database
CREATE DATABASE Assessment04Db;
USE Assessment04Db;

-- Create the Products table
CREATE TABLE Products (
    pId INT PRIMARY KEY IDENTITY(500, 1),
    PName NVARCHAR(255) NOT NULL,
    PPrice DECIMAL(10, 2),
    PTax AS PPrice * 0.10 PERSISTED,
    PCompany NVARCHAR(50) CHECK (PCompany IN ('SamSung', 'Apple', 'Redmi', 'HTC', 'RealMe', 'Xiaomi')),
    PQty INT DEFAULT 10 CHECK (PQty >= 1)
);
Insert into Products (PName, PPrice, PCompany, PQty)
values
    ('Iphone14', 10000, 'Apple', 26),
    ('Iphone 13', 80000, 'Apple', 11),
    ('S22 ultra', 75000, 'Samsung', 16),
    ('nazro', 12000, 'RealMe', 9),
    ('Utc22', 9000, 'HTC', 20),
    ('Xiomi X1', 16500, 'Xiaomi', 4),
    ('Galaxy Z fold', 78000, 'Samsung', 21),
    ('Roxy',8500, 'HTC', 8),
    ('Poco4', 14600, 'Redmi', 12),
    ('Iphone 14Plus', 88000, 'Apple', 7);

	select * from Products

-- Create the procedure to display product details

create proc GetTotalPrice
with encryption
as 
begin
select PId,PName,PPrice+PTax as PriceWithTax,PCompany,(PQty*(PPrice+PTax)) as TotalPrice from Products
end

exec GetTotalPrice

create proc GetTotalTax
@company varchar(50),
@TotalTax float output
with encryption
as 
select @TotalTax=sum(PTax) from Products where PCompany=@company


declare @TaxCount float
exec GetTotalTax 'Apple',@TaxCount output
print @TaxCount

