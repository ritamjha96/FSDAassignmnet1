CREATE WAREHOUSE sql_assignments WITH WAREHOUSE_SIZE = 'MEDIUM' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 600 AUTO_RESUME = TRUE;

--Task1
create database ineuron_task1;
use database ineuron_task1;

create table shopping_history(
product varchar(60) not null,
quantity integer not null,
unit_price integer not null
);

select * from shopping_history;

insert into shopping_history(product,quantity,unit_price) values ('milk',3,10);
insert into shopping_history(product,quantity,unit_price) values('bread',7,3);
insert into shopping_history(product,quantity,unit_price) values('bread',5,2);
insert into shopping_history(product,quantity,unit_price) values('orange',5,4);
insert into shopping_history(product,quantity,unit_price) values('apple',4,6);
insert into shopping_history(product,quantity,unit_price) values('eggs',10,4);
insert into shopping_history(product,quantity,unit_price) values('bananas',12,1);
insert into shopping_history(product,quantity,unit_price) values('eggs',5,3);
insert into shopping_history(product,quantity,unit_price) values('butter',3,10);
insert into shopping_history(product,quantity,unit_price) values('apple',2,7);

select product, sum(quantity * unit_price) as total_price from shopping_history group by product order by product;

--Task2

create database ineuron_task2;
use database ineuron_task2;

create table phones (
name varchar(20) not null unique,
phone_number integer not null unique
);

insert into phones(name, phone_number) values('Jack',1234);
insert into phones(name, phone_number) values('Lena',3333);
insert into phones(name, phone_number) values('Mark',9999);
insert into phones(name, phone_number) values('Anna',7582);

select * from phones;

create table calls (
    id integer not null,
    caller integer not null,
    callee integer not null,
    duration integer not null,
    unique(id)
);

insert into calls values (25,1234,7582,8);
insert into calls values(7,9999,7582,1);
insert into calls values(18,9999,3333,4);
insert into calls values(2,7582,3333,3);
insert into calls values(3,3333,1234,1);
insert into calls values(21,3333,1234,1);

select * from calls;

--first we have to create a separate table with all the names and the call duration

select p.name, sum(c.duration) as sum_duration from phones p 
inner join calls c on p.phone_number = c.caller group by name
union 
select p.name, sum(c.duration) as sum_duration from phones p
inner  join calls c on p.phone_number = c.callee group by name;

--using the previous query as a sub query

select name
from (select p.name, sum(c.duration) as sum_duration from phones p 
inner join calls c on p.phone_number = c.caller group by name
union 
select p.name, sum(c.duration) as sum_duration from phones p
inner  join calls c on p.phone_number = c.callee group by name) as new_table
group by name having sum(sum_duration) >=10 order by name;

--Task2.2

truncate table phones;
truncate table calls;

insert into phones values ('John',6356);
insert into phones values('Addison',4315);
insert into phones values('Kate',8003);
insert into phones values('Ginny',9831);

insert into calls values (65,8003,9831,7);
insert into calls values (100,9831,8003,3);
insert into calls values (145,4315,9831,18);

select * from phones;

select * from calls;

select name
from (select p.name, sum(c.duration) as sum_duration from phones p 
inner join calls c on p.phone_number = c.caller group by name
union 
select p.name, sum(c.duration) as sum_duration from phones p
inner  join calls c on p.phone_number = c.callee group by name) as new_table
group by name having sum(sum_duration) >=10 order by name;


--Task3

create database ineuron_task3;
use database ineuron_task3;

create table transactions(
amount integer not null,
date date not null
);

insert into transactions(amount,date) values (1000,'2020-01-06');
insert into transactions(amount,date) values(-10,'2020-01-14');
insert into transactions(amount,date) values(-75,'2020-01-20');
insert into transactions(amount,date) values(-5,'2020-01-25');
insert into transactions(amount,date) values(-4,'2020-01-29');
insert into transactions(amount,date) values(2000,'2020-03-10');
insert into transactions(amount,date) values(-75,'2020-03-12');
insert into transactions(amount,date) values(-20,'2020-03-15');
insert into transactions(amount,date) values(40,'2020-03-15');
insert into transactions(amount,date) values(-50,'2020-03-17');
insert into transactions(amount,date) values(200,'2020-10-10');
insert into transactions(amount,date) values(-200,'2020-10-10');

select * from transactions;

with new_table as (select sum(amount) as total_trans, count(amount) as no_of_trans
from transactions where amount<0 group by year(date),month(date)                  
having total_trans<=-100 and no_of_trans>=3)
select sum(amount)-(5*(12-(select count(*) from new_table))) as balance from transactions;

--TAsk3.2

truncate table transactions;

insert into transactions values (1,'2020-06-29');
insert into transactions values(35,'2020-02-20');
insert into transactions values(-50,'2020-02-03');
insert into transactions values(-1,'2020-02-26');
insert into transactions values(-200,'2020-08-01');
insert into transactions values(-44,'2020-02-07');
insert into transactions values(-5,'2020-02-25');
insert into transactions values(1,'2020-06-29');
insert into transactions values(1,'2020-06-29');
insert into transactions values(-100,'2020-12-29');
insert into transactions values(-100,'2020-12-30');
insert into transactions values(-100,'2020-12-31');

select * from transactions;

with new_table as (select sum(amount) as total_trans, count(amount) as no_of_trans
from transactions where amount<0 group by year(date),month(date)                  
having total_trans<=-100 and no_of_trans>=3)
select sum(amount)-(5*(12-(select count(*) from new_table))) as balance from transactions;

--Task3.3

truncate table transactions;

insert into transactions values(6000,'2020-04-03');
insert into transactions values(5000,'2020-04-02');
insert into transactions values(4000,'2020-04-01');
insert into transactions values(3000,'2020-03-01');
insert into transactions values(2000,'2020-02-01');
insert into transactions values(1000,'2020-01-01');

select * from transactions;

with new_table as (select sum(amount) as total_trans, count(amount) as no_of_trans
from transactions where amount<0 group by year(date),month(date)                  
having total_trans<=-100 and no_of_trans>=3)
select sum(amount)-(5*(12-(select count(*) from new_table))) as balance from transactions;
