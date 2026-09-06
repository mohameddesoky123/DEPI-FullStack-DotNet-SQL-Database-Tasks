
USE MyCompany

-- 11. Display each department id, name which managed by a manager with id equals 968574.
SELECT Dnum, Dname 
FROM Departments 
WHERE MGRSSN = 968574;

-- 12. Display the ids, names and locations of the projects which controlled with department 10.
SELECT Pnumber, Pname, Plocation 
FROM Project 
WHERE Dnum = 10;

---------------------------------------------

USE ITI;


-- 1. Retrieve number of students who have a value in their age.
SELECT COUNT(St_Age) AS [Students With Age]
FROM Student;

-- 2. Get all instructors Names without repetition.
SELECT DISTINCT Ins_Name 
FROM Instructor;

-- 3. Display instructor Name and Department Name (including unassigned instructors).
SELECT I.Ins_Name, D.Dept_Name
FROM Instructor I 
LEFT JOIN Department D
  ON D.Dept_Id = I.Dept_Id;

-- 4. Display student full name and the name of the course he is taking (For only courses which have a grade).
SELECT S.St_Fname + ' ' + S.St_Lname AS [Student Full Name], 
       C.Crs_Name AS [Course Name], 
       SC.Grade
FROM Student S
JOIN Stud_Course SC 
  ON S.St_Id = SC.St_Id
JOIN Course C 
  ON C.Crs_Id = SC.Crs_Id
WHERE SC.Grade IS NOT NULL;

-- 5. Display number of courses for each topic name.
SELECT T.Top_Name, COUNT(C.Crs_Id) AS [Number of Courses]
FROM Topic T 
LEFT JOIN Course C
  ON T.Top_Id = C.Top_Id
GROUP BY T.Top_Name;

-- 6. Select Student first name and the data of his supervisor.
SELECT S.St_Fname AS [Student Name], 
       Super.*
FROM Student S 
JOIN Student Super
  ON Super.St_Id = S.St_super;

  ---------------------------
  --Max 3 salaries as instructor
--max 
-- frist salary
-- second salary
use ITI

select max(Salary)
from Instructor

select max(Salary)
from Instructor
where Salary != 
(
select max(Salary)
from Instructor
)


select max(Salary)
from Instructor
where Salary != (
(
select max(Salary)
from Instructor
)
)
--------------------------
--Top 


select top(7) St_Age
from Student
order by St_Age desc

--------------------
--خد اول سبع قيم بالاضافه للقيم المشابه

select top(7) with ties St_Age
from Student
order by St_Age desc

----------------------

