## SQL Server - Kasutajate autentimine ja õiguste haldamine

**SQL serveris kasutatakse kahte peamist autentimise tüüpi:**
1. Windows Authentication
   > Kasutajanimi ja parool on seotud Windowsiga.
    <img width="463" height="510" alt="{9D74BDCF-88CA-4E5C-A0F4-89F83B7E6603}" src="https://github.com/user-attachments/assets/a6c457c1-63f5-46a5-b757-e9f3da00f314" />

2. SQL Server Authentification
   > Luuakse otse SQL serverisse.

Server menüüs saab määrata ülised õigused.
Tavaliselt piisab rollist: public

<img width="269" height="261" alt="{08F9EF1E-A620-427B-A52B-229B31F4CF04}" src="https://github.com/user-attachments/assets/a6937912-e592-4693-92ca-907039331f80" />


<img width="705" height="656" alt="{76262709-FF1B-4604-9D6C-1D7E2B09C576}" src="https://github.com/user-attachments/assets/c8fe6829-7748-4a68-9205-d43002112f11" />


<img width="694" height="653" alt="{B4F96319-9E8B-4AA8-9737-28ECA2FE611C}" src="https://github.com/user-attachments/assets/d14fcda1-f2d8-4159-9991-bc976ea7189a" />


## LISAME ÕIGUSED Queriga

```sql 
--GRANT -õiguste määramine
--DENY -õiguste keelamine
-- anname kasutajale õigus vaadata tabelit, lisada andmeid (SELECT),
-- lisadda andmeid ning uuendada neid (INSERT/UPDATE)
GRANT SELECT ON tootaja TO direktorMelikov;
GRANT INSERT ON tootaja TO direktorMelikov;
GRANT UPDATE ON tootaja TO direktorMelikov;

DENY DELETE ON tootaja TO direktorMelikov;
```


## Kasutaja õiguste kontroll
Logime sisse meie uue kasutajana

<img width="482" height="508" alt="{41C59CFC-7F33-490C-904E-E09A4D9DDF4B}" src="https://github.com/user-attachments/assets/24ff727f-9da3-4ae4-9d33-c83066429a00" />


Vaatame mis meile lubatakse:

<img width="1085" height="724" alt="{931B455F-35D7-40D4-90B8-001AF65D2B3B}" src="https://github.com/user-attachments/assets/5be0c094-0eaf-4264-a6e3-98b8829c8025" />


Nüüd mis on keelatud:

<img width="1159" height="693" alt="{F9AF71FD-6CB4-4FBD-AA70-7918E9D14276}" src="https://github.com/user-attachments/assets/6f3b229c-c660-4568-85fb-c97fb06084b1" />


Vaatame õigused läbi SQL päring:

<img width="997" height="848" alt="{7EEF34AA-AF17-4CC7-BB01-7B11B74DA526}" src="https://github.com/user-attachments/assets/e1b6637d-24d7-461b-bc19-22e0eedfc355" />


Nüüd läbi UI

<img width="709" height="653" alt="{AF815C92-236A-4DCF-B0B6-74BA3C2F189B}" src="https://github.com/user-attachments/assets/9c5280df-89ab-42e4-91fd-934f4c21057c" />
