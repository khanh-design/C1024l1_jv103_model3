create database `QuanLySinhVien`;

use `QuanLySinhVien`;

create table Class(
	ClassID int Not null primary key auto_increment,
    ClassName varchar(60) not null,
    StartDate datetime not null,
    Status bit
);

create table Student(
	StudentID int not null primary key auto_increment,
    StudentName varchar(30) not null,
    Address varchar(50),
    Phone varchar(20),
    Status bit,
    ClassID int not null,
    foreign key (ClassID) references Class(ClassID)
);

create table Subject(
	SubID int not null primary key auto_increment,
    SubName varchar(30) not null,
    Credit tinyint not null default 1 Check (Credit >= 1),
    Status bit default 1
);


create table Mark (
	MarkID int not null auto_increment primary key,
    SubID int not null,
    StudentID int not null,
    Mark float default 0 check (Mark between 0 and 100),
    ExamTimes tinyint default 1,
    unique (SubID, StudentID),
    foreign key (SubID) references Subject(SubID),
    foreign key (StudentID) references Student(StudentID)
);

insert into Class  values (1, 'A1', '2008-12-20', 1);
insert into Class  values (2, 'A2', '2008-12-22', 1);
insert into Class  values (3, 'B3', current_date(), 0);

-- add data form record Syudent
insert into Student values (1, 'Hung', 'Ha noi', '0912113113', 1, 1);
insert into Student values (2, 'Hoa', 'Hai phong', '', 1, 1);
insert into Student values (3, 'Manh', 'HCM', '0123123123', 0, 2);

-- add data from record Subject
insert into Subject values (1, 'CF', 5, 1);
insert into Subject values (2, 'C', 6, 1);
insert into Subject values (3, 'HDJ', 5, 1);
insert into Subject values (4, 'RDBMS', 10, 1);

-- add data from record Marrk
insert into Mark values (1, 1, 1, 8, 1);
insert into Mark values (2, 1, 2, 10, 2);
insert into Mark values (3, 2, 1, 12, 1);


-- show list Student
select * from Student;

-- show list Students follow learn
select * from Student where Status = 1;

-- show list Subject time < 10
select * from Subject where Credit < 10;

-- show list Student learn class A1
select s.StudentID, s.StudentName, c.ClassID
from Student s join Class c on s.ClassID = c.ClassID
where c.ClassName = 'A1';

-- show Mark CF Students
select s.StudentID, s.StudentName, sub.SubName, m.Mark
from Student s join Mark m on s.StudentID = m.StudentID join Subject sub on M.SubID = sub.SubID
where Sub.SubName = 'CF';


-- Bai Tap 1--
-- 1. Hien thi ten co chu 'h'
select * from Student where StudentName like 'h%';

-- 2. Hien thi cac thong tin co thoi gian bat dau vao thang 12
select s.ClassID, s.ClassName, s.StartDate 
from Class s
where month(s.StartDate) = 12;

-- 3. Hiển thị các thông tin môn học có credit trong khoảng từ 3-5
select sub.SubID, sub.SubName, sub.Credit
from Subject sub
where sub.Credit >= 3 and sub.Credit <= 5;

-- 4. Thay đổi mã lớp (ClassID) của sinh viên có tên 'Hung' là 2
update Student
set ClassID = 2
where StudentID = 1; 

-- 5. Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select s.StudentName, sub.subName, m.Mark
from Student s 
join Mark m on s.StudentID = m.StudentID
join Subject sub on m.SubID = sub.SubID
order by m.Mark desc, s.StudentName asc;
