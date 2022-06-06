-- Initialization SQL script that build default bases and tables

-- Creating user and grant him some privileges
create or replace user 'mansys'@'%' identified by 'pass';
grant all privileges on man_sys_db.* to 'mansys'@'%';
flush privileges;

drop database if exists man_sys_db;
-- Creating or replacing database
create database man_sys_db;
use man_sys_db;

drop table if exists Employees;
drop table if exists Requests;
drop table if exists Clients;


-- Creating Employees table
create table  Employees(
	ID int not null auto_increment , -- Employee identificator
	Name varchar(255),
	Surname varchar(255),
	Phone varchar(255),
	Email varchar(255),
	DID int, -- Department ID
	Position varchar(255), -- Position in linked department

	primary key(ID)
) ENGINE=INNODB; 

-- Creating Tasks table
create table Requests(
	ID int primary key not null auto_increment , -- Request identificator
	About varchar(500),
	EID int,
	CID int,

	Creation_time datetime default CURRENT_TIMESTAMP,
	Request_status varchar(50) default("Created"),
	
	index E_ID (EID),
	foreign key (EID)
		references Employees(ID)
		on delete cascade

	index C_ID (CID),
	foreign key (CID)
		references Clients(ID)
		on delete cascade
) ENGINE=INNODB;

-- Creating Departments table
create table  Clients(
	ID int not null auto_increment , -- Client identificator
	Name varchar(255),
	Surname varchar(255),
	Phone varchar(255),
	Email varchar(255),

	primary key(ID)
) ENGINE=INNODB; 


-- Insert some employees and tasks
insert into Employees 
(Name, Surname, Phone, Email)
values
("Vasya", "Pupkin", "81123123", "vasya@corp"),
("Petya", "Kryakov", "4114122", "petya@corp"),
("Masha", "Seltcina", "123123", "masha@corp"),
("Lyda", "Maryana", "31312213", "lyda@corp"),
("Ivan", "Shpakov", "981414", "ivan@corp"),
("Gleb", "Matiyshin", "228337", "gleb228338332455@mail.ru");

insert into Tasks
(About, EID)
values
("Planning tasks", 1),
("Developing routes", 3),
("Researhing", 2),
("Managing graduates", 5);

-- ---------------------------------
-- | Strings for mechanics testing |
-- ---------------------------------

-- drop table if exists parent;
-- drop table if exists child;

-- CREATE TABLE parent (
--     id INT NOT NULL,
--     PRIMARY KEY (id)
-- ) ENGINE=INNODB;

-- CREATE TABLE child (
--     id INT,
--     parent_id INT,
--     INDEX par_ind (parent_id),
--     FOREIGN KEY (parent_id)
--         REFERENCES parent(id)
--         ON DELETE set null
-- ) ENGINE=INNODB;

-- insert into parent values (234), (238);
-- insert into child values (1, 234), (2, 234), (3, 238);
-- select * from parent;
-- select * from child;
