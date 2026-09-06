use ITI
--01 Insert your personal data to the Student table as a new Student in department number 30.
select *
from Student

insert into Student
values (17,'Mohamed','Desoky','Giza',20,30,null)
--02 Insert Instructor with personal data of your friend as new Instructor in department
--number 30, Salary= 4000, but don’t enter any value for bonus.

select *
from Instructor

insert into Instructor
values (16,'Mohamed','Master',4000,30)

--03 Upgrade Instructor salary by 20 % of its last value.

update Instructor
set Salary =(Salary*0.2)+Salary
---------------------------------------------------------
use MyCompany
--4. Display all the employees Data
select *
from Employee

--5. Display the employee First name, last name, Salary and Department number.
select Fname,Lname,Salary,Dno
from Employee
 --6. Display all the projects names, locations and the department which is responsible
--about it.
select *
from Project

select Pname , Plocation , Dnum
from Project

/*7. If you know that the company policy is to pay an annual commission for each
employee with specific percent equals 10% of his/her annual salary .Display each
employee full name and his annual commission in an ANNUAL COMM column
(alias).*/

select Fname+' '+Lname as [Full Name],(Salary * 12 * 0.10) AS [ANNUAL COMM]
from Employee

--8. Display the employees Id, name who earns more than 1000 LE monthly

select SSN , Fname+' '+Lname as [Full Name],Salary
from Employee
where Salary >1000

--9. Display the employees Id, name who earns more than 10000 LE annually

select SSN , Fname+' '+Lname as [Full Name],(Salary*12) as [Salary Annually]
from Employee
where (Salary*12) >10000

--10. Display the names and salaries of the female employees 

select  Fname+' '+Lname as [Full Name],Salary
from Employee
where Sex= 'f'

--1. Retrieve number of students who have a value in their age.
use ITI

SELECT COUNT(St_Age) AS [Students With Age]
FROM Student;


-- self study
/*
1. Why is DECIMAL preferred over FLOAT for monetary values?
--DECIMAL is an Exact Numeric data type, storing exact values without rounding errors.

--FLOAT is an Approximate Numeric data type, which causes subtle floating-point rounding errors in financial calculations.

*/


/*
2. Default Precision & Scale for DECIMAL and Fractional Values:
Defaults: Declaring DECIMAL without arguments defaults to DECIMAL(18, 0) (Precision = 18, Scale = 0).

Can it store fractions? No, because Scale is 0 by default, meaning all fractional values will be rounded to the nearest integer.
*/


