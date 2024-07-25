
use ecommerce;

create user 'geral'@localhost identified by '123454321';
grant all privileges on testuser.* to 'geral'@localhost;
drop table employee;

drop trigger null_value_check;
create table if not exists employee(
Fname varchar(10),
Minit char(3),
Lname varchar(15),
Sex char(1),
Ssn varchar(13),
Address varchar(50),
Dno int,
Salary decimal(10,2)
); 

drop view employees_salary_27000_view;
create view employees_salary_27000_view as
	select concat(Fname,Minit,Lname) as Name, Salary, Dno as Dept_number from employee
    where Salary > 26999;
    
select* from employee_salary_27000_view;

drop view employees_salary_view;
create view employees_salary_view as
	select concat(Fname,Minit,Lname) as Name, Salary, Dno as Dept_number from employee
    where Sex = 'M';
    
select * from employees_salary_27000_view;
select * from employees_salary_view;

delimiter //
create trigger null_value_check after insert on employee
for each row
	if (new.Address is null) then
		insert into user_messages (message, ssn) values(concat('Update your address, please ',new.Fname), new.Ssn);
	else
		insert into user_messages (message, ssn) values(concat('Error ', new.Fname),new.Ssn);
	end if;
//
delimiter ;
