-- lab 5-1
go
create function fun_total_sale(@year int, @month int)
    returns money
as
begin
    declare @result money;
    declare @count int;

    select @count=count(*) from  AdventureWorks2008R2.Sales.SalesOrderHeader
        where year(OrderDate) = @year and month(OrderDate) = @month;

    if @count =0
        set @result = 0;
    else
        select @result = sum(TotalDue) from AdventureWorks2008R2.Sales.SalesOrderHeader
            where year(OrderDate) = @year and month(OrderDate) = @month;
    return @result;
end;

/*
select lab5gjy.dbo.fun_total_sale(2005,7);

select sum(totaldue) from  AdventureWorks2008R2.Sales.SalesOrderHeader where year(orderdate)=2005 and month(orderdate)=7;
*/



-- lab 5-2

go

CREATE TABLE DateRange
(DateID INT IDENTITY, 
DateValue DATE,
Month INT,
DayOfWeek INT);
go

create procedure sp_lab5_2 @starting date,
                           @number int
as
begin
    declare @offset integer;
    declare @targetDate date;
    declare @dayOfWeek int;
    declare @month int;

    set @offset = 0;


    while @offset < @number
        begin
            set @targetDate = dateadd(day, @offset, @starting);
            set @dayOfWeek = datepart(dw, @targetDate);
            set @month = datepart(m, @targetDate);
            insert into DateRange (DateValue, Month, DayOfWeek)
            values (@targetDate, @month, @dayOfWeek);
            set @offset = @offset + 1;
        end
end;

/*
go

select * from DateRange;
exec sp_lab5_2 '2020-01-01', 10;
select * from DateRange;
*/





-- lab5_3

go
CREATE TABLE Customer
(CustomerID VARCHAR(20) PRIMARY KEY,
 CustomerLName VARCHAR(30),
 CustomerFName VARCHAR(30),
 CustomerStatus VARCHAR(10));
CREATE TABLE SaleOrder
(OrderID INT IDENTITY PRIMARY KEY,
 CustomerID VARCHAR(20) REFERENCES Customer(CustomerID),
 OrderDate DATE,
 OrderAmountBeforeTax INT);
CREATE TABLE SaleOrderDetail
(OrderID INT REFERENCES SaleOrder(OrderID),
 ProductID INT,
 Quantity INT,
 UnitPrice INT,
 PRIMARY KEY (OrderID, ProductID));



go
create trigger trg_lab5_3
    on SaleOrder
    after insert, update
    as
begin
    declare @customerID varchar(20);
    declare @summary int;

    select @customerID = CustomerID from inserted;

    select @summary = sum(OrderAmountBeforeTax)
    from SaleOrder
    where CustomerID = @customerID;

    if @summary > 5000
        update Customer
        set CustomerStatus = 'Preferred'
        where CustomerID = @customerID;
end ;
/*
go

select * from Customer;
insert into Customer values(1,'a','b',null);
select * from Customer;

select * from SaleOrder;
insert into saleorder(CustomerID, OrderDate, OrderAmountBeforeTax) values(1,'20220406',2000);
select * from SaleOrder;
select * from Customer;
insert into saleorder(CustomerID, OrderDate, OrderAmountBeforeTax) values(1,'20220402',4000);
select * from SaleOrder;
select * from Customer;
*/