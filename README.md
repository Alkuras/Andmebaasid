## Andmebaasid
andmebaaside haldusega seotud sql kood ja konspektid

## Põhimõisted
- Andmebaasi haldussüsteemid - tarkvara, millega abil saab luua andmebaas (mariaDB - XAMPP, SQL Server - SQL Server Management Studio (Server name - (localdb)\MSSQLLocalDB))
- Andmebaas - struktureeritud andmete kogum
- Tabel - olem - сущности
- Veerg - väli - поле
- Rida - kirje - запись
- Primaarne võti - primary key - PK - veerg, unikaalse identifikatooriga (tavaliselt nimetakse id)
- Välisvõti (võõrvõti) - foreign key - FK - veerg, mis loob seose teise tabeli primaarne võtmega
## SQL - structured query language - struktureeritud päringu keel
- päring - запрос
<img width="427" height="339" alt="pilt" src="https://github.com/user-attachments/assets/e7a5f981-4cf4-47af-bc3c-8734df3cbe36" />
1. DDL - datat definition language
2. DML - data manipulation language
   
## Piirangud - constraint (5)
1. Primary key
2. NOT NULL
3. CHECK - valik
4. Unique
5. Foreign key
## Andmetübid
```
1. int, smallint, decimal(5,2) - numbrilised
2. varchar(30), char(5), TEXT - tekst/sümbolised
3. date, time, datetime, kuupäeva
4. booleam,bit,bool - logilised
```
