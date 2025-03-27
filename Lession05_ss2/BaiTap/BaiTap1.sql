create database demo2;

use `demo2`;

drop table Products;
create table Products (
	id int auto_increment primary key,
    productCode varchar(30) not null,
    productName varchar(200) not null,
    productPrice decimal(10, 2) not null,
    productAmount int not null,
    productDescription varchar(200),
    productStatus varchar(200)
);

INSERT INTO Products (productName, productCode, productPrice, productAmount, productDescription, productStatus) VALUES
('Laptop Pro 15', 'LAP-001', 1200.00, 15, 'Laptop cao cấp 15 inch, 16GB RAM, 512GB SSD', 'Còn hàng'),
('SmartPhone X', 'PHN-002', 899.99, 30, 'Điện thoại thông minh màn hình 6.5 inch, 128GB', 'Còn hàng'),
('TV Ultra 4K', 'TV-003', 650.50, 8, 'TV 4K 55 inch, Smart TV với HDR', 'Sắp về hàng'),
('Ổ cứng di động 1TB', 'HD-004', 99.99, 45, 'Ổ cứng di động 1TB, USB 3.0', 'Còn hàng'),
('Bàn phím cơ RGB', 'KB-005', 45.75, 22, 'Bàn phím cơ không dây, đèn LED RGB', 'Còn hàng'),
('Chuột Gaming Pro', 'MS-006', 25.00, 0, 'Chuột gaming 8000DPI, 6 nút', 'Hết hàng'),
('Màn hình Gaming 24"', 'MON-007', 320.00, 12, 'Màn hình 24 inch Full HD, 144Hz', 'Còn hàng'),
('Loa Bluetooth X', 'SPK-008', 150.00, 5, 'Loa Bluetooth công suất 20W, chống nước', 'Sắp về hàng'),
('Máy in đa năng MX', 'PRT-009', 230.00, 3, 'Máy in đa năng in/scan/copy', 'Còn ít'),
('Webcam Full HD', 'CAM-010', 89.95, 18, 'Webcam 1080p, micro tích hợp', 'Còn hàng');

create unique index idx_productCode
on Products(productCode);

create index idx_get_name_price
on Products(ProductName, ProductPrice);

-- Truoức khi cải tiến thì type:All (quét toàn bộ bảng), rows: Tổng số hàng trong bảng, Extra: sd where.
explain select * from Products where ProductCode = 'PHN-002';
-- Sau khi cải tiến thì type: const, rows: 1, Extra: null.

-- Trước khi quét toàn bộ bảng
EXPLAIN SELECT * FROM Products WHERE productName LIKE 'Laptop%' AND productPrice > 1000;
-- Sau khi quét toàn bộ bảng
EXPLAIN SELECT * FROM Products WHERE productName = 'Laptop Pro 15' AND productPrice = 1200.00;


-- 2. Tạo view
create view v_Products as
select p.productCode, p.productName, p.productPrice, p.productStatus
from Products p;


-- update view
alter view v_Products as
select p.productCode, p.productName, p.productPrice, p.productStatus
from Products p
where p.productPrice > 50.00;

-- xóa view 
drop view if exists v_Products;

select * from v_Products;


-- 3. Store procedure 
DELIMITER //
-- DROP PROCEDURE IF EXISTS sp_product_status//
CREATE PROCEDURE sp_product_status()
BEGIN
    SELECT p.productCode, p.productName, p.productPrice, p.productAmount, p.productStatus
    FROM products p;
END //
DELIMITER ;

-- add product
DELIMITER //
-- DROP PROCEDURE IF EXISTS sp_add_product//
CREATE PROCEDURE sp_add_product(
    IN p_name VARCHAR(200),
    IN p_code VARCHAR(30),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_desc VARCHAR(200),
    IN p_status VARCHAR(200)
)
BEGIN 
    INSERT INTO Products 
    SET productName = p_name,
        productCode = p_code,
        productPrice = p_price,
        productAmount = p_amount,
        productDescription = p_desc,
        productStatus = p_status;
END //
DELIMITER ;
CALL sp_add_product('Huawei', 'HR01', 34.00, 10, 'may tinh cao cap', 'con hang');


-- update product id
DELIMITER //
CREATE PROCEDURE sp_update_product_by_id(
    IN p_id INT,
    IN p_productName VARCHAR(200),
    IN p_productCode VARCHAR(30),
    IN p_productPrice DECIMAL(10,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(200),
    IN p_productStatus VARCHAR(200)
)
BEGIN
    UPDATE Products
    SET 
        productName = p_productName,
        productCode = p_productCode,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE id = p_id;
    
    -- Trả về số dòng bị ảnh hưởng
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

CALL sp_update_product_by_id( 1, 'Laptop Pro 16', 'LAP-001', 1300.00, 20, 'Laptop cao cấp 16 inch', 'Còn hàng');


-- delete products 
-- Tạo bảng lưu trữ lịch sử xóa sản phẩm
CREATE TABLE Products_Archive (
    id int,
    productCode varchar(30) not null,
    productName varchar(200) not null,
    productPrice decimal(10, 2) not null,
    productAmount int not null,
    productDescription varchar(200),
    productStatus varchar(200),
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_by VARCHAR(100) DEFAULT 'system'
);

-- Tạo procedure để xóa sản phẩm theo ID
DELIMITER //
CREATE PROCEDURE sp_delete_product_by_id(IN p_id INT)
BEGIN
    -- Xóa sản phẩm (trigger sẽ tự động lưu vào bảng archive)
    DELETE FROM Products WHERE id = p_id;
    
    -- Trả về số dòng bị ảnh hưởng
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

-- Tạo BEFORE DELETE trigger để lưu vào bảng archive
DELIMITER //
CREATE TRIGGER trg_before_product_delete
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    -- Lưu bản ghi sắp bị xóa vào bảng archive
    INSERT INTO Products_Archive (
        id, productCode, productName, productPrice, 
        productAmount, productDescription, productStatus
    ) VALUES (
        OLD.id, OLD.productCode, OLD.productName, OLD.productPrice,
        OLD.productAmount, OLD.productDescription, OLD.productStatus
    );
END //
DELIMITER ;

-- Kiểm tra trigger bằng cách gọi procedure xóa
CALL sp_delete_product_by_id(1);

-- Kiểm tra bảng archive
SELECT * FROM Products_Archive;

-- Kiểm tra bảng Products (sản phẩm ID 1 đã bị xóa)
SELECT * FROM Products;
