create database demo;

use demo;

create table Student(
	id int,
    name varchar(200),
    age int,
    country varchar(50)
);

# tiep bai tap tiep theo
create table Class (
	id int primary key,
    name varchar(20)
);

create table Teacher(
	id int primary key,
    name varchar(200),
    age int,
    country varchar(50)
);