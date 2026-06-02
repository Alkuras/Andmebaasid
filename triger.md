### SQL triggerid on spetsiaalsed andmebaasi objektid, mis käivituvad automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE või DELETE).
``` sql
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
``` 
<img width="619" height="388" alt="{8762D4E0-28FB-4772-81E8-FE0EE1678B35}" src="https://github.com/user-attachments/assets/c1c468ed-c8a7-47ca-bca6-1af22bfaa67c" />

``` sql
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

``` 
<img width="622" height="383" alt="{0A8F41BD-F1F6-4B83-BB39-DEBB4A7BDFCB}" src="https://github.com/user-attachments/assets/74f78792-47d9-4361-a033-9bc4b5e29205" />

``` sql
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
```

<img width="621" height="381" alt="{4F8D076E-D017-4B7F-846B-4E7486C132F9}" src="https://github.com/user-attachments/assets/5a2521c4-993e-4877-9faa-d9dcdfae1726" />

``` sql
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

```

<img width="819" height="431" alt="{5A1AA979-C90E-4F8E-8324-23EB5F6C0B45}" src="https://github.com/user-attachments/assets/0b8f4b04-1cf6-4b5f-862d-cb23c2d64d5d" />


<img width="718" height="232" alt="{BCA7F38C-E35E-4E78-87D8-6CF3FC896BC0}" src="https://github.com/user-attachments/assets/1012e7b8-8b0c-477e-b465-61507fc8d2c5" />

``` sql
exec sp_helptext 'linnaUuendamine'
```







