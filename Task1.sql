create table stud(
    id INT not null primary key,
	name VARCHAR(50) not null,
	age INT not null,
	grade INT not null
);
create user admin with password 'qwerty123';
grant insert,select,update,delete on stud to admin;
insert into stud(id,name,age,grade) values
       (1,'Alice',18,12),
	   (2,'Bob',17,11),
	   (3,'Charlie',19,12),
	   (4,'David',18,11),
	   (5,'Emma',17,10),
	   (6,'Fiona',19,12),
	   (7,'George',18,10),
	   (8,'Helen',17,11),
	   (9,'Ivan',19,12),
	   (10,'Jack',18,10);
insert into stud(id,name,age,grade) values
       (11,'Akylbek',18,12),
	   (12,'Adina',18,12);
update stud set age=age+1 where id=1;
update stud set name='Beka' where id=2;
delete from stud where id=3;
delete from stud where name='Helen';
alter table stud add constraint grade check(grade<=12);
alter table stud add constraint age check(age>5);
alter table stud add constraint name unique(name);
alter table stud add constraint id unique(id);


SELECT * from stud;
select name from stud;
select * from stud where id=1;
select age from stud;
select grade from stud;



create table teacher(
	id_teacher int not null primary key,
	name_teacher varchar(30),
	foreign key (id_teacher) references stud(id)
);
insert into teacher(id_teacher,name_teacher) values
     (1,'Indira'),
     (2,'Madina');
select * from teacher;