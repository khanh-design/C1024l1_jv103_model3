use `classicmodels`;

-- Tao procedure
DELIMITER //
create procedure sp_find_all_customer()
begin
	select * from customers;
end //
DELIMITER ;

call sp_find_all_customer();

-- Sửa procedure
DELIMITER //
-- drop procedure if exists `sp_find_all_customer` //
create procedure sp_find_all_customer()
begin 
	select * from customers where customerName = 175;
end //
DELIMITER ;

call sp_find_all_customer();