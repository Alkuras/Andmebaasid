

create table kasutaja(
kasutajaid int Primary Key identity(1,1),
eesnimi varchar(50),
perenimi varchar (50),
email varchar(150))

create table kategooria(
kategooriaid  int Primary Key identity(1,1),
kategoorianimi varchar (50))

create table toiduaine(
toiduaineid  int Primary Key identity(1,1),
toiduainenimi varchar(100))

create table yhik(
yhikid  int Primary Key identity(1,1),
yhiknimi varchar(100))

create table retsept(
retseptid  int Primary Key identity(1,1),
retseptinimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatudkp date,
kasutajaid int, foreign key (kasutajaid) references kasutaja(kasutajaid),
kategooriaid int, foreign key (kategooriaid) references kategooria(kategooriaid))

create table koostis(
koostisid  int Primary Key identity(1,1),
kogus int,
retseptid int, foreign key (retseptid) references retsept(retseptid),
toiduaineid int, foreign key (toiduaineid) references toiduaine(toiduaineid),
yhikid int, foreign key (yhikid) references yhik(yhikid))

create table tehtud(
tehtudid  int Primary Key identity(1,1),
tehtudkp date,
retseptid int, foreign key (retseptid) references retsept(retseptid))



CREATE PROCEDURE lisakasutaja
    @eesnimi varchar(50),
    @perenimi varchar(50),
    @email varchar(150)
AS
BEGIN
    INSERT INTO kasutaja(eesnimi, perenimi, email)
    VALUES (@eesnimi, @perenimi, @email);

    SELECT * FROM kasutaja;
END;

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

exec lisakasutaja 'Kaisa','Künk','kkünk@gmail.com'

insert into kategooria
values('pitsa'),('supp'),('kook'),('piirukas'),('salat')

insert into toiduaine
values('tomat'),('kartul'),('kana kints'),('porgand'),('sibul')

insert into yhik
values('tk'),('l'),('kg'),('g'),('lusikas')

insert into retsept 
values('Tomat pitsa','Lihtne tomaatne pitsa pole nii maitsev','Taigna peale paneme tomatid ja ahjusse','2026-04-14',2,1),
('Porgandi supp','Maisev porgandi supp','Keedame vees porgandid, kartulit ja sibul','2026-04-24',1,2),
('Porgandi kook','Magus ja maitsev porgandi kook','Tavaline porganid kooki retsept','2026-05-14',3,3),
('Piirukas kana lihaga','Praetud piirukas kana kintsu- sibula taidisega','"TDB"','2026-05-26',4,4),
('Salat','Kartuli kana salat','Keedetud kartul,porgand ja praetud kana kints segada koos','2026-04-19',5,5)

insert into koostis
values(5,2,4,1),(100,4,3,4),(50,4,5,4),(500,2,5,4),(5,2,5,1)

insert into tehtud
values('2026-05-19',1),('2026-05-22',2),('2026-05-03',3),('2026-05-16',5),('2026-05-26',4)

select kasutaja.eesnimi, kasutaja.perenimi, retsept.retseptinimi from retsept inner join kasutaja on kasutaja.kasutajaid = retsept.kasutajaid; 

select retsept.retseptinimi,kategooria.kategoorianimi from kategooria inner join retsept on retsept.retseptid = kategooria.kategooriaid; 

create table kinnitajad(
kinnitajaid  int Primary Key identity(1,1),
kinnitajanimi varchar(100),
kinnitatudretseptid int, foreign key (kinnitatudretseptid) references retsept(retseptid))

CREATE PROCEDURE lisakinnitaja
    @nimi varchar(100),
    @retseptid int
AS
BEGIN
    INSERT INTO kinnitajad(kinnitajanimi, kinnitatudretseptid)
    VALUES (@nimi, @retseptid);

    SELECT * FROM kinnitajad;
END;

create procedure kustutakinnitaja
@kustutaId int
as
begin
	select * from kinnitajad;
	delete from kinnitajad where kinnitajaid=@kustutaId;
	select * from kinnitajad;
end

exec lisakinnitaja 'Salme Rott',4
