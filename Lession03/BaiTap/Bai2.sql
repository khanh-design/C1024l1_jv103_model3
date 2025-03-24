create database QuanLyBanHang;

use QuanLyBanHang;

drop database quanlybanhang;
create table Customer(
	cID int auto_increment primary key,
    cName varchar(20) not null,
    cAge varchar(20) not null
);

create table Orders(
	oID int not null auto_increment primary key,
    cID int not null,
    oDate datetime not null,
    oTotalPrice decimal(10.2),
    foreign key (cID) references Customer(cID)
);

create table Product(
	pID int not null auto_increment primary key,
    pName varchar(50),
    pPrice decimal(10,2)
);

create table OrderDetail(
	oID int not null,
    pID int not null,
	primary key(oID, pID),
    odQTY int not null,
    foreign key (oID) references Orders(oID),
    foreign key (pID) references Product(pID)
);

-- Thêm dữ liệu vào bảng Customer
insert into Customer(cID, cName, cAge) values (1, 'Minh Quan', 10);
insert into Customer(cID, cName, cAge) values (2, 'Ngoc Oanh', 20);
insert into Customer(cID, cName, cAge) values (3, 'Hong Ha', 50);

select * from Customer;

-- Thêm dữ liệu vào bảng Order
insert into Orders(oID, cID, oDate, oTotalPrice) values (1, 1, '2006-3-21', null);
insert into Orders(oID, cID, oDate, oTotalPrice) values (2, 2, '2006-3-23', null);
insert into Orders(oID, cID, oDate, oTotalPrice) values (3, 1, '2006-3-16', null);

select * from Orders; 

-- Thêm dữ liệu vào bảng Product
insert into Product(pID, pName, pPrice) values (1, 'May Giat', 3);
insert into Product(pID, pName, pPrice) values (2, 'Tu Lanh', 5);
insert into Product(pID, pName, pPrice) values (3, 'Dieu Hoa', 7);
insert into Product(pID, pName, pPrice) values (4, 'Quat', 1);
insert into Product(pID, pName, pPrice) values (5, 'Dep Dien', 2);

select * from Product;

-- Thêm dữ liệu vào bảng OrderDetail
insert into OrderDetail(oID, pID, odQTY) values (1, 1, 3);
insert into OrderDetail(oID, pID, odQTY) values (1, 3, 7);
insert into OrderDetail(oID, pID, odQTY) values (1, 4, 2);
insert into OrderDetail(oID, pID, odQTY) values (2, 1, 1);
insert into OrderDetail(oID, pID, odQTY) values (3, 1, 8);
insert into OrderDetail(oID, pID, odQTY) values (2, 5, 4);
insert into OrderDetail(oID, pID, odQTY) values (2, 3, 3);

select * from OrderDetail;

-- 1. Hiển thị các thông tin oID, cID, oDate, pPrice của tất cả các hóa đơn trong bảng Orders.
SELECT O.oID, O.oDate, P.pPrice
FROM Orders O
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON P.pID = OD.pID;

-- 2. Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách hàng 
SELECT C.cID, C.cName, P.pID, P.pName
FROM Customer C
JOIN Orders O ON C.cID = O.cID
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON OD.pID = P.pID;

-- 3. Hiển thị tên những khách hàng không mua bất kỳ 1 sản phẩm nào
select C.cName
from Customer C
left join Orders O on C.cID = O.cID
where O.cID is null;

-- 4. 
select O.oID, O.oDate, sum(OD.odQTY * P.pPrice) as oPrice
from Orders O
join OrderDetail OD on OD.oID = O.oID
join Product P on P.pID = OD.oID
group by O.oID, O.oDate
order by O.oID, O.oDate, oPrice;