create database reisidM
use reisidM

create table lennujaam(
LennujaamID int Primary Key identity(1,1),
LennujaamaNimi varchar(30),
Linn varchar(30))

create table Lend(
LendID int Primary Key identity(1,1),
LennuNumber int unique,
Väljumisaeg int,
LennujaamID int, FOREIGN KEY (LennujaamID) REFERENCES lennujaam(LennujaamID))

create table Reisija(
ReisijaID int primary key identity(1,1),
Nimi varchar (30),
Piletinumber int unique,
LendID int, FOREIGN KEY (LendID) REFERENCES Lend(LendID))

Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kuupaev DATETIME,
kasutaja varchar(30),
toiming  varchar(100),
andmed TEXT
)

CREATE TRIGGER LendKustutamine
ON Lend --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud Delete käsk',  --toiming
concat('Lennu number:',deleted.LennuNumber, ' Väljumisaeg: ', deleted.Väljumisaeg)  --andmed
FROM deleted;

CREATE TRIGGER LennuLisamine
ON Lend --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER,
'on tehtud INSERT käsk',  --toiming
concat('Lennu number:',inserted.LennuNumber, ' Väljumisaeg: ', inserted.Väljumisaeg)  --andmed
FROM inserted;

CREATE TRIGGER LennujaamLisaKustuta
ON Lennujaam --tabelinimi, mis on vaja jälgida
FOR INSERT, Delete
AS
begin
set nocount on;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud INSERT käsk',  --toiming
	concat('Lennujaama nimi:',inserted.LennujaamaNimi, ' Linn: ', inserted.Linn)  --andmed
	FROM inserted

	union all

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud Delete käsk',  --toiming
	concat('Lennujaama nimi:',deleted.LennujaamaNimi, ' Linn: ', deleted.Linn)  --andmed
	FROM deleted;
end;

CREATE TRIGGER ReisijaLisaKustuta
ON Reisija --tabelinimi, mis on vaja jälgida
FOR INSERT, Delete
AS
begin
set nocount on;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud INSERT käsk',  --toiming
	concat('Reisija nimi:',inserted.Nimi, ' Piletinumber: ', inserted.Piletinumber)  --andmed
	FROM inserted

	union all

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER,
	'on tehtud Delete käsk',  --toiming
	concat('Reisija nimi:',deleted.Nimi, ' Piletinumber: ', deleted.Piletinumber)  --andmed
	FROM deleted;
end;

CREATE PROCEDURE lisaReisija
--parameetrid @...
@uusReisija varchar(30),
@uusPiletinumber int,
@uusLendID int
AS
BEGIN
--kirjeldus
	INSERT INTO Reisija
	VALUES (@uusReisija,@uusPiletinumber,@uusLendID);
	SELECT * FROM Reisija;
END


--protseduur, mis kustutab kategooria id järgi
create procedure kustutaReisija
@kustutaId int
as
begin
	select * from Reisija;
	delete from Reisija where ReisijaID=@kustutaId;
	select * from Reisija;
end



CREATE PROCEDURE muudatus
    @tegevus varchar(10),
    @tabelinimi varchar(25),
    @veerunimi varchar(25),
    @tyyp varchar(25) = NULL
AS
BEGIN
    DECLARE @sqltegevus varchar(max);

    SET @sqltegevus = CASE 
        WHEN @tegevus = 'add' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus = 'drop' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
    END;

    PRINT @sqltegevus;
    EXEC (@sqltegevus);
END;


create table Reisijainfo(
infoID int Primary Key identity(1,1),
kondakonsus varchar(30),
email varchar(30),
telefonunumber int,
ReisijaID int,  FOREIGN KEY (ReisijaID) REFERENCES Reisija(ReisijaID))

insert into lennujaam
values('Riga airport','Riia')


insert into Reisijainfo
values('Eesti','martsoo@email.com',372565650,1),('Eesti','robsalu@email.com',3727542,2),('USA','kaarelrooba@email.com',156567802,3)

select * from Reisijainfo
select * from Reisija
select * from lennujaam
select * from Lend
select * from logi

create view Lennud
as
select lennujaam.LennujaamaNimi,Lend.LennuNumber,lend.LennujaamID,Lend.Väljumisaeg from lennujaam
inner join Lend on lennujaam.LennujaamID=Lend.LennujaamID

create view Reisijad
as
select Reisija.Nimi,Reisijainfo.email,Reisijainfo.kondakonsus,Reisijainfo.telefonunumber from Reisija
inner join Reisijainfo on Reisija.ReisijaID=Reisijainfo.ReisijaID

create view  reisijadlennud
as
select Reisija.Nimi,Lend.LennuNumber,Lend.Väljumisaeg, Reisija.Piletinumber from Reisija
left join Lend on Reisija.LendID=Lend.LendID

select * from Lennud
select * from Reisijad
select * from reisijadlennud

exec kustutaReisija 6
