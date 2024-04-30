--fv. létrehozása vagy felüldefiniálása:
CREATE OR REPLACE FUNCTION proba RETURN INT IS
--deklarációs blokk
BEGIN --elválasztja a deklarációs blokkot a programblokktól
--programblokk
    RETURN 1;
END proba;

DROP FUNCTION proba;

--fv. lekérdezése
SELECT proba() FROM dual;

--------------------------------------------------------------------------------------------------------------------------------
--Próbáljunk meg kiíratni valamit.

--eljárás:
CREATE OR REPLACE PROCEDURE hello IS
BEGIN
    dbms_output.put_line('Hello World!'); --"kiíratást" megvalósítja a script outputra
END hello;

SET SERVEROUTPUT ON; --sessiononként egyszer kell, bekapcsolja hogy az alábbi sor látható legyen a script outputon
CALL hello(); --eljárás futtatására CALL utasítás

-----------------------

--paraméterezés
CREATE OR REPLACE PROCEDURE helloNev(nev VARCHAR2) IS
BEGIN
    dbms_output.put_line('Hello ' || nev); -- || operátor a string konkatenáció
END helloNev;

--SET SERVEROUTPUT ON; --jelenleg nem szükséges
CALL helloNev('Peti');

-----------------------
--deklarációs blokk használata
CREATE OR REPLACE PROCEDURE helloNev2(nev VARCHAR2) IS
 uzenet VARCHAR2(20) := '!!!'; --értékadás :=
BEGIN
    dbms_output.put_line('Hello ' || nev || uzenet); -- || operátor a string konkatenáció
END helloNev2;

CALL helloNev2('Peti');

-----------------------
--ciklus használata
CREATE OR REPLACE PROCEDURE helloNev2Loop(nev VARCHAR2) IS
 uzenet VARCHAR2(20) := '!!!'; --értékadás :=
BEGIN
    FOR i IN 1..10 LOOP --for syntax 
  --FOR i IN REVERSE 1..10 LOOP... fordítva megy a loop  
        dbms_output.put_line(i || ' - ' || 'Hello ' || nev || uzenet); -- || operátor a string konkatenáció
    END LOOP;
END helloNev2Loop;

CALL helloNev2Loop('Peti');

-----------------------
--if használata
CREATE OR REPLACE PROCEDURE helloNev2LoopIf(nev VARCHAR2) IS
 uzenet VARCHAR2(20) := '!!!'; --értékadás :=
BEGIN
    FOR i IN 1..10 LOOP --for syntax 
        IF MOD(i,3) = 0 THEN
            dbms_output.put_line(i || ' - ' || 'Hello ' || nev || uzenet); -- || operátor a string konkatenáció
        ELSIF MOD(i,3) = 1 THEN
            dbms_output.put_line(i || ' + ' || 'Hello ' || nev || uzenet); -- || operátor a string konkatenáció
        ELSE
            dbms_output.put_line(i || ' * ' || 'Hello ' || nev || uzenet); -- || operátor a string konkatenáció
        END IF;
    END LOOP;
END helloNev2LoopIf;

CALL helloNev2LoopIf('Peti');

--default paraméter átvétele immutablevé teszi azt
--rekurzió támogatott

--bool értékek:
--deklarálni szeretném boolt az okés
--ha boolt kell returnolni akkor 0(false) 1(true)

--------------------------------------------------------------------------------------------------------------------------------
--órai feladatok:

--Prím-e Függvény
CREATE OR REPLACE FUNCTION prim(szam INT) RETURN INT IS
BEGIN
    IF szam <= 2 THEN
        RETURN 1;
    END IF;
    FOR i IN 2..SQRT(szam) LOOP
        IF MOD(szam,i) = 0 THEN
            RETURN 0;
        END IF;
    END LOOP;
    RETURN 1;
END prim;

SELECT prim(2),prim(3),prim(5),prim(6),prim(7) from dual;

--Fibonacci sorozat
CREATE OR REPLACE FUNCTION fib(n INT) RETURN INT IS
BEGIN
    IF n = 1 THEN
        RETURN 1;
    ELSIF n = 2 THEN
        RETURN 1;
    ELSE
        RETURN fib(n-1) + fib(n-2);
    END IF;
END fib;

SELECT fib(10) FROM dual;

--Legnagyobb közös osztó
--:(

--Faktoriális
CREATE OR REPLACE FUNCTION faktor(n INT) RETURN INT IS
BEGIN
    IF n = 0 THEN
        RETURN 1;
    ELSE
        RETURN n * faktor(n-1);
    END IF;
END faktor;

SELECT faktor(5) FROM dual;
