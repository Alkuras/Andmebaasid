## SQL protseduur - 
store procedure - salvestatud protseduurid - sama mis on funktsioonid programmerimises, mingi tegevus mis on salvestatud andmebaasi ja mida saab automaatselt teha (INSERT, UPDATE, SELECT, UPDATE).

<img width="249" height="181" alt="{2D6B6198-D9B4-4191-A4BC-28FC9C5E92EA}" src="https://github.com/user-attachments/assets/8fdb84c0-6ff2-4c43-8236-7acbd581e911" />


```sql
CREATE PROCEDURE lisaKategooria
--parameetrid @...
@uusKategooria varchar(30)
AS
BEGIN
--kirjeldus
	INSERT INTO category
	VALUES (@uusKategooria);
	SELECT * FROM category;
END
```
<img width="359" height="177" alt="{5B5FEE8C-B7C6-4A66-8393-33F0DCD77917}" src="https://github.com/user-attachments/assets/725b3ac7-ae2b-43f4-9bc8-674b82a8f894" />


```sql
--protseduur, mis kustutab kategooria id järgi
create procedure kustutaKategooria
@kustutaId int
as
begin
	select * from category;
	delete from category where categoryID=@kustutaId;
	select * from category;
end

```
<img width="305" height="356" alt="{F5736A5D-1CA5-492B-846B-6CEDC7841886}" src="https://github.com/user-attachments/assets/39345f98-5ef2-48f7-95f7-3c54082a015b" />


```sql
--protseduur, mis kuvab kategooriad sisestatud esimese tähe järgi
create procedure otsing1taht
@taht char(1)
as
begin
	select * from category
	where categoryName like @taht + '%'; --% - teised sümboolid
end
```
<img width="271" height="154" alt="{4B9E569E-817D-464D-B213-75668F82A63E}" src="https://github.com/user-attachments/assets/edecd739-2572-436b-ac3b-8cc3a8c7de05" />
