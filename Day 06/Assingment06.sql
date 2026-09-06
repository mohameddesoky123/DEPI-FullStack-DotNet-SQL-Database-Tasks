use ITI
--1. Create a scalar function that takes date and returns Month name of that date.

CREATE FUNCTION GetNameMonthByDate(@DateName DATE)
RETURNS VARCHAR(20)
BEGIN
    
    RETURN DATENAME(MONTH, @DateName);
END;

select dbo.GetNameMonthByDate('2026-09-12') As [Month Name]

--2. Create a multi-statements table-valued function that takes 2 integers and returns the values between them. 
CREATE FUNCTION GetValuesBetween (@Start INT, @End INT)
RETURNS @ResultTable TABLE (Value INT)

BEGIN
    DECLARE @Current INT = @Start + 1

    WHILE @Current < @End
    BEGIN
        INSERT INTO @ResultTable (Value)
        VALUES (@Current)

        SET @Current = @Current + 1
    END

    RETURN
END



SELECT * FROM dbo.GetValuesBetween(10, 15)

--3. Create a tabled valued function that takes Student No and returns Department Name with Student full name. 

CREATE FUNCTION GetStudentDept (@StId INT)
RETURNS TABLE

RETURN
(
    SELECT 
        s.St_Fname + ' ' + s.St_Lname AS [Full Name],
        d.Dept_Name AS [Department Name]
    FROM Student s
    JOIN Department d ON s.Dept_Id = d.Dept_Id
    WHERE s.St_Id = @StId
)


SELECT * FROM dbo.GetStudentDept(1)

/*
4. Create a scalar function that takes Student ID and returns a message to
user
a. If first name and Last name are null then display 'First name &
last name are null'
b. If First name is null then display 'first name is null'
c. If Last name is null then display 'last name is null'
d. Else display 'First name & last name are not null'
*/

CREATE FUNCTION CheckStudentName (@StId INT)
RETURNS VARCHAR(100)

BEGIN
    DECLARE @Fname VARCHAR(50), @Lname VARCHAR(50)
    DECLARE @Msg VARCHAR(100)

    SELECT @Fname = St_Fname, @Lname = St_Lname
    FROM Student
    WHERE St_Id = @StId

    IF @Fname IS NULL AND @Lname IS NULL
        SET @Msg = 'First name & last name are null'
    ELSE IF @Fname IS NULL
        SET @Msg = 'first name is null'
    ELSE IF @Lname IS NULL
        SET @Msg = 'last name is null'
    ELSE
        SET @Msg = 'First name & last name are not null'

    RETURN @Msg
END

SELECT dbo.CheckStudentName(1)

/*
5. Create a function that takes integer which represents the format of the
Manager hiring date and displays department name, Manager Name and
hiring date with this format. 
*/

CREATE FUNCTION GetManagerInfo (@Format INT)
RETURNS TABLE

RETURN
(
    SELECT 
        d.Dept_Name AS [Department Name],
        i.Ins_Name AS [Manager Name],
        CONVERT(VARCHAR(50), d.Manager_hiredate, @Format) AS [Hiring Date]
    FROM Department d
    LEFT JOIN Instructor i ON d.Dept_Manager = i.Ins_Id
)

SELECT * FROM dbo.GetManagerInfo(101)

/*
6. Create multi-statements table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name
If string='full name' returns Full Name from student table
Note: Use “ISNULL” function 
*/

CREATE FUNCTION GetStudentNames (@Type VARCHAR(20))
RETURNS @ResultTable TABLE (StudentName VARCHAR(100))

BEGIN
    IF @Type = 'first name'
    BEGIN
        INSERT INTO @ResultTable
        SELECT ISNULL(St_Fname, '') FROM Student
    END
    ELSE IF @Type = 'last name'
    BEGIN
        INSERT INTO @ResultTable
        SELECT ISNULL(St_Lname, '') FROM Student
    END
    ELSE IF @Type = 'full name'
    BEGIN
        INSERT INTO @ResultTable
        SELECT ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '') FROM Student
    END

    RETURN
END

SELECT * FROM dbo.GetStudentNames('full name')

--Note: Use MyCompany DB 
--1. Create function that takes project number and display all employees in this project 
use MyCompany

CREATE FUNCTION GetEmployeesByProject (@Pnum INT)
RETURNS TABLE

RETURN
(
    SELECT 
        e.SSN,
        e.Fname + ' ' + e.Lname AS [Employee Name],
        p.Pname AS [Project Name]
    FROM Employee e
    JOIN Works_for w ON e.SSN = w.ESSN
    JOIN Project p ON w.Pno = p.Pnumber
    WHERE w.Pno = @Pnum
)



SELECT * FROM dbo.GetEmployeesByProject(100)