use Analyst


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    mrp DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);



CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


create table orderitems(
order_item_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);




INSERT INTO customers VALUES
(1,'Aman','Pune'),
(2,'Rohit','Mumbai'),
(3,'TechMart','Delhi'),
(4,'OfficePlus','Bangalore');



INSERT INTO products VALUES
(101,'Laptop',60000,55000),
(102,'Mouse',500,400),
(103,'Keyboard',1500,1200),
(104,'Monitor',12000,10000);

INSERT INTO orders VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-01-12'),
(1003,3,'2024-01-15'),
(1004,4,'2024-01-20');

INSERT INTO orderitems VALUES
(1,1001,101,1),
(2,1001,102,2),
(3,1002,103,1),
(4,1003,101,5),
(5,1003,104,2),
(6,1004,102,20);



select * from customers;
select * from products;
select * from orders;
select * from orderitems;

-- Show all orders with customer name
select a.order_id,b.customer_name,a.order_date from orders a
join customers b on a.customer_id=b.customer_id;

-- Total revenue per order
select b.order_id,sum(a.selling_price * b.quantity) as total_amount from products 
a join orderitems b on  a.product_id=b.product_id
group by b.order_id;

-- MRP vs Selling for discount
select (a.mrp-a.selling_price) as discount from products a;

-- Total discount given per order

select a.order_id,sum((b.mrp-b.selling_price) * a.quantity) as discount from orderitems a 
join products b on a.product_id=b.product_id
group by a.order_id

-- reveneue by customer

select a.customer_id,a.customer_name,sum(c.quantity * d.selling_price) as reveneu from customers a
join orders b on a.customer_id=b.customer_id
join orderitems c on b.order_id=c.order_id
join products d on c.product_id=d.product_id
group by a.customer_id,a.customer_name
order by reveneu desc

-- Having   

select b.order_id,sum(a.selling_price * b.quantity) as total_amount from products 
a join orderitems b on  a.product_id=b.product_id
group by b.order_id
having b.order_id > 1001

-- customer with having

select * from customers a join orders b on a.customer_id=b.customer_id
join 



