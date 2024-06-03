create table customers
(
    customer_id int primary key ,
    customer_name text,
    email text,
    phone text,
    address text
);
insert into customers (customer_id, customer_name, email, phone, address) values
 (1, 'Vinny', 'vioannou0@ted.com', '602-803-4460', 'Room 1375'),
 (2, 'Paulita', 'pritch1@google.nl', '682-339-8194', 'PO Box 43576'),
 (3, 'Paddy', 'pquarrie2@fda.gov', '673-576-9186', 'Suite 14'),
 (4, 'Ole', 'opriddey3@acquirethisname.com', '785-620-2004', 'PO Box 23896'),
 (5, 'Michal', 'mduro4@berkeley.edu', '561-202-4802', 'PO Box 6694'),
 (6, 'Harlie', 'hnisius5@deviantart.com', '402-195-4385', 'Suite 40'),
 (7, 'Allsun', 'ataw6@japanpost.jp', '630-201-2392', 'Suite 26'),
 (8, 'Vincenty', 'vpury7@naver.com', '589-594-3045', 'Suite 97'),
 (9, 'Celene', 'clopez8@flavors.me', '275-685-4519', 'Apt 1845'),
 (10, 'Jarred', 'jranger9@cisco.com', '825-798-5592', 'Room 750');

create table orders(
    order_id int primary key ,
    customer_id int ,
    order_date date,
    total_amount numeric,
    foreign key (customer_id) references customers(customer_id)
);

insert into orders(order_id, customer_id, order_date, total_amount) values
(1, 1, '2023-09-17', 3737),
(2, 3, '2023-04-17', 1095),
(3, 4, '2023-08-06', 3359),
(4, 2, '2022-11-12', 8937),
(5, 4, '2023-02-02', 9318),
(6, 7, '2022-11-18', 8016),
(7, 8, '2022-11-10', 4182),
(8, 2, '2023-02-28', 5572),
(9, 10, '2023-10-08', 6400),
(10, 9, '2023-08-28', 3104);



create table order_items(
    order_item_id int primary key ,
    order_id int ,
    product_id int ,
    quantity int ,
    unit_price numeric,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);
insert into order_items (order_item_id, order_id, product_id, quantity, unit_price) values
(1, 1, 2, 8281, 2767.42),
(2, 2, 3, 5065, 19815.95),
(3, 3, 1, 1154, 19270.92),
(4, 4, 6, 6842, 15656.23),
(5, 5, 7, 3394, 17475.51),
(6, 6, 6, 1379, 45479.38),
(7, 7, 8, 3739, 21018.26),
(8, 8, 8, 4900, 16714.86),
(9, 9, 9, 7690, 7881.3),
(10, 10, 7, 5756, 53094.75);

create table products(
    product_id int primary key ,
    product_name text ,
    category_id int,
    description text,
    foreign key (category_id) references categories(category_id)
);
INSERT INTO products (product_id, product_name, category_id, description)
VALUES
    (1, 'Product 1', 1, 'Description for Product 1'),
    (2, 'Product 2', 2, 'Description for Product 2'),
    (3, 'Product 3', 3, 'Description for Product 3'),
    (4, 'Product 4', 4, 'Description for Product 4'),
    (5, 'Product 5', 1, 'Description for Product 5'),
    (6, 'Product 6', 2, 'Description for Product 6'),
    (7, 'Product 7', 3, 'Description for Product 7'),
    (8, 'Product 8', 4, 'Description for Product 8'),
    (9, 'Product 9', 1, 'Description for Product 9'),
    (10, 'Product 10', 2, 'Description for Product 10');


create table categories(
    category_id int primary key ,
    category_name text
);
INSERT INTO categories (category_id, category_name)
VALUES
    (1, 'Категория 1'),
    (2, 'Категория 2'),
    (3, 'Категория 3'),
    (4, 'Категория 4');


--Exercise 1: Indexing
--a
create index customer_id_ind on customers(customer_id);
--b
create  index index_id on order_items(order_id,product_id);
--c
create index date_index on orders(order_date);


--Exercise 2:Views 
--a

create view order_summary as
select o.order_id,c.customer_name,o.order_date, o.total_amount, sum(oi.quantity) as total_quantity
from Customers as c inner join Orders as o on c.customer_id=o.customer_id
inner join order_items as oi on oi.order_id=o.order_id
group by  o.order_id,c.customer_name,o.order_date, o.total_amount
order by o.order_id;


select * from order_summary;


--b

create view product_sales as 
select p.product_id, p.product_name, c.category_name, sum(oi.quantity*oi.unit_price) as total_revenue
from categories as c inner join products as p on c.category_id=p.product_id
inner join order_items as oi on oi.product_id=p.product_id
group by p.product_id, p.product_name, c.category_id ;

select * from product_sales;

--Exercise 3: Query Optimization
select customer_id, customer_name from customers
where customer_id=(select customer_id from orders
group by customer_id
order by count(order_id) desc limit 1);


select product_id,product_name from products
where product_id=(product_id from order_items
group by product_id
order by count(quantity) desc limit 1);


select product_id,product_name from products
where product_id=(product_id from order_items
group by product_id
order by sum(quantity*unit_price) desc limit 1 );


select customer_id,customer_name, (select sum(o.total_amount) from orders as o where o.order_id=c.customer_id) as total_revenue
from customers as c 
where customer_id=(select customer_id from orders	
				   group by customer_id 
				   order by count(order_id) desc limit 1 );
				   
select customer_id, sum(o.total_amount)  as total_revenue
from orders as o
where customer_id=(select customer_id from orders	
				   group by customer_id 
				   order by count(order_id) desc limit 1)
group by customer_id;	



-- The total revenue generated by the customer with the most orders.
select B.customer_id , B.customer_name ,(select sum(total_amount) 
           from orders where B.customer_id = customer_id group by customer_id ) from
(select A.customer_id ,(select customer_name from customers where customer_id = A.customer_id )
 ,count(A.customer_id) as times
 from orders A group by customer_id order by times desc limit 1

) B ;



