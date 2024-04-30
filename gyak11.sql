CREATE TABLE dolgozo2 AS SELECT * FROM dolgozo;
/
SET SERVEROUTPUT ON;
/

--------------------------------------------------------------------------------
--Triggerek létrehozása
CREATE OR REPLACE TRIGGER sorszam
--    INSERT, DELETE, UPDATE, stb...
--      \/
BEFORE INSERT ON dolgozo2
-- /\
-- lehet még AFTER és INSTEAD
DECLARE
    akt_sorszam INT;
BEGIN
    SELECT MAX(dkod) INTO akt_sorszam FROM dolgozo2;
    :NEW.dkod := akt_sorszam + 1;
    dbms_output.put_line('A jelenlegi: ' || akt_sorszam);
END;
/
INSERT INTO dolgozo2(dnev,fizetes,oazon,dkod) VALUES('Uj_ember',4000,20,1111);
/

--------------------------------------------------------------------------------
--New kulcsszó használata

CREATE OR REPLACE TRIGGER sorszam
BEFORE INSERT ON dolgozo2
FOR EACH ROW --csak ilyenkor tudjuk használni a new és old kulcsszavakat
DECLARE
    akt_sorszam INT;
BEGIN
    SELECT MAX(dkod) INTO akt_sorszam FROM dolgozo2;
--  tartalmazza az egész recordot (esetünkben: dnev,fizetes,oazon,dkod)
--      \/
    :NEW.dkod := akt_sorszam + 1;
    dbms_output.put_line('A jelenlegi: ' || akt_sorszam);
    dbms_output.put_line('Az új sor: ' || :NEW.dkod || ' sorszámmal szúrtuk be');
END;
/
INSERT INTO dolgozo2(dnev,fizetes,oazon,dkod) VALUES('Uj_ember',4000,20,1111);
/

--------------------------------------------------------------------------------
--órán feladat
CREATE OR REPLACE FUNCTION fiz_emel(szazalek INT) RETURN INT IS --az IS kezdi a DECLARE blokkot
    CURSOR curs1 IS SELECT * FROM dolgozo2;
    osszeg INT := 0;
BEGIN
    FOR rec IN curs1 LOOP
        dbms_output.put_line(rec.fizetes || ' Új: ' || rec.fizetes*((100+szazalek)/100));
        osszeg := osszeg + NVL(rec.fizetes*((100+szazalek)/100),0) - NVL(rec.fizetes,0);
    END LOOP;
    RETURN osszeg;
END fiz_emel;
/
SELECT fiz_emel(20) FROM dual;
/

--------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION fiz_emel(szazalek INT) RETURN INT IS --az IS kezdi a DECLARE blokkot
--                                          csak UPDATE lehet
--                                              \/
    CURSOR curs1 IS SELECT * FROM dolgozo2 FOR UPDATE OF dkod;
--                                              /\          /\
--megmondom vele a cursornak hogy módosítani fogok        egy oszlop neve ami az aktuális táblában van (csak akkor kell ha több tábla van)
    osszeg INT := 0;
BEGIN
    FOR rec IN curs1 LOOP
        dbms_output.put_line(rec.fizetes || ' Új: ' || rec.fizetes*((100+szazalek)/100));
        osszeg := osszeg + NVL(rec.fizetes*((100+szazalek)/100),0) - NVL(rec.fizetes,0);
        UPDATE dolgozo2 SET fizetes = NVL(rec.fizetes*((100+szazalek)/100),0) WHERE CURRENT OF curs1;
    END LOOP;
    RETURN osszeg;
END fiz_emel;
/
SELECT fiz_emel(20) FROM dual;
/
--név nélküli blokkal meghívás (mert SELECT-el nem tudok módosítani)
DECLARE
BEGIN
    dbms_output.put_line(fiz_emel(20));
END;
/
SELECT * FROM dolgozo2;
/
