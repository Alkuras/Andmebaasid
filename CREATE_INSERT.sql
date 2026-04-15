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
