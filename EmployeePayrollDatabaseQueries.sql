
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
	 ( 'Ruwaid',3000000.00,'2021-06-24');

//----UC4-> Retrieving the data
	  select * from employee_payroll

//---UC5->Ability to retrieve salary data as well as employee joined at a particular date range
	 select salary from employee_payroll where name ='Kubra';
	 select * from employee_payroll
 where start BETWEEN CAST('2018-01-01' AS DATE) AND GETDATE();

 //----UC6->Adding gender column and updating the rows
	 ALTER TABLE employee_payroll ADD gender CHAR(1) ;
	 
	 update employee_payroll set gender ='F' where name ='Kubra';

	 update employee_payroll set gender ='M' where name = 'Tanveer' or name='Ruwaid';

	 update employee_payroll set salary =3000000 where name = 'Kubra';

//----UC7->Finding Sum ,Avg, Min, Max and Count

	 select SUM(salary) from employee_payroll where gender= 'M' GROUP BY gender;
	 
	 select count(*), gender from employee_payroll group by gender;

	  select AVG(salary) from employee_payroll where gender= 'F' GROUP BY gender;

	   select MIN(salary) from employee_payroll where gender= 'M' GROUP BY gender;
	 
	  select MAX(salary) from employee_payroll where gender= 'M' GROUP BY gender;
	 
	 