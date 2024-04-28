--                        be és kimeneti paraméter (referencia szerint veszi át)
--                                     \/
CREATE OR REPLACE PROCEDURE proba2(a IN OUT INT) IS
BEGIN
    a := a*2;
END proba2;
/
CALL proba2(10);
/
SET SERVEROUTPUT ON;
/
DECLARE
 b INT := 2;
BEGIN
 dbms_output.put_line(b);
 proba2(b);
 dbms_output.put_line(b);
END;
/
--------------------------------------------------------------------------------------------------------------------------------
--Tömb használata:

DECLARE
--Tömb típus létrehozása:
TYPE uj_tomb_tipus IS VARRAY(5) OF INT;
tomb uj_tomb_tipus := uj_tomb_tipus(1,2,3,4,5);
BEGIN
    FOR i IN 1..tomb.COUNT LOOP
        dbms_output.put_line(tomb(i));
    END LOOP;
END;
/
--------------------------------------------------------------------------------------------------------------------------------
--Saját exception írása:
DECLARE
sajat_exception EXCEPTION;
BEGIN

RAISE sajat_exception;

EXCEPTION
 WHEN sajat_exception THEN
  dbms_output.put_line('RIP BOZO');
END;
/

--------------------------------------------------------------------------------------------------------------------------------
--Cursor kezelése (foreach):
DECLARE
 CURSOR curs1 IS SELECT * FROM dolgozo; --recordokat olvas
 rec curs1%ROWTYPE;
BEGIN 
 OPEN curs1;
  LOOP
   FETCH curs1 INTO rec;
   EXIT WHEN curs1%NOTFOUND;
    dbms_output.put_line(rec.dnev);
  END LOOP;
  dbms_output.put_line('vegeztem');
 CLOSE curs1;
END;
/

--------------------------------------------------------------------------------------------------------------------------------
--Foreachos megoldás cursor olvasására
DECLARE
 CURSOR curs1 IS SELECT * FROM dolgozo; --recordokat olvas
BEGIN
 FOR rec IN curs1 LOOP
    dbms_output.put_line(rec.dnev);
 END LOOP;
END;
/

--------------------------------------------------------------------------------------------------------------------------------
ACCEPT nev CHAR PROMPT 'Add meg a nevet' --programtol változatlanul feltölt egy változót később &nev-be ez fog behelyettesítődni
/
--Pop up
DECLARE
 --CURSOR curs1 IS SELECT * FROM dolgozo WHERE dnev = 'BLACK'; --konstans
 CURSOR curs1 IS SELECT * FROM dolgozo WHERE dnev = '&nev'; --user input
BEGIN
 FOR rec IN curs1 LOOP
    dbms_output.put_line(rec.dnev);
 END LOOP;
END;
/

--------------------------------------------------------------------------------------------------------------------------------
DECLARE
BEGIN
 FOR i IN 1..LENGTH('valami') LOOP
  dbms_output.put_line(SUBSTR('valami',i,1));
 END LOOP;
END;
