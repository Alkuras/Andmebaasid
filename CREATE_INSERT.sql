Create Database Melikovbaas;

--ab kustutamine
DROP Database ShopDB;

USE Melikovbaas;
Create Table tootaja(
tootajaID int Primary Key identity(1,1), -- identity - automaatsekt kasvav arv +1
eesnimi varchar (15) not null,
perenimi varchar (30) not null,
synniaeg date,
aadress Text,
koormus int CHECK (koormus>0), -- piirang, et kormus rohkem kui 0
aktiivne bit )

--tabeli kuvamine 
Select * From tootaja;

--andmete lisamine tabelisse
Insert INTO tootaja(perenimi, eesnimi, synniaeg)
VALUES ('ILus','Liis','2002-12-4')

Insert INTO tootaja
VALUES ('Ralf','Eha','2001-7-19','Võru',110,1)

--andmete uuendamine tabelis
UPDATE tootaja SET aadress='Tallinn', koormus=10, aktiivne=1
WHERE tootajaID=1;

--teine tabel
CREATE TABLE toovahtus(
toovahetusID int PRIMARY KEY identity(1,1),
kuupaev date,
tundideArv int , 
tootajaID int,
FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID))

select * from toovahtus;
select * from tootaja;
select * from koolitus;
select * from opetamine;

--täidame tabeli
INSERT INTO toovahtus
Values ('2026-04-14',8,6)

CREATE TABLE koolitus(
koolitusID int PRIMARY KEY identity(1,1),
nimetus varchar (15) not null,
kestuvus int,
algus date,
lopp date,
õpetaja varchar (30))
Create Table opetamine(
opetamineID int PRIMARY KEY identity(1,1),
tootajaID int,
FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID),
koolitusID int,
FOREIGN KEY (koolitusID) REFERENCES koolitus(koolitusID),
tunnistus bit,
hinne int CHECK(hinne<6) not null)

INSERT INTO koolitus
Values ('Meta',7,'2026-5-1','2026-5-8','')
Insert into opetamine
Values (6,11,1,3)
