=== doc desafio de projeto

dotnet --list-sdks

dotnet --list-sdks


Pessoal reorganizei o código da professora agora tudo está ok, vou enviar aqui para ajudar quem estiver com dúvida:

 [System.Data.Common.DbProviderFactories]::GetFactoryClasses()|ogv
 
https://dev.mysql.com/downloads/connector/net/


-

https://www.db4free.net/
instance: desafiodio
u/p: udesafiodio/pdesafiodio

https://www.db4free.net/phpMyAdmin/index.php?route=/

---

create schema if not exists azure_company;
use azure_company;

select * from information_schema.table_constraints
where constraint_schema = 'azure_company';


use desafiodio;



use anaconda;

CREATE TABLE employee(
Fname varchar(15) not null,
  Minit char,
  Lname varchar(15) not null,
  Ssn char(9) not null, 
  Bdate date,
  Address varchar(30),
  Sex char,
  Salary decimal(10,2),
  Super_ssn char(9),
  Dno int not null
);

alter table employee modify Dno int not null default 1;
alter table employee add constraint pk_employee primary key (Ssn);
alter table employee add constraint chk_salary_employee check (Salary> 2000.0);

create table departament(
Dname varchar(15) not null,
  Dnumber int not null,
  Mgr_ssn char(9) not null,
  Mgr_start_date date, 
  Dept_create_date date
);

alter table departament add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn) on update cascade;
alter table departament constraint chk_date_dept check (Dept_create_date < Mgr_start_date);
alter table departament constraint pk_dept primary key (Dnumber);
alter table departament constraint unique_name_dept unique(Dname);

create table dept_locations(
Dnumber int not null,
Dlocation varchar(15) not null
);

alter table dept_locations add constraint pk_dept_locations primary key (Dnumber, Dlocation);
alter table dept_locations add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber) on delete cascade on update cascade;

create table project(
Pname varchar(15) not null,
Pnumber int not null,
  Plocation varchar(15),
  Dnum int not null,
  primary key (Pnumber)
);
alter table project add constraint unique_project unique (Pname);
alter table project add constraint fk_project foreign key (Dnum) references departament(Dnumber);

create table works_on(
Essn char(9) not null,
  Pno int not null,
  Hours decimal(3,1) not null
);
alter table works_on add primary key (Essn, Pno);
alter table works_on add constraint fk_employee_works_on foreign key (Essn) references employee(Ssn);
alter table works_on add constraint fk_project_works_on foreign key (Pno) references project(Pnumber);

create table dependent(
Essn char(9) not null,
  Dependent_name varchar(15) not null,
  Sex char,
  Bdate date,
  Relationship varchar(8)
);

alter table dependent add primary key (Essn, Dependent_name);
alter table dependent add constraint fk_dependent foreign key (Essn) references employee(Ssn);

insert into employee values ('John', 'B', 'Smith', 123456789, '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, 333445555, 5), ('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, 888665555, 5), ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, 987654321, 4), ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, 888665555, 4), ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, 333445555, 5), ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, 333445555, 5), ('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, 987654321, 4), ('James', 'E', 'Borg', 888665555, '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1);
insert into dependent values (333445555, 'Alice', 'F', '1986-04-05', 'Daughter'), (333445555, 'Theodore', 'M', '1983-10-25', 'Son'), (333445555, 'Joy', 'F', '1958-05-03', 'Spouse'), (987654321, 'Abner', 'M', '1942-02-28', 'Spouse'), (123456789, 'Michael', 'M', '1988-01-04', 'Son'), (123456789, 'Alice', 'F', '1988-12-30', 'Daughter'), (123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');
insert into departament values ('Research', 5, 333445555, '1988-05-22','1986-05-22'), ('Administration', 4, 987654321, '1995-01-01','1994-01-01'), ('Headquarters', 1, 888665555,'1981-06-19','1980-06-19');
insert into dept_locations values (1, 'Houston'), (4, 'Stafford'), (5, 'Bellaire'), (5, 'Sugarland'), (5, 'Houston');
insert into project values ('ProductX', 1, 'Bellaire', 5), ('ProductY', 2, 'Sugarland', 5), ('ProductZ', 3, 'Houston', 5), ('Computerization', 10, 'Stafford', 4), ('Reorganization', 20, 'Houston', 1), ('Newbenefits', 30, 'Stafford', 4);
insert into works_on values (123456789, 1, 32.5), (123456789, 2, 7.5), (666884444, 3, 40.0), (453453453, 1, 20.0), (453453453, 2, 20.0), (333445555, 2, 10.0), (333445555, 3, 10.0), (333445555, 10, 10.0), (333445555, 20, 10.0), (999887777, 30, 30.0), (999887777, 10, 10.0), (987987987, 10, 35.0), (987987987, 30, 5.0), (987654321, 30, 20.0), (987654321, 20, 15.0), (888665555, 20, 0.0);



---




use anaconda;
drop table departament;
drop table employee;

private static final String URL = "jdbc:mysql://db4free.net:3306/texian";
private static final String USER = "meubanco";
private static final String PASS = "minha senha";
