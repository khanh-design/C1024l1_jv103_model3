create database c1024l1;
use c1024l1;

# tao bang tiep
create table Class (
    id int primary key,
    name varchar(50)
);

insert into Class(id, name) values(1, 'C1024L1');
insert into Class(id, name) values(2, 'C1024G1');

select id, name from Class where id betteen(1, 3); --lấy cả từ 1->3
select id, name from Class where id like 'C%'; -- so sánh tương đối 

update Class
set name = 'C1024MM1'
where id = 2;


delete from Class
where id = 2;

-- lấy dữ liệu từ bảng Class
select id, name from Class;

drop table Student;
create table Student (
	id int primary key auto_increment, # rang buoc voi gia tri tu tang
    name varchar(50) default 'Name',
    age int,
    class_id int, 
    create_date datatime,
    foreign key (class_id) references Class(id),
    check (age >= 18)
);

insert into Student(name, age, class_id, create_date) values (1, 'Binh', 20, 1, '2024-12-29');
insert into Student(name, age) values (2, 'An', 21, 2);
insert into Student(id, age) values (4, 30);

select id, name, age, class_id from Student;

select s.id, s.name, s.age, c.Name
from Student s join Class c
on s.class_id = c.id;

alter table Student
add column status int;

alter table Student
modify column status varchar(50);