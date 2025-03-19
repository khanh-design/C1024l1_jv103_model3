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


