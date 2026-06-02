### Andmebaasi võtmed(Keys) 

Andmebaasi võtmed

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
##4. Simple Key (Lihtne võti)

Lihtne võti on üks veerg, mis aitab kirjeid tabelis ära tunda. Seda kasutatakse siis, kui üks veerg on piisav, et iga kirje eristada.
Siin ei ole mingit segadust, lihtsalt üks väärtus, mis ütleb, mis on mis.

```sql		
CREATE TABLE Countries (
    CountryCode CHAR(2) PRIMARY KEY,   -- simple key
    CountryName NVARCHAR(100)
);
```
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

###Kasutatud allikad
https://artjompoldsaar24.thkit.ee/wp/andmebaasi-votmed/
