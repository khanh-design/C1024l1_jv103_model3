use classicmodels;

select * from customers;

EXPLAIN SELECT * FROM employees WHERE lastname LIKE 'T%';
create index idx_last_name on employees(lastname);

EXPLAIN SELECT * FROM employees WHERE lastname LIKE 'T%' or firstname LIKE 'A%';

-- Đối với or t 
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' and contactLastName = 'King';
create index idx_full_name on customers(contactFirstName, contactLastName);
create index idx_first_name on customers(contactFirstName);
create index idx_last_name on customers(contactLastName);

ALTER TABLE customers DROP INDEX idx_full_name;


create table Animal(
	id int primary key,
    name varchar(50)
);

insert into Animal(id, name) values(1,'Cat');
insert into Animal(id, name) values(3,'Dog');
insert into Animal(id, name) values(2,'Tiger');
insert into Animal(id, name) values(4,'Bird');

Explain select * from Animal where id > 0;

create table Geomatric2(
	color varchar(50),
    name varchar(50) unique not null
);

alter table Geomatric2
modify column name varchar(50);

insert into Geomatric2(color, name) values('red', 'Square');
insert into Geomatric2(color, name) values('yellow', 'Rectangle');
insert into Geomatric2(color, name) values('blue', 'Triange');
insert into Geomatric2(color, name) values('green', 'Circle');
insert into Geomatric2(name) values('Cylinder');

select * from Geomatric2;


create view v_Geomatric3 as
select color, name from Geomatric2
WHERE color IS NOT NULL
WITH CHECK OPTION;

update v_Geomatric3
set color = 'white'
where name = 'Circle';

insert into v_Geomatric3(color, name) values ('aa', 'bbb');

delete from v_Geomatric3
where name = 'bbb';

drop view v_Geomatric3;

select * from v_Geomatric3;

delete from Geomatric1
where name != 'kkk';


select * from Geomatric2;

show index from geomatric;

create view v_geomatric
as
select color, name from geomatric2
where color is not null
with check option;

select * from v_geomatric;
drop view v_geomatric;

update v_geomatric
set color = 'aaa'
where name = 'Circle';

insert into v_geomatric(color, name) values('nn', 'mmm');

