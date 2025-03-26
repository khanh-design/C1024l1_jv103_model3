use `quanlysinhvien`;

select * from Subject;

-- Tinh tong sum()
select sum(credit) from subject;

-- Tinh trung binh
select avg(credit) from subject;

-- ham lay do dai 
select length(subname) from subject;

-- now() tra ve thoi gio hien tai
select now();