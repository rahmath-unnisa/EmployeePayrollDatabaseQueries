
//------------------------DEMO-----------------
Create Database Example;



Create Table Demo (
ID int primary key Identity(1,1),
name varchar(20),
age int
);

insert into Demo values('Manha',01);

insert into Demo (Age,Name) Values(24,'Asfia')

Update Demo Set Age=30 where ID=2;

Select * from Demo;

Select * from Demo where ID in (1,2);

Select * from Demo where Name like 'Asf%';

Delete from Demo where ID=2;

-------------------------STARTING OF USE CASES----------------------------------------
//----UC1-> Creating a database
create DataBase payroll_service;


//----UC2-> Creating a table employee_payroll
	CREATE TABLE employee_payroll
	(
	ID int primary key Identity(1,1) ,
	name VARCHAR(150),
	salary DECIMAL (12,4),
	start DATE NOT NULL,
	);
	 Select * from employee_payroll;

//----UC3-> Performing CRUD operation
	 insert into employee_payroll(name,salary,start) values
	 ( 'Tanveer',1000000.00,'2020-11-01'),
	 ( 'Kubra',2000000.00,'2019-02-02'),
	 ( 'Ruwaid',3000000.00,'2021-06-24'),
	 ( 'Ayesha',3000000.00,'2018-01-29'),
	 ( 'Aman',1200000.00,'2020-04-21'),
	 ('Faraz',2300000.00,'2019-12-15');

//----UC4-> Retrieving the data
	  select * from employee_payroll

//---UC5->Ability to retrieve salary data as well as employee joined at a particular date range
	 select salary from employee_payroll where name ='Kubra';
	 select * from employee_payroll
 where start BETWEEN CAST('2018-01-01' AS DATE) AND GETDATE();

 //----UC6->Adding gender column and updating the rows
	 ALTER TABLE employee_payroll ADD gender CHAR(1) ;
	 
	 update employee_payroll set gender ='F' where name ='Ayesha';

	 update employee_payroll set gender ='M' where name = 'Aman' or name='Faraz';

	 update employee_payroll set salary =3000000 where name = 'Kubra';

----UC7->Finding Sum ,Avg, Min, Max and Count

	 select SUM(salary) from employee_payroll where gender= 'M' GROUP BY gender;
	 
	 select count(*), gender from employee_payroll group by gender;

	  select AVG(salary) from employee_payroll where gender= 'F' GROUP BY gender;

	   select MIN(salary) from employee_payroll where gender= 'M' GROUP BY gender;
	 
	  select MAX(salary) from employee_payroll where gender= 'M' GROUP BY gender;
	 
	 delete from employee_payroll where id=1;
	  select * from employee_payroll

	   insert into employee_payroll(name,salary,start) values
	    ( 'Ayesha',3000000.00,'2018-01-29'),
	 ( 'Aman',1200000.00,'2020-04-21'),
	 ('Faraz',2300000.00,'2019-12-15');
	  select * from employee_payroll

-------------------CREATING PROCEDURE------------
GO
Create Procedure spSalaryList
AS
BEGIN
select * from employee_payroll where salary=3000000.00;
END	

Execute spSalaryList

GO
Create Procedure spGenderList
AS
BEGIN
select * from employee_payroll where gender='M';
END 

Execute spGenderList
-------------------------------------ALTERING THE PROCEDURE
GO
ALTER Procedure spGenderList
AS
BEGIN
select * from employee_payroll where  start BETWEEN CAST('2020-01-01' AS DATE) AND GETDATE();
select * from employee_payroll where gender='M';
END 

---------------------DROPPINGTHE PROCEDURE

DROP proc spSalaryList
--------------------ALTERING WITH PARAMETERS----------
GO
ALTER Procedure spGenderList
@emp_id  int,
@emp_name varchar(20)
AS
BEGIN
select * from employee_payroll where id=@emp_id;
select * from employee_payroll where name=@emp_name;
END 
 
 spGenderList 7, 'Ruwaid'
 ---------------------------------------------------
 go
 ALTER Procedure spGenderList
@emp_id  int,
@emp_salary Decimal(12,4)
AS
BEGIN
select * from employee_payroll where id=@emp_id;
select * from employee_payroll where salary=@emp_salary;
END 
 
 spGenderList @emp_id=8, @emp_salary=1000000.00
 
 -
 ----------------OUTPUT PARAMETER------------------------
 Go
 CREATE PROC spAddDigit
 @Num1 int,
 @Num2 int,
 @Result int output
 AS
 BEGIN
	set @Result=@Num1+@Num2;
END

Declare @otp int
Exec spAddDigit 3,8, @otp output;
SELECT @otp

--------------------------------------------------------------------------------------
 -----------------------------FUNCTIONS--------------------------
 --SCALAR    

 GO
 CREATE OR ALTER FUNCTION faddsalary (@ColumnName int ,@num int)
 returns int as
 BEGIN
 RETURN @ColumnName+ @num
END
GO

  SELECT * , dbo.faddsalary(salary,20) AS AddingSalary from employee_payroll


  ---TABULAR
  GO
  CREATE FUNCTION select_gender(@Empgender as char(1))
  RETURNS table
  AS
  RETURN
  (
  select * from employee_payroll where gender=@Empgender
  )
  go
  select * from dbo.select_gender('F')
  ------------------------------------------------------------------------------------------------------------------------------------------------------------
 -------------------------------UC8->adding columns to the table-----------------------
 Alter table Employee_Payroll Add PhoneNumber varchar(10);

Update Employee_Payroll Set PhoneNumber='7829986477' where Id=2;

ALTER TABLE Employee_Payroll ADD Address varchar(200) not null default 'Hassan';

ALTER TABLE Employee_Payroll ADD Department varchar(100);

Update Employee_Payroll Set Department='Development' where Name='Tanveer';

select * from employee_payroll
alter table Employee_Payroll drop column Addres;
  

  -------------------------------------------------------------------------------------
  ------------------------------UC9->
  ALTER TABLE Employee_Payroll ADD Deduction int not null default 0 ;

ALTER TABLE Employee_Payroll ADD Taxable_Pay int not null default 0 ;

ALTER TABLE Employee_Payroll ADD Net_Pay int not null default 0 ;
Insert into Employee_Payroll
(Name,Salary,Start,Gender,PhoneNumber,Department,Deduction,Taxable_Pay,Net_Pay,Income_Tax) Values
('Manha',55000,'2022.06.30','F','9880474768','',1250,200,450000,3400);

select * from Employee_payroll;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------UC10->
update Employee_payroll set Name = 'Terisa',Gender = 'F' where Id = 4;

alter table Employee_payroll Drop column Department;

create table Department(
deptID INT Primary key identity(1,1),
DepartmentName varchar(50)
);

insert into Department values
('Marketing'),
('Sales');

create table EmpAndDept(
empID INT,
deptID INT
);

alter table EmpAndDept ADD FOREIGN KEY (empID)
REFERENCES Employee_payroll(Id);
alter table EmpAndDept ADD FOREIGN KEY (deptID)
REFERENCES Department(deptID);

insert into EmpAndDept values
(3,1),
(3,2);

select * from Employee_payroll INNER JOIN
EmpAndDept on Employee_payroll.Id = EmpAndDept.empID INNER JOIN
Department ON Department.deptID = EmpAndDept.deptID

Create procedure spGetAllEmployees
as
begin
select * from Employee_payroll
END