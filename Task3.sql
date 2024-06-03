--Exercise 1: Sales Analysis
create table customers(
	customer_id int primary key,
	customer_firstname varchar(50),
	customer_surname varchar(50),
	customer_email varchar(50)
);
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (1, 'Karlen', 'Bembrigg', 'kbembrigg0@mysql.com');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (2, 'Arly', 'Swinnard', 'aswinnard1@shop-pro.jp');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (3, 'Chaddie', 'McCrae', 'cmccrae2@alibaba.com');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (4, 'Tymothy', 'Fooks', 'tfooks3@wp.com');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (5, 'Shellysheldon', 'Coskerry', 'scoskerry4@google.nl');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (6, 'Ninnette', 'Semens', 'nsemens5@virginia.edu');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (7, 'Norry', 'Burne', 'nburne6@gravatar.com');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (8, 'Lorianne', 'Bims', 'lbims7@reuters.com');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (9, 'Ancell', 'Bedbrough', 'abedbrough8@wikimedia.org');
insert into customers (customer_id, customer_firstname, customer_surname, customer_email) values (10, 'Pandora', 'Caddan', 'pcaddan9@feedburner.com');


create table employees(
	employee_id int primary key,
	employee_firstname varchar(50),
	employee_surname varchar(50),
	employee_position varchar(50)
);
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (1, 'Ilaire', 'Chadwell', 'ichadwell0@bbc.co.uk');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (2, 'Christie', 'Vidgen', 'cvidgen1@umich.edu');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (3, 'Larissa', 'Worner', 'lworner2@joomla.org');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (4, 'Audrie', 'Tumbridge', 'atumbridge3@cafepress.com');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (5, 'Nicholle', 'Pepperrall', 'npepperrall4@va.gov');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (6, 'Patience', 'Van Dalen', 'pvandalen5@stumbleupon.com');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (7, 'Kirk', 'Rendle', 'krendle6@exblog.jp');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (8, 'Kristian', 'Carthy', 'kcarthy7@stanford.edu');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (9, 'Blanche', 'Puden', 'bpuden8@ask.com');
insert into employees (employee_id, employee_firstname, employee_surname, employee_position) values (10, 'Danila', 'Aleavy', 'daleavy9@sakura.ne.jp');


create table orders(
	order_id int primary key,
	order_date date,
	customer_id int,
	employee_id int ,
	foreign key (customer_id) references customers(customer_id),
	foreign key (employee_id) references employees(employee_id)
);
insert into orders (order_id, order_date, customer_id, employee_id) values (1, '2023/04/30', 1, 1);
insert into orders (order_id, order_date, customer_id, employee_id) values (2, '2022/11/30', 2, 2);
insert into orders (order_id, order_date, customer_id, employee_id) values (3, '2023/02/06', 3, 3);
insert into orders (order_id, order_date, customer_id, employee_id) values (4, '2023/09/20', 4, 4);
insert into orders (order_id, order_date, customer_id, employee_id) values (5, '2023/01/16', 5, 5);
insert into orders (order_id, order_date, customer_id, employee_id) values (6, '2023/04/05', 6, 6);
insert into orders (order_id, order_date, customer_id, employee_id) values (7, '2022/12/01', 7, 7);
insert into orders (order_id, order_date, customer_id, employee_id) values (8, '2023/06/12', 8, 8);
insert into orders (order_id, order_date, customer_id, employee_id) values (9, '2022/12/05', 9, 9);
insert into orders (order_id, order_date, customer_id, employee_id) values (10, '2023/03/29', 10, 10);


create table orderDetails(
	orderDetail_id int primary key,
	quantity int,
	price decimal(10,2),
	order_id int,
	product_id int,
	foreign key(order_id) references orders(order_id),
	foreign key(product_id) references products(product_id)
);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (1, 333, 6201.55, 1, 1);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (2, 547, 8035.14, 2, 2);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (3, 170, 6173.11, 3, 3);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (4, 2169, 3691.12, 4, 4);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (5, 71, 7419.36, 5, 5);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (6, 19, 5762.72, 6, 6);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (7, 1, 7834.35, 7, 7);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (8, 16, 8921.53, 8, 8);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (9, 444, 1522.36, 9, 9);
insert into orderDetails (orderDetail_id, quantity, price, order_id, product_id) values (10, 235,7579.93, 10, 10);

create table products(
	product_id int primary key, 
	product_name varchar(100),
	product_manufactured varchar(100),
	category_id int,
	foreign key(category_id) references categorys(category_id)
);
insert into products (product_id, product_name, product_manufactured, category_id) values (1, 'Corn Muffaletta', 'China', 1);
insert into products (product_id, product_name, product_manufactured, category_id) values (2, 'Breast, Smoked', 'China', 2);
insert into products (product_id, product_name, product_manufactured, category_id) values (3, 'Compound Coating', 'Guatemala', 3);
insert into products (product_id, product_name, product_manufactured, category_id) values (4, 'Ground', 'Indonesia', 4);
insert into products (product_id, product_name, product_manufactured, category_id) values (5, 'White Chocolate', 'China', 5);
insert into products (product_id, product_name, product_manufactured, category_id) values (6, 'Wine - Cousino Macul Antiguas', 'Poland', 6);
insert into products (product_id, product_name, product_manufactured, category_id) values (7, 'Campbells Mexicali Tortilla', 'Cuba', 7);
insert into products (product_id, product_name, product_manufactured, category_id) values (8, 'Roasted Red Pepper', 'Thailand', 8);
insert into products (product_id, product_name, product_manufactured, category_id) values (9, 'Cookie Crumbs', 'Indonesia', 9);
insert into products (product_id, product_name, product_manufactured, category_id) values (10, 'Halibut, Cold Smoked', 'Croatia', 10);

create table categorys(
	category_id int primary key,
	category_name varchar(100)
);
insert into categorys (category_id, category_name) values (1, 'Bread');
insert into categorys (category_id, category_name) values (2, 'Turkey');
insert into categorys (category_id, category_name) values (3, 'Chocolate');
insert into categorys (category_id, category_name) values (4, 'Sage');
insert into categorys (category_id, category_name) values (5, 'TTruffle Shells');
insert into categorys (category_id, category_name) values (6, 'Wine');
insert into categorys (category_id, category_name) values (7, 'JSoup');
insert into categorys (category_id, category_name) values (8, 'Sauce');
insert into categorys (category_id, category_name) values (9, 'Shortbread');
insert into categorys (category_id, category_name) values (10, 'Fish');




