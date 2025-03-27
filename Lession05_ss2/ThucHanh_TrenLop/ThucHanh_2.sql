use `demo`;

select * from customers;

insert into customers (id, name, age, address, salary) values
(4, 'Phạm Thị D', 25, 'Hải Phòng', 12000000),
(5, 'Hoàng Văn E', 30, 'Cần Thơ', 16000000),
(6, 'Vũ Thị F', 29, 'Bình Dương', 17000000),
(7, 'Đặng Văn G', 38, 'Nghệ An', 22000000),
(8, 'Bùi Thị H', 27, 'Thanh Hóa', 13000000),
(9, 'Ngô Văn I', 45, 'Quảng Ninh', 25000000),
(10, 'Dương Thị K', 31, 'Đồng Nai', 19000000);

Delimiter //
Create Procedure allrecords()
    BEGIN
    Select * from Student_info;
    END//
DELIMITER ;

create table SumofAll(
	Amount int
);

insert into SumofAll(amount) values
(100),
(335),
(400),
(450);

select * from SumofAll;

DROP PROCEDURE IF EXISTS sp_checkValue;

DELIMITER //
CREATE PROCEDURE sp_checkValue(IN value1 INT, OUT value2 INT)
BEGIN
    SELECT Amount INTO value2 FROM SumofAll WHERE Amount = value1;
END //
DELIMITER ;

call sp_checkValue(335, @isPresent);

select @isPresent;