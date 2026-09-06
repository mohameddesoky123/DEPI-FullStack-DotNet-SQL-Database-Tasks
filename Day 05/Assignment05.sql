USE ITI

-- 1- Max 3 salaries in instructors using Max, Top and Rank.

-- Using Top
SELECT TOP 3 Salary 
FROM Instructor 
ORDER BY Salary DESC;

-- Using Rank
WITH RankedSalaries AS (
    SELECT Salary, DENSE_RANK() OVER(ORDER BY Salary DESC) as rnk
    FROM Instructor
)
SELECT DISTINCT Salary 
FROM RankedSalaries 
WHERE rnk <= 3;

-- Using Max (Correlated subquery)
SELECT DISTINCT Salary 
FROM Instructor i1 
WHERE 3 > (
    SELECT COUNT(DISTINCT Salary) 
    FROM Instructor i2 
    WHERE i2.Salary > i1.Salary
);


-- 2- third instructor as Salary using Max, Top and Rank.

-- Using Top
SELECT TOP 1 Salary 
FROM (
    SELECT TOP 3 Salary 
    FROM Instructor 
    ORDER BY Salary DESC
) as T 
ORDER BY Salary ASC;

-- Using Rank
WITH RankedSalaries AS (
    SELECT Salary, DENSE_RANK() OVER(ORDER BY Salary DESC) as rnk
    FROM Instructor
)
SELECT DISTINCT Salary 
FROM RankedSalaries 
WHERE rnk = 3;

-- Using Max
SELECT MAX(Salary) 
FROM Instructor 
WHERE Salary < (
    SELECT MAX(Salary) 
    FROM Instructor 
    WHERE Salary < (
        SELECT MAX(Salary) 
        FROM Instructor
    )
);


-- 3- make random select for 3 students.
SELECT TOP 3 * 
FROM Student 
ORDER BY NEWID();


-- 4- need to get first name and age for older student for each department.
WITH StudentAges AS (
    SELECT st_fname, st_age, dept_id, 
           ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY st_age DESC) as rnk
    FROM Student 
    WHERE st_age IS NOT NULL
)
SELECT st_fname, st_age, dept_id
FROM StudentAges
WHERE rnk = 1;


-- 5- need to display instructors data who are in middle class in iti database.
WITH InstructorClass AS (
    SELECT *, NTILE(3) OVER(ORDER BY Salary) as class
    FROM Instructor
)
SELECT * 
FROM InstructorClass 
WHERE class = 2;


-- 6- create Pr schema -> transfer student to this schema -> transfer student back to dbo -> drop this schema
CREATE SCHEMA Pr;
GO
ALTER SCHEMA Pr TRANSFER dbo.Student;
GO
ALTER SCHEMA dbo TRANSFER Pr.Student;
GO
DROP SCHEMA Pr;
GO


-- 7- make a database calles Test and then :
-- -> create a new table has same structure and data of table Employee in MyCompany database.
-- -> Create a new table has same structure of Project table in My company database
-- -> insert the data in table Project in mycompany database in table u just created with only structure

CREATE DATABASE Test;
GO
USE Test;
GO

SELECT * INTO Employee 
FROM MyCompany.dbo.Employee;

SELECT * INTO Project 
FROM MyCompany.dbo.Project 
WHERE 1=0;

INSERT INTO Project 
SELECT * FROM MyCompany.dbo.Project;


-- 8- make 2 tables called employees : 
-- ( first name , last name , Id , SSN , Age , gendre , Salary , Dno ) 
-- and Departments ( name , number , Mgrstartdate )
-- use Constraints : PK , null or not null , default , check , unique , FK based on ur common sense

CREATE TABLE Departments (
    number INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    Mgrstartdate DATE
);

CREATE TABLE employees (
    Id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    SSN VARCHAR(14) UNIQUE NOT NULL,
    Age INT CHECK (Age >= 18),
    gendre VARCHAR(10) DEFAULT 'Unknown' CHECK (gendre IN ('Male', 'Female', 'Unknown')),
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Dno INT,
    CONSTRAINT fk_emp_dept FOREIGN KEY (Dno) REFERENCES Departments(number)
);


-- 9- for the foreign key u declared > add delete and update rule 
-- for delete -> set null -> for update Cascade

ALTER TABLE employees
DROP CONSTRAINT fk_emp_dept;

ALTER TABLE employees
ADD CONSTRAINT fk_emp_dept FOREIGN KEY (Dno) REFERENCES Departments(number)
ON DELETE SET NULL
ON UPDATE CASCADE;