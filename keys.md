### Andmebaasi võtmed(Keys) 

[Põhimõisted](README.md) | [Kasutajad](Kasutaja.md) | [Võtmed](keys.md) | [Trigerid](triger.md) | [Protseduurid](protseduurid.md) | [Sales table](Sales.md)

##Andmebaasi võtmed

Andmebaasides kasutame erinevaid võtmeid, et andmeid korralikult korraldada ja seostada. Iga võtme eesmärk on aidata identifitseerida ja seostada kirjeid tabelites, et andmed oleksid loogilised ja lihtsasti ligipääsetavad.

Superkey on nagu candidate key, aga sisaldab rohkem veerge, kui on tegelikult vajalik. Candidate key on primary key-ga sarnane, kuid primary key on lihtsalt valitud üks kandidaatvõtme hulgast, et määrata tabeli iga kirje unikaalsus.
##1. Primary Key (Põhivõti)

Põhivõti on see, mis aitab tabelis iga kirje unikaalselt ära tunda.
Ainult üks põhivõti saab olla igas tabelis, sest ainult üks veerg saab kõiki kirjeid identifitseerida.

```sql	
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,     -- primary key
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);
```

<img width="224" height="121" alt="{FB13756F-6EAD-4790-BE50-7631A42C5A49}" src="https://github.com/user-attachments/assets/7f6a2e4a-f16a-46cb-b66f-5b5acf2fde2e" />

##2. Foreign Key (Võõrvõti)

Võõrvõti on nagu viide teistele tabelitele. See veerg seondub teise tabeli põhivõtmega, et teha tabelite vaheline seos.
Võõrvõti ei pea olema unikaalne ja võib sisaldada tühje väärtusi, kuid see peab viitama olemasolevale kirjele teises tabelis.
```sql
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) -- foreign key
);
```
<img width="221" height="328" alt="{CD386F5F-528D-460B-ABA9-3EA8531C471D}" src="https://github.com/user-attachments/assets/a3907a5f-b2b5-413d-bde8-09713f52bb2f" />


##3. Unique Key (Unikaalne võti)

Unikaalne võti teeb sama, mis põhivõti – tagab, et väärtused on unikaalsed, aga see võib sisaldada tühi väärtusi.
Erinevalt põhivõtust ei ole see kunagi kohustuslik, et väärtus ei oleks tühi.

```sql		
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Email NVARCHAR(100) UNIQUE,    -- unique key
    Username NVARCHAR(50)
);
```
<img width="1215" height="130" alt="{EF860F97-BDB2-44DA-BF4E-17A72500C0EB}" src="https://github.com/user-attachments/assets/6499ada4-279d-4fe5-8e74-049dcf3aece1" />


##4. Simple Key (Lihtne võti)

Lihtne võti on üks veerg, mis aitab kirjeid tabelis ära tunda. Seda kasutatakse siis, kui üks veerg on piisav, et iga kirje eristada.
Siin ei ole mingit segadust, lihtsalt üks väärtus, mis ütleb, mis on mis.

```sql		
CREATE TABLE Countries (
    CountryCode CHAR(2) PRIMARY KEY,   -- simple key
    CountryName NVARCHAR(100)
);
```
<img width="319" height="100" alt="{A409417D-648D-4220-BB36-542CAD692FF1}" src="https://github.com/user-attachments/assets/4852c82c-bd37-444e-8eb9-191ea0c9458b" />


##5. Composite Key (Komposiitvõti)

Komposiitvõti koosneb rohkem kui ühest veerust, sest üksi ei piisa, et kirjeid unikaalselt määratleda.
Seda kasutatakse siis, kui üks veerg on liiga väike või mitte piisav, et kõiki kirjeid ära tunda.

```sql		
CREATE TABLE StudentCourses (
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    PRIMARY KEY (StudentID, CourseID)   -- composite key
);
```
<img width="278" height="136" alt="{36CF75F7-C65F-4011-AAD3-CF8991B8939E}" src="https://github.com/user-attachments/assets/199571be-a0f0-401a-a2a4-3812a9d357e2" />


##6. Compound Key (Komplekssed võtmed)

Komplekssed võtmed on natuke nagu komposiitvõtmed, aga need on sageli seotud just tabelite vaheliste seoste loomisega.
Komplekssed võtmed võivad sisaldada rohkem kui ühte veergu, et siduda tabelites olevaid andmeid.

```sql		
CREATE TABLE ExamResults (
    StudentID INT,
    CourseID INT,
    ExamScore INT,
    FOREIGN KEY (StudentID, CourseID) REFERENCES StudentCourses(StudentID, CourseID)
);
-- Composite primary key in StudentCourses
-- Compound foreign key in ExamResults
```
<img width="236" height="339" alt="{198F40B8-F6C1-49D0-BE95-D28886B8A885}" src="https://github.com/user-attachments/assets/b3a2fedd-677d-4b33-9a5f-344e8452c71d" />


##7. Superkey (Üldvõti)

Superkey on midagi, mis koosneb vähemalt ühest veerust, mis teeb iga kirje unikaalseks. Aga see võib sisaldada rohkem veerge, kui on vaja.
Kõik põhivõtmed on supervõtmed, aga mitte kõik supervõtmed ei ole põhivõtmed.

```sql		
-- (StudentID, Email) would be a superkey
CREATE TABLE SuperKeyExample (
    StudentID INT PRIMARY KEY,
    Email NVARCHAR(100),
    Phone NVARCHAR(20)
);
```


##8. Candidate Key (Kandidaadivõti)

Kandidaadivõti on lihtsalt mõni veerg, mis võiks olla põhivõti, sest see on unikaalne ja ei sisalda tühi väärtusi.
Üks kandidaatvõti saab lõpuks põhivõtuks, aga neid võib olla mitu.

```sql		
CREATE TABLE Employees (
    EmployeeID INT,               -- candidate key #1
    NationalID NVARCHAR(20),      -- candidate key #2
    Name NVARCHAR(100),
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID),
    CONSTRAINT UQ_Employee_NationalID UNIQUE (NationalID)
);
```
<img width="1071" height="140" alt="{5FD34098-0A13-4B2E-9BF1-1E721650EC4E}" src="https://github.com/user-attachments/assets/ed0cc05d-3186-4e22-8278-b59125e6e7a0" />

<img width="1098" height="128" alt="{4A43D22E-F1E2-495E-9E2A-37E9FF9E5F70}" src="https://github.com/user-attachments/assets/ea1134ef-7338-4128-84f4-204754199f9e" />



##9. Alternate Key (Alternatiivvõti)

Alternatiivvõti on tegelikult kandidaatvõti, aga see ei saanud põhivõtuks.
Sellel on samad omadused nagu kandidaatvõtul, aga see lihtsalt ei ole tabeli põhivõti.

```sql	
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    NationalID NVARCHAR(20) UNIQUE,  -- alternate key
    Name NVARCHAR(100)
);
```

<img width="1133" height="149" alt="{EF11B0B2-DE2D-4018-85B4-BF4DC72E4B0F}" src="https://github.com/user-attachments/assets/ac5f2225-fdad-4b82-befd-c1d96d221736" />


###Kasutatud allikad
https://artjompoldsaar24.thkit.ee/wp/andmebaasi-votmed/
