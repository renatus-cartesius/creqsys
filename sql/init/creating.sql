-- Initialization SQL script that build default bases and tables


drop database if exists creqsys_db;
-- Creating or replacing database
create database creqsys_db;

-- Creating user and grant him some privileges
create or replace user 'creqsys'@'%' identified by 'pass';
grant all privileges on creqsys_db.* to 'creqsys'@'%';
flush privileges;

use creqsys_db;

drop table if exists Employees;
drop table if exists Requests;
drop table if exists Clients;

set names utf8;
-- Creating Employees table
create table  Employees(
	ID int not null auto_increment , -- Employee identificator
	Name varchar(255),
	Surname varchar(255),
	Phone varchar(255),
	Email varchar(255),
	Position varchar(255), -- Position in linked department

	primary key(ID)
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

-- Creating Requests table
create table Requests(
	ID int primary key not null auto_increment , -- Request identificator
	About varchar(1500),
	EID int,
	Reqt varchar(500),
	CID int,

	Creation_time datetime default CURRENT_TIMESTAMP,
	Request_status varchar(50) default("Created"),
	
	index E_ID (EID),
	foreign key (EID)
		references Employees(ID)
		on delete cascade,

	index C_ID (CID),
	foreign key (CID)
		references Clients(ID)
		on delete cascade
) ENGINE=INNODB;



-- Insert some employees and tasks
insert into Employees 
(Name, Surname, Phone, Email, Position)
values
("Владимир", "Морозов", "801885", "dau9879@mail.com", "Работник колл-центра"),
("Мирослава", "Прохоров", "592999", "kiy5577@mail.com", "Работник колл-центра"),
("Надежда", "Кудрявцева", "672623", "hitri8734@mail.com", "Работник пресс-службы");

insert into Clients 
(Name, Surname, Phone, Email)
values
("Артём", "Мирный", "12869736", "Artom@com"),
("Ольга", "Маркова", "4189150", "pat4276@yopmail.com"),
("Михаил", "Филипповов", "9528040", "xe6500@yopmail.com"),
("Макар ", "Киселев ", "975318", "veu7465@yopmail.com"),
("Полина ", "Калинина", "5001427", "gaun3812@yopmail.com"),
("Дарья ", "Егорова", "4027955", "h2884@yopmail.com"),
("Ева ", "Захарова", "5076084", "brafi6340@yopmail.com"),
("Кирилл ", "Федотов", "3391389", "cu1870@yopmail.com"),
("Роман ", "Савельев", "9064244", "lize7218@yopmail.com"),
("Лев ", "Виноградов", "8837333", "jeve@yopmail.com");

insert into Requests
(About, Reqt,  EID, CID)
values
("Сломался роутер. Помогите починить", "Техническая проблема", 1, 1),
("У меня кончился интернет. Как его продлить и куда кидать деньги?", "Оплата", 2, 5),
("Не ловит вифи на телефоне. Это проблема в блюпуп? ", "Техническая проблема", 3, 3),
("Как скачать браузер на компьютер? Подскажите", "Программная проблема", 1, 4),
("А сколько стоят ваши услуги?", 3, "Оплата", 6);

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
