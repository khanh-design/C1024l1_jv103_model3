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