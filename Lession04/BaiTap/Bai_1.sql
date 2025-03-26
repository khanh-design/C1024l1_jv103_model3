use `quanlysinhvien`;

-- 1. Hiển thị tất cả các thông tin môn học (bảng subjecct) có credit lớn nhất
SELECT SubID, SubName, Credit 
FROM Subject 
WHERE Credit = (SELECT MAX(Credit) FROM Subject);

-- 2. Hiển thị các thông tin môn học có điểm lớn nhất
select s.*
from Subject s
join Mark m on m.SubID = s.SubID
where m.Mark = (select max(Mark) from Mark);

-- 3. Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.StudentID, s.StudentName, avg(m.Mark) as avgMark
from Student s
join mark m on m.StudentID = s.StudentID
group by s.StudentID, s.StudentName
order by avgMark desc;
