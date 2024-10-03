# 1
select * from offices
where officeCode = (
	select officeCode
    from employees
    group by officeCode
    order by count(*) desc
    limit 1
);

# 2 (oficina con más ventas)
select offices.officeCode, count(*) as productsSold
from offices join employees on employees.officeCode = offices.officeCode
			 join customers on customers.salesRepEmployeeNumber = employees.employeeNumber
             join orders on orders.customerNumber = customers.customerNumber
group by offices.officeCode
order by count(*) desc limit 1;

# 2 (promedio de órdenes por oficina)
select avg(count) as averageSalesPerOffice
from (select count(*) as count
	 from offices join employees on employees.officeCode = offices.officeCode
	 join customers on customers.salesRepEmployeeNumber = employees.employeeNumber
	 join orders on orders.customerNumber = customers.customerNumber
     group by offices.officeCode
) as salesPerOffice;

# 3
select year(paymentDate), month(paymentDate),
		avg(amount) as avgMonthlyPayments,
		max(amount) as maxMonthlyPayments,
        min(amount) as minMonthlyPayments
from payments
group by year(paymentDate), month(paymentDate)
order by year(paymentDate), month(paymentDate);

# 4
delimiter //
create procedure update_credit(
	in customerNum int,
	in newCreditLimit decimal(10,2)
) begin
	update customers
    set customers.creditLimit = newCreditLimit
    where customers.customerNumber = customerNum;
end //
delimiter ;

# 5
create view PremiumCustomers as (
	select customers.customerName, 
		   customers.city,
           sum(payments.amount) as totalSpent
	from customers left join payments
    on payments.customerNumber = customers.customerNumber
    group by (payments.customerNumber)
    order by totalSpent desc limit 10
);

# 6
drop function employee_of_the_month;
delimiter //
create function employee_of_the_month(
	yr year, mnth int
) returns varchar(100)
READS SQL DATA
begin
	set @res := (
		select concat_ws(" ", employees.firstName, employees.lastName) as full_name
		from employees join customers on customers.salesRepEmployeeNumber = employees.employeeNumber
					    join orders on orders.customerNumber = customers.customerNumber
		where year(orders.orderDate) = yr and month(orders.orderDate) = mnth
		group by employees.employeeNumber
		order by count(*) desc limit 1
    );
    return @res;
end //

delimiter ;

set @test = employee_of_the_month(2003, 3);

select @test;

# 7
create table productrefillment (
	refillmentID int not null AUTO_INCREMENT,
    productCode varchar(15),
    FOREIGN KEY (productCode) REFERENCES products(productCode),
    PRIMARY KEY (refillmentID, productCode),
    orderDate date,
    quantity int
);

# 8
drop trigger restock_product;
delimiter //
create trigger restock_product
after insert on orders
for each row
BEGIN
	insert into productrefillment (productCode, orderDate, quantity)
    select orderdetails.productCode, new.orderDate, 10 as quantity
    from orderdetails join products on products.productCode = orderdetails.productCode
    where new.orderNumber = orderdetails.orderNumber
    and products.quantityInStock - orderdetails.quantityOrdered < 10;
END //

delimiter ;

# 9
create role employee;
grant select, create view on classicmodels.* to employee;
show grants for employee;

# 10
SELECT customers.customerName, 
	customers.contactFirstName,
	datediff(
		payments.paymentDate,
		lag(payments.paymentDate) over (order by payments.paymentDate)
	) as time_diff
FROM customers inner join payments 
on customers.customerNumber = payments.customerNumber
where customers.city regexp 'N[.]*'
order by time_diff limit 5;




