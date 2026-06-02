create database trigerlogitpv24
use trigerlogitpv24

--1. tabel kuhu sekretaar lisab andmed

Create table linnad(
linnID int PRIMARY KEY IDENTITY (1,1),
linnanimi varchar(15) NOT NULL unique,
rahvaarv int);
--2. tabel kus automaatselt salvestatakse 1. tabeli muudatused

Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kuupaev DATETIME,
kasutaja varchar(30),
toiming  varchar(100),
andmed TEXT
)
drop table logi
select * from linnad
select * from logi

insert into linnad
values('Tartu ', 15723)

--Trigger lisatud kirjeid jälgimiseks tabelis “linnad” – INSERT
--Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi

	
CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud INSERT käsk',  --toiming
concat('linn:',inserted.linnanimi, ' rahvaarv: ', inserted.rahvaarv)  --andmed
FROM inserted;

--Delete triger
CREATE TRIGGER linnaKustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud Delete käsk',  --toiming
concat('linn:',deleted.linnanimi, ' rahvaarv: ', deleted.rahvaarv)  --andmed
FROM deleted;

--drop triger...
disable trigger linnakustutamine on linnad;
enable trigger linnakustutamine on linnad;

--delete trigeri kontroll
delete from linnad where linnID=6;
select * from linnad
select * from logi

--Kombineetime insert ja delete trigerid


CREATE TRIGGER linnaLisaKustuta
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT, Delete
AS
begin
set nocount on;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud INSERT käsk',  --toiming
	concat('linn:',inserted.linnanimi, ' rahvaarv: ', inserted.rahvaarv)  --andmed
	FROM inserted

	union all

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud Delete käsk',  --toiming
	concat('linn:',deleted.linnanimi, ' rahvaarv: ', deleted.rahvaarv)  --andmed
	FROM deleted;
end;


select * from linnad
select * from logi


--update triger 
CREATE TRIGGER linnaUuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR update
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud Update käsk',  --toiming
concat('vanad andmed - linn:',deleted.linnanimi, ' rahvaarv: ', deleted.rahvaarv,
' uued andmed - linn: ', inserted.linnanimi, ', rahvaarv -', inserted.rahvaarv)  --andmed
FROM deleted inner join inserted on deleted.linnID=inserted.linnID;

--update kontroll 
update linnad set linnanimi='Tapa1', rahvaarv=0 where linnanimi='Tapa'


select * from linnad
select * from logi

--kasutaja sekretaarNatalja, parool 12345
--Õigused - sekretatNatalja ei saa luua ehk muuta trigeri, ei näe tabeli logi,
--saab ainult näha, lisada, ja kustutada tabelist linnad 

grant select, insert, delete, update on linnad to sekretarNatalja;
deny select, delete on logi to sekretarNatalja; 

exec sp_helptext 'linnaUuendamine'


--loome tabeli
Create table arvestustoo(
ID int PRIMARY KEY IDENTITY (1,1),
nimetus varchar(15) NOT NULL unique,
kirjeldus varchar(200),
kuupaev date,
punktid int CHECK(punktid<101) not null);


--teeb kirjed logi tabelis kui tabelis arvestustoo lisakse andmed
CREATE TRIGGER toolisamine
ON arvestustoo --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud INSERT käsk',  --toiming
concat('nimetus: ',inserted.nimetus, ' punktid: ', inserted.punktid)  --andmed
FROM inserted;

--teeb kirjed logi tabelis kui tabelis arvestustoo kustutakse andmed
CREATE TRIGGER tooKustutamine
ON arvestustoo --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud Delete käsk',  --toiming
concat('nimetus:',deleted.nimetus, ' punktid: ', deleted.punktid)  --andmed
FROM deleted;

--teeb kirjed logi tabelis kui tabelis arvestustoo uuendakse andmed
CREATE TRIGGER tooUuendamine
ON arvestustoo --tabelinimi, mis on vaja jälgida
FOR update
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud Update käsk',  --toiming
concat('vanad andmed - nimetus:',deleted.nimetus, ' punktid: ', deleted.punktid,
' uued andmed - nimetus: ', inserted.nimetus, ', punktid -', inserted.punktid)  --andmed
FROM deleted inner join inserted on deleted.ID=inserted.ID;
--lülitame kaks trigeri välja
disable trigger tookustutamine on arvestustoo;
disable trigger toolisamine on arvestustoo;

--trigeri testid
insert into arvestustoo
values('Trigerid','Trigeri loomine ja kasutamine SQL serveris','2026-6-2',100)

update arvestustoo set kuupaev='2026-6-3' where nimetus='Trigerid'
delete from arvestustoo where ID=1

select * from logi

--ühine triger lisamiseks ja kustutamiseks, mis teeb kirjed logi tableis kui arvestustoo tabelis andmed lisakse või kustutakse
CREATE TRIGGER tooLisaKustuta
ON arvestustoo --tabelinimi, mis on vaja jälgida
FOR INSERT, Delete
AS
begin
set nocount on;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud INSERT käsk',  --toiming
	concat('nimetus: ',inserted.nimetus, ', punktid: ', inserted.punktid)  --andmed
	FROM inserted

	union all

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud Delete käsk',  --toiming
	concat('nimetus:',deleted.nimetus, ', punktid: ', deleted.punktid)  --andmed
	FROM deleted;
end;

--trigeri testid
insert into arvestustoo
values('Trigerid','Trigeri loomine ja kasutamine SQL serveris','2026-6-2',100)

update arvestustoo set kuupaev='2026-6-3' where nimetus='Trigerid'
delete from arvestustoo where ID=2

select * from logi

 EXEC sp_helptext 'tooKustutamine'
 EXEC sp_helptext 'toolisamine'
 EXEC sp_helptext 'tooUuendamine'
 EXEC sp_helptext 'tooLisaKustuta'