create table shippers(
	shippers_id int primary key,
	shipper_phone int,
	shipper_address varchar(50),
	shippers_name varchar(50)
); 
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (1, 'Rath LLC',87957388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (2, 'Parker-Toy',87955388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (3, 'Berge LLC',87957388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (4, 'Beier, Rutherford and Bednar',87957388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (5, 'Reichel, Spinka and Friesen',87957388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (6, 'Gulgowski, Rowe and Jacobi',87957384170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (7, 'Bruen and Sons',87957388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (8, 'Kerluke-Dicki',87957388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (9, 'Williamson, Flatley and Lind',87957388170,'Kaskelen');
insert into shippers (shippers_id, shippers_name,shipper_phone,shipper_address) values (10, 'Kreiger-Swift',87957388170,'Kaskelen');


--1
select categorys.category_name, sum(orderDetails.quantity * orderDetails.price) as total_revenue
from categorys inner join products on categorys.category_id=products.category_id 
inner join orderDetails on orderDetails.product_id=products.product_id
group by categorys.category_name;

--2

select customers.customer_firstname, customers.customer_surname, sum(orderDetails.quantity*orderDetails.price) as total_amount
from customers inner join orders on customers.customer_id=orders.customer_id
inner join orderDetails on orders.order_id=orderDetails.order_id
group by customers.customer_firstname,customers.customer_surname
order by total_amount desc limit 5;


--3

select employees.employee_firstname, employees.employee_surname, sum(orderDetails.quantity*orderDetails.price) as total_sales
from employees inner join orders on employees.employee_id=orders.employee_id
inner join orderDetails on orders.order_id=orderDetails.order_id 
group by employees.employee_firstname, employees.employee_surname
order by total_sales desc;

--4

select products.product_id,products.product_name, max(orderDetails.quantity) as total_quantity
from products inner join orderDetails on products.product_id=orderDetails.product_id
group by products.product_id,products.product_name
order by total_quantity desc limit 1;



--Exercise 2: HR Analytics
create table employeess(
	employee_id int primary key,
	employee_firstname varchar(50),
	employee_surname varchar(50),
	job_id int,
	salarie_id int,
	manager_id int,
	department_id int,
	foreign key(department_id) references departments(department_id),
	foreign key(job_id) references jobs(job_id),
	foreign key(manager_id) references managers(manager_id),
	foreign key(salarie_id) references salaries(salarie_id)
	
);


insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (1, 'Leonerd', 'Pleavin', 4, 4, 2, 2);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (2, 'Bendite', 'Whistlecroft', 3, 4, 3, 1);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (3, 'Beniamino', 'Harold', 1, 2, 1, 3);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (4, 'Zuzana', 'Waadenburg', 1, 1, 1, 4);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (5, 'Cammie', 'Halloran', 1, 1, 5, 3);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (6, 'Heath', 'Juorio', 1, 1, 5, 1);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (7, 'Hendrick', 'Massenhove', 4, 4, 5, 2);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (8, 'Nap', 'Tolomio', 3, 2, 1, 1);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (9, 'Lexis', 'Patriskson', 3, 4, 3, 3);
insert into employeess (employee_id, employee_firstname, employee_surname, job_id, salarie_id, manager_id, department_id) values (10, 'Roxanna', 'Bennellick', 3, 2, 1, 2);



create table departments(
	department_id int primary key,
	department_name varchar(50)
);
insert into departments (department_id, department_name) values (1, 'Engi');
insert into departments (department_id, department_name) values (2, 'Legal');
insert into departments (department_id, department_name) values (3, 'Engineering');
insert into departments (department_id, department_name) values (4, 'Support');
update departments set department_name='Engi' where department_id=1;


create table jobs(
	job_id int primary key,
	job_history varchar(100),
	job_name varchar(100)
);
insert into jobs (job_id, job_name,job_history) values (1, 'Editor','changed jobs');
insert into jobs (job_id, job_name,job_history) values (2, 'Editor',' changed jobs');
insert into jobs (job_id, job_name,job_history) values (3, 'Accounting Assistant II',' changed jobs');
insert into jobs (job_id, job_name,job_history) values (4, 'Help Desk Operator','changed jobs');
--insert into jobs (job_id, job_name,job_history) values (5, 'Nurse',' not сhanged jobs');
--insert into jobs (job_id, job_name,job_history) values (6, 'General Manager','сhanged jobs');
--insert into jobs (job_id, job_name,job_history) values (7, 'Web Developer I','сhanged jobs');
--insert into jobs (job_id, job_name,job_history) values (8, 'Analyst Programmer',' notсhanged jobs');
--insert into jobs (job_id, job_name,job_history) values (9, 'Senior Sales Associate',' not сhanged jobs');
--insert into jobs (job_id, job_name,job_history) values (10, 'Professor','not сhanged jobs');
update jobs set job_history='not сhanged jobs' where job_id=1;



create table salaries(
	salarie_id int primary key,
	salaire decimal(10,2)
);
insert into salaries (salarie_id, salaire) values (1, 83574.31);
insert into salaries (salarie_id, salaire) values (2, 54529.01);
insert into salaries (salarie_id, salaire) values (3, 87450.48);
insert into salaries (salarie_id, salaire) values (4, 68324.85);

create table managers(
	manager_id int primary key,
	manager_name varchar(50)
);
insert into managers (manager_id, manager_name) values (1, 'Ruben');
insert into managers (manager_id, manager_name) values (2, 'Reg');
insert into managers (manager_id, manager_name) values (3, 'Bran');
insert into managers (manager_id, manager_name) values (4, 'Isidoro');
insert into managers (manager_id, manager_name) values (5, 'Ewen');

create table locations(
	location_id int primary key,
	location_name varchar(100)
);
insert into locations (location_id, location_name) values (1, 'Palkovice');
insert into locations (location_id, location_name) values (2, 'Nerchinsk');
insert into locations (location_id, location_name) values (3, 'Zhangzhu');
insert into locations (location_id, location_name) values (4, 'Chodów');
insert into locations (location_id, location_name) values (5, 'Xiaba');
insert into locations (location_id, location_name) values (6, 'Jesús María');
insert into locations (location_id, location_name) values (7, 'Karantaba');
insert into locations (location_id, location_name) values (8, 'Otoka');
insert into locations (location_id, location_name) values (9, 'Buenavista');
insert into locations (location_id, location_name) values (10, 'Nyachera');

create table countries(
	countrie_id int primary key,
	countries_name varchar(100)
); 
insert into countries (countrie_id, countries_name) values (1, 'China');
insert into countries (countrie_id, countries_name) values (2, 'Denmark');
insert into countries (countrie_id, countries_name) values (3, 'Philippines');
insert into countries (countrie_id, countries_name) values (4, 'Nigeria');
insert into countries (countrie_id, countries_name) values (5, 'Sweden');
insert into countries (countrie_id, countries_name) values (6, 'France');
insert into countries (countrie_id, countries_name) values (7, 'China');
insert into countries (countrie_id, countries_name) values (8, 'United States');
insert into countries (countrie_id, countries_name) values (9, 'Indonesia');
insert into countries (countrie_id, countries_name) values (10, 'Thailand');

--1

select employeess.employee_id,employeess.employee_firstname,employeess.employee_surname
from employeess where employeess.job_id in(
	select jobs.job_id from jobs where jobs.job_history not like('%changed jobs%')
);

--2
select departments.department_id, departments.department_name,round(avg(salaire),3) as avg_salary
from departments left join employeess on employeess.employee_id=departments.department_id
left join salaries on salaries.salarie_id=employeess.salarie_id
group by departments.department_id, departments.department_name
order by departments.department_id;


--3

select employeess.employee_firstname,employeess.employee_surname, count(DISTINCT managers.manager_id) as total_manager
from employeess inner join managers on employeess.manager_id=managers.manager_id 
group by employeess.employee_firstname,employeess.employee_surname
order by total_manager limit 1;

--4

select employeess.employee_firstname,employeess.employee_surname, salaries.salaire,jobs.job_name, count(jobs.job_id) as total_job
from jobs inner join employeess on jobs.job_id=employeess.job_id inner join salaries on employeess.salarie_id=salaries.salarie_id
inner join departments on departments.department_id=employeess.department_id
group by employeess.employee_firstname,employeess.employee_surname,salaries.salaire,jobs.job_name;





SELECT e1.employee_id, e1.employee_firstname, e1.employee_surname, e1.job_id, e1.department_id, s1.salaire
FROM employeess e1
inner JOIN salaries s1 ON e1.salarie_id = s1.salarie_id
WHERE (e1.job_id, e1.department_id, s1.salaire) IN (
    SELECT e2.job_id, e2.department_id, s2.salaire
    FROM employeess e2
    JOIN salaries s2 ON e2.salarie_id != s2.salarie_id
    GROUP BY e2.job_id, e2.department_id, s2.salaire
    order by e1.job_id
);
