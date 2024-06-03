--Exercise 1: Multiple Sorting Criteria
create table sales(
  product_id int not null,
  sale_date date not null,
	revenue int not null
);
insert into sales(product_id,sale_date,revenue) values
(001,'2023-09-30',1000),
(002,'2023-10-18',2000),
(003,'2023-10-18',2300),
(004,'2022-02-08',1200),
(005,'2021-03-01',8777),
(006,'2022-12-08',1880);


select product_id, sum(revenue) as total_rev,max(sale_date) as total_date from
sales group by product_id order by total_rev desc, total_date desc limit 5;


--Exercise 2: Grouping and Averaging
create table employee_salary(
employee_id int not null,
department_id int not null,
salary int
);
insert into employee_salary(employee_id,department_id,salary) values
(1,1001,12000),
(2,1001,12344),
(3,1201,13399),
(4,1101,12000),
(5,1301,14555),
(6,1301,18955);
select department_id,round(avg(salary),2) as avg_salary from employee_salary
group by department_id order by avg_salary desc;

--Exercise 3: Monthly Sales Trends 
create table monthly_sales(
	year int not null check(year<=2024),
	month int not null check(month<=12),
	region varchar(50),
	total_sales int not null
);
insert into monthly_sales(year,month,region,total_sales) values
(2022,12,'Орал',1200000),
(2022,11,'Алматы',1000000),
(2022,11,'Астана',3900000),
(2022,11,'Астана',1233533);

select year,month,region,sum(total_sales) as total_sales from 
monthly_sales group by year,month,region order by year ,month;


--Exercise 4: Inner Join with Aggregation
create table employees(
	employee_id int primary key,
	salary int not null
);
insert into employees (employee_id, salary) values (1, 1775261);
insert into employees (employee_id, salary) values (2, 675725);
insert into employees (employee_id, salary) values (3, 2522171);
insert into employees (employee_id, salary) values (4, 479159);
insert into employees (employee_id, salary) values (5, 2573471);
insert into employees (employee_id, salary) values (6, 396680);
insert into employees (employee_id, salary) values (7, 2433943);
insert into employees (employee_id, salary) values (8, 996929);
insert into employees (employee_id, salary) values (9, 150271);
insert into employees (employee_id, salary) values (10, 1257039);

create table departments(
	department_id int primary key,
	department_name varchar(50),
	foreign key (department_id) references employees(employee_id)
);
insert into departments (department_id, department_name) values (1, 'Edgeblab');
insert into departments (department_id, department_name) values (2, 'Edgeblab');
insert into departments (department_id, department_name) values (3, 'Livefish');
insert into departments (department_id, department_name) values (4, 'Feedspan');
insert into departments (department_id, department_name) values (5, 'Jabbersphere');
insert into departments (department_id, department_name) values (6, 'Roodel');
insert into departments (department_id, department_name) values (7, 'Kazu');
insert into departments (department_id, department_name) values (8, 'Eamia');
insert into departments (department_id, department_name) values (9, 'Pixonyx');
insert into departments (department_id, department_name) values (10, 'Snaptags');

select  departments.department_name, round(avg(salary),2) as avg_salary
from employees inner join departments on employees.employee_id=departments.department_id 
group by department_name order by avg_salary desc ;


--Exercise 5: Left Join with Conditional Filtering
create table customers(
	customer_id int primary key,
	customer_name varchar(50)
);
insert into customers (customer_id, customer_name) values (1, 'TestGare');
insert into customers (customer_id, customer_name) values (2, 'Dareen');
insert into customers (customer_id, customer_name) values (3, 'Reginald');
insert into customers (customer_id, customer_name) values (4, 'Dareen');
insert into customers (customer_id, customer_name) values (5, 'TestScottie');
insert into customers (customer_id, customer_name) values (6, 'Rhiamon');
insert into customers (customer_id, customer_name) values (7, 'Hermie');
insert into customers (customer_id, customer_name) values (8, 'Jeffrey');
insert into customers (customer_id, customer_name) values (9, 'Daffy');
insert into customers (customer_id, customer_name) values (10, 'Sarette');


create table orders(
	order_id int primary key,
	order_date date,
	foreign key(order_id) references customers(customer_id)
);
insert into orders (order_id, order_date) values (1, '10/12/2022');
insert into orders (order_id, order_date) values (2, '2/09/2023');
insert into orders (order_id, order_date) values (3, '7/08/2023');
insert into orders (order_id, order_date) values (4, '12/12/2022');
insert into orders (order_id, order_date) values (5, '8/06/2022');
insert into orders (order_id, order_date) values (6, '7/10/2023');
insert into orders (order_id, order_date) values (7, '6/04/2023');
insert into orders (order_id, order_date) values (8, '9/12/2022');
insert into orders (order_id, order_date) values (9, '5/03/2023');
insert into orders (order_id, order_date) values (10, '3/01/2023');

select customers.customer_name, count(orders.order_id) as order_count
from customers left join orders on customers.customer_id=orders.order_id
where customers.customer_name not like 'Test%'
group by customers.customer_name order by  customers.customer_name;
