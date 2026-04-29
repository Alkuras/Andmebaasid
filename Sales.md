``` sql
create table category(
categoryID int Primary Key identity(1,1),
categoryName varchar(30) unique);
select * from category
```
<img width="189" height="79" alt="{53E1E10B-0773-4732-9D3A-8F278B13CD81}" src="https://github.com/user-attachments/assets/f0128d47-389e-425d-a404-8d7a664fe475" />

``` sql
create table brands(
brand_id int PRIMARY KEY identity(1,1),
brand_name varchar(20))
select * from brands
```
<img width="167" height="98" alt="{95D77987-0A95-4983-9DF3-E158B54F2928}" src="https://github.com/user-attachments/assets/9f94443b-c273-4a57-8bfb-eff871efb26d" />

``` sql
create table produce(
productid int PRIMARY KEY identity(1,1),
productname varchar(30) unique,
brand_id int,
FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
categoryid int not null,
FOREIGN KEY (categoryid) REFERENCES category(categoryID),
model_year varchar(4),
list_price money);
select * from produce
```
<img width="424" height="104" alt="{FC3BB92A-D811-4904-97FC-A5188AAC391B}" src="https://github.com/user-attachments/assets/451abd5b-9a99-4f52-b4ed-cdc76f488c3c" />

``` sql
create table stocks(
store_id int,
FOREIGN KEY (store_id) REFERENCES stores(store_id),
product_id int,
FOREIGN KEY (product_id) REFERENCES produce(productid),
quantity int)
select * from stocks
```
<img width="205" height="80" alt="{71C626AF-3558-4641-8C99-1CF774CAE607}" src="https://github.com/user-attachments/assets/ace71c26-e471-49cd-b316-c65eeb4ea61c" />

``` sql
create table customers(
customer_id int primary key identity(1,1),
first_name varchar(30),
last_name varchar(30),
phone int,
email varchar(30),
street varchar(30),
city varchar(20),
country varchar(20),
zip_code int)
select * from customers
```
<img width="682" height="81" alt="{1D70535A-3006-4C1F-9FBE-CA42BB545CF3}" src="https://github.com/user-attachments/assets/0a7ae7e1-33bf-4312-80b1-001e20ec9603" />

``` sql
create table stores(
store_id int primary key identity(1,1),
store_name varchar(30),
phone int,
email varchar(30),
street varchar(30),
city varchar(20),
country varchar(20),
zip_code int)
select * from stores
```
<img width="1526" height="80" alt="{0AA207C7-DD01-4418-854F-D6F7EAA93CD8}" src="https://github.com/user-attachments/assets/46ad73c1-1c23-4f3e-8564-33096074ac4f" />

``` sql
create table orders(
order_id int primary key identity(1,1),
customer_id int,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
order_status varchar(10),
order_dare date,
required_date date,
shipped_date date,
store_id int,
FOREIGN KEY (store_id) REFERENCES stores(store_id),
staff_id int,
FOREIGN KEY (staff_id) REFERENCES staffs(staff_id))
select * from orders
```
<img width="544" height="80" alt="{62B16AD9-DBF6-4643-AC0F-6B697E778E29}" src="https://github.com/user-attachments/assets/bc5fbf13-b675-4c74-ac1c-15c10d31c792" />


``` sql
create table order_items(
order_id int,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
item_id int primary key identity(1,1),
product_id int,
FOREIGN KEY (product_id) REFERENCES produce(productid),
quantity int,
list_price money,
discount varchar(3))
select * from order_items
```
<img width="370" height="80" alt="{1AE4932B-5D13-4B75-80F4-847CE054EADA}" src="https://github.com/user-attachments/assets/1e1fe7ea-1d01-467d-94d2-6c903ad51648" />


<img width="1410" height="774" alt="{931D9419-A69A-449F-998D-F843336C1201}" src="https://github.com/user-attachments/assets/55e79536-7b30-4fd7-a176-6d328968adc1" />

