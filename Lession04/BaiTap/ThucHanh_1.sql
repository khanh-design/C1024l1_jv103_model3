use `quanlysinhvien`;

-- 1. Hiển thị số lượng sinh viên ở từng nơi
select * from Student;
select Address, count(studentID) as 'Số lượng sinh viên'
from  Student
group by Address;

-- 2. Tính điểm trung bình các môn học của mỗi học viên
select s.StudentID, s.StudentName, avg(mark) as 'Điểm trung bình'
from Student s
join Mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName;

-- 3. Hiển thị những học sinh có điểm trung bình lớn hơn 15
select s.StudentID, s.StudentName, avg(mark) as 'Điểm trung bình'
from Student s
join Mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName
having avg(mark) > 15;

-- 4. Hiển thị các học viên có điểm trung bình lơn nhất
select s.StudentID, s.StudentName, avg(mark)
from Student s
join Mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName
having avg(mark) >= all (select avg(mark) from mark group by mark.StudentID);