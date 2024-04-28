

--fv. l�trehoz�sa vagy fel�ldefini�l�sa:
CREATE OR REPLACE FUNCTION proba RETURN INT IS

--deklaraci�s blokk
BEGIN --elv�lasztja a deklar�ci�s blokkot a programblokkt�l
--programblokk
    RETURN 1;
END proba;

DROP FUNCTION proba;

--fv. lek�rd�zese
SELECT proba() FROM dual;

--------------------------------------------------------------------------------------------------------------------------------
--Pr�b�ljunk meg ki�ratni valamit.

--elj�r�s:
CREATE OR REPLACE PROCEDURE hello IS
BEGIN
    dbms_output.put_line('Hello World!'); --"ki�rat�st" megval�sitja a script outputra
END hello;

SET SERVEROUTPUT ON; --sessiononk�nt egyszr kell, bekapcsolja hogy az al�bbi sor l�that� legyen a script outputon
CALL hello(); --elj�r�s futtat�s�ra CALL utas�t�s

-----------------------

--param�terez�s
CREATE OR REPLACE PROCEDURE helloNev(nev VARCHAR2) IS
BEGIN
    dbms_output.put_line('Hello ' || nev); -- || oper�tor a string konkatan�ci�
END helloNev;

--SET SERVEROUTPUT ON; --jelenleg nem sz�ks�ges
CALL helloNev('Peti');

-----------------------
--deklar�ci�s blokk haszn�lata
CREATE OR REPLACE PROCEDURE helloNev2(nev VARCHAR2) IS
 uzenet VARCHAR(20) := '!!!'; --�rt�kad�s :=
BEGIN
    dbms_output.put_line('Hello ' || nev || uzenet); -- || oper�tor a string konkatan�ci�
END helloNev2;

CALL helloNev2('Peti');

-----------------------
--lopp haszn�lata
CREATE OR REPLACE PROCEDURE helloNev2Loop(nev VARCHAR2) IS
 uzenet VARCHAR(20) := '!!!'; --�rt�kad�s :=
BEGIN
    FOR i IN 1..10 LOOP --for syntax 
  --FOR i IN REVERSE 1..10 LOOP... ford�tva megy a loop  
        dbms_output.put_line(i || ' - ' || 'Hello ' || nev || uzenet); -- || oper�tor a string konkatan�ci�
    END LOOP;
END helloNev2Loop;

CALL helloNev2Loop('Peti');

-----------------------
--if haszn�lata
CREATE OR REPLACE PROCEDURE helloNev2LoopIf(nev VARCHAR2) IS
 uzenet VARCHAR(20) := '!!!'; --�rt�kad�s :=
BEGIN
    FOR i IN 1..10 LOOP --for syntax 
        IF MOD(i,3) = 0 THEN
            dbms_output.put_line(i || ' - ' || 'Hello ' || nev || uzenet); -- || oper�tor a string konkatan�ci�
        ELSIF MOD(i,3) = 1 THEN
            dbms_output.put_line(i || ' + ' || 'Hello ' || nev || uzenet); -- || oper�tor a string konkatan�ci�
        ELSE
            dbms_output.put_line(i || ' * ' || 'Hello ' || nev || uzenet); -- || oper�tor a string konkatan�ci�
        END IF;
    END LOOP;
END helloNev2LoopIf;

CALL helloNev2LoopIf('Peti');

--default param�ter �tv�tele immutablev� teszi azt
--rekurzi� t�mogatott

--bool �rt�kek:
--dekral�lni szeretn�k boolt az ok�s
--ha boolt kell returnolni akkor 0(false) 1(true)

--------------------------------------------------------------------------------------------------------------------------------
--�rai feladatok:

--Pr�m-e F�ggv�ny
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

--Legnagyobb k�z�s oszt�
--:(

--Faktori�lis
CREATE OR REPLACE FUNCTION faktor(n INT) RETURN INT IS

BEGIN
    IF n = 0 THEN
        RETURN 1;
    ELSE
        RETURN n * faktor(n-1);
    END IF;
END faktor;

SELECT faktor(5) FROM dual;