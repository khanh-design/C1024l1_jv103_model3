use `classicmodels`;

-- parameter in
DELIMITER //
create procedure sp_get_cusby_Id
(in cusNum int(11))
begin
	select * from customers where customerNumber = cusNum;
end //
DELIMITER ;

call sp_get_cusby_Id(175);

-- parameter out 
DELIMITER //
create procedure sp_get_count_by_city(
	in in_city varchar(50),
    out total int 
)
begin
	select count(customerNumber)
    into total
    from customers
    where city = in_city;
end //
DELIMITER ; 

call sp_get_count_by_city('Lyon', @total);

select @total;

-- parameter inout 
DELIMITER //
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END//
DELIMITER ;

set @counter = 1;
call SetCounter(@counter, 2);
call SetCounter(@counter, 5);
select @counter;
