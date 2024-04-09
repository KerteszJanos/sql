--t�bla t�rl�se
--DROP TABLE alapanyag;

--t�bla l�trehoz�sa
CREATE TABLE TERMEK --t�blan�v 
(
--  nev  type    megszor�t�s
--   \/   \/       \/
    t_id INT PRIMARY KEY,
    new VARCHAR2(20) NOT NULL
--          /\
--  20 karakter hossz� string
);

CREATE TABLE felhasznalo
(
    f_nev VARCHAR2(30) PRIMARY KEY, --nem lehet null �s egyedi kell legyen
    cim VARCHAR2(50) UNIQUE --nem lehet egyez? �rt�k
);


CREATE TABLE vasarol
(
    t_id INT,
    f_nev VARCHAR2(30),
    db INT,
  
-- megszoritas   (m. neve)    idegen kulcs t�pus        idegen kulcs refer�lni csak els?dlegest tud
--      \/          \/             \/                   \/
    CONSTRAINT felhasznalo_fk FOREIGN KEY (f_nev) REFERENCES felhasznalo(f_nev),
--                                          /\                      /\    
--                               hova teszem a kulcsot      a felhasznalo tabla f_nev oszlop�ban l�v? id-k lehetnek    
    
    CONSTRAINT termek_fk FOREIGN KEY (t_id) REFERENCES termek(t_id)
);

--�gy is l�tre lehet hozni t�bl�kat (lek�rdez�s eredm�ny�t t�bl�ba l�trehozni):
CREATE TABLE dolgozo2 AS SELECT * FROM dolgozo;
SELECT * FROM dolgozo2;
DROP TABLE dolgozo2;

--n�zet t�bl�k l�trehoz�sa:
CREATE VIEW dolgozo_nezet AS SELECT * FROM dolgozo;
--(nezet t�bl�ban nem duplik�lunk adatokat, mindig amikor lek�rdezz�k �jra lefut a t�bla)
--oracleban csak lek�rdezni lehet bel?le, m�dos�tani nem

--t�bla (sh�ma) m�dos�t�sa:
ALTER TABLE felhasznalo ADD tel VARCHAR2(20); --�j argumentum hozz�ad�sa
ALTER TABLE felhasznalo MODIFY tel INT; -- l�tez? argumentum t�pus�t m�dos�tja (csak akkor ha nincsenek benne recordok)
ALTER TABLE felhasznalo DROP COLUMN tel; --oszlop t�rl�se
SELECT * FROM felhasznalo;

--t�bla kezd?�llapotba �ll�t�sa (recordok �r�t�se)
TRUNCATE TABLE vasarlo;
TRUNCATE TABLE felhasznalo;

--------------------------------------------------------------------------------------------------------------------------------
--T�bla felt�lt�se:
INSERT INTO termek VALUES (1, 'asztal');
INSERT INTO termek VALUES (1, 'asztal');
INSERT INTO termek(nev, t_id) VALUES ('agy',3);

INSERT INTO felhasznalo VALUES ('Georgei', 'A lak�som', ':(');

--T�blarekord m�dos�t�sa:
UPDATE termek SET ar = t_id*1000; --WHERE (opcion�lis)

--T�blarekord t�rl�se:
DELETE FROM termek WHERE t_id NOT IN (SELECT t_id FROM vasarlo);

SELECT * FROM termek;
SELECT * FROM felhasznalo;