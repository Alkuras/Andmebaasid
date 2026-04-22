USE Melikovbaas;
--tabel category
create table category(
categoryID int Primary Key identity(1,1),
categoryName varchar(30) unique);
--tabel product
create table produce(
productid int PRIMARY KEY identity(1,1),
productname varchar(30) unique,
categoryid int not null,
FOREIGN KEY (categoryid) REFERENCES category(categoryID),
price money);
--tabel sale
create table sale(
saleid int primary key identity (1,1),
productid int not null,
foreign key (productid) references produce(productid),
idcustomer varchar(3),
quantity int CHECK (quantity>0),
saledate date not null);
--tabeli muutmised
ALTER TABLE sale ALTER COLUMN idcustomer int;
ALTER TABLE sale ADD units varchar(3) ;
--tabel customer
create table customer(
idcustomer int primary key identity(1,1),
cusomername varchar(30) unique,
contact varchar(30))
--lisame seose
ALTER TABLE sale ADD CONSTRAINT fk_customer
FOREIGN KEY (idcustomer) REFERENCES customer(idcustomer);
--kuvame tabeleid
select * from category
select * from customer
select * from sale
select * from produce
--täidame tabeli
insert into category
values('dairy'),('grain'),('meat');

insert into customer
values ('Andi_Uhle','uhleandi@gmail.com'),('Kaspar_Kiilaspää','kasparkaspar@gmail.com'),('Rico-Givy_Mustkivi','mustikas@gmail.com');

insert into produce
values ('milk',1,2),('oat',2,0.50),('lamb',3,5),('beef',3,4);

insert into sale 
values (3,2,20,'2026-10-04','kg'),(1,3,5,'2026-5-03','l'),(2,1,10,'2026-8-04','kg')
