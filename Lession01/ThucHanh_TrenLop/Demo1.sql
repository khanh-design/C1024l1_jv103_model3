create database c1024l1;
use c1024l1;

create table Student (
	id int primary key, # rang buoc
    name varchar(50),
    age int
    
);

insert into Student(id, name, age) values (1, 'nam', 20);
insert into Student(id, name, age) values (2, 'hoang', 21);

select id, name, age from Student;

alter table Student
add column status int;

alter table Student
modify column status varchar(50);