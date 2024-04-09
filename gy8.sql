--tábla törlése
--DROP TABLE alapanyag;

--tábla létrehozása
CREATE TABLE TERMEK --táblanév 
(
--  nev  type    megszorítás
--   \/   \/       \/
    t_id INT PRIMARY KEY,
    new VARCHAR2(20) NOT NULL
--          /\
--  20 karakter hosszú string
);

CREATE TABLE felhasznalo
(
    f_nev VARCHAR2(30) PRIMARY KEY, --nem lehet null és egyedi kell legyen
    cim VARCHAR2(50) UNIQUE --nem lehet egyez? érték
);


CREATE TABLE vasarol
(
    t_id INT,
    f_nev VARCHAR2(30),
    db INT,
  
-- megszoritas   (m. neve)    idegen kulcs típus        idegen kulcs referálni csak els?dlegest tud
--      \/          \/             \/                   \/
    CONSTRAINT felhasznalo_fk FOREIGN KEY (f_nev) REFERENCES felhasznalo(f_nev),
--                                          /\                      /\    
--                               hova teszem a kulcsot      a felhasznalo tabla f_nev oszlopában lév? id-k lehetnek    
    
    CONSTRAINT termek_fk FOREIGN KEY (t_id) REFERENCES termek(t_id)
);

--így is létre lehet hozni táblákat (lekérdezés eredményét táblába létrehozni):
CREATE TABLE dolgozo2 AS SELECT * FROM dolgozo;
SELECT * FROM dolgozo2;
DROP TABLE dolgozo2;

--nézet táblák létrehozása:
CREATE VIEW dolgozo_nezet AS SELECT * FROM dolgozo;
--(nezet táblában nem duplikálunk adatokat, mindig amikor lekérdezzük újra lefut a tábla)
--oracleban csak lekérdezni lehet bel?le, módosítani nem

--tábla (shéma) módosítása:
ALTER TABLE felhasznalo ADD tel VARCHAR2(20); --új argumentum hozzáadása
ALTER TABLE felhasznalo MODIFY tel INT; -- létez? argumentum típusát módosítja (csak akkor ha nincsenek benne recordok)
ALTER TABLE felhasznalo DROP COLUMN tel; --oszlop törlése
SELECT * FROM felhasznalo;

--tábla kezd?állapotba állítása (recordok ürítése)
TRUNCATE TABLE vasarlo;
TRUNCATE TABLE felhasznalo;

--------------------------------------------------------------------------------------------------------------------------------
--Tábla feltöltése:
INSERT INTO termek VALUES (1, 'asztal');
INSERT INTO termek VALUES (1, 'asztal');
INSERT INTO termek(nev, t_id) VALUES ('agy',3);

INSERT INTO felhasznalo VALUES ('Georgei', 'A lakásom', ':(');

--Táblarekord módosítása:
UPDATE termek SET ar = t_id*1000; --WHERE (opcionális)

--Táblarekord törlése:
DELETE FROM termek WHERE t_id NOT IN (SELECT t_id FROM vasarlo);

SELECT * FROM termek;
SELECT * FROM felhasznalo;