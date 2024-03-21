SELECT TO_DATE('1990-11-11','YYYY_MM-DD') FROM dolgozo;
SELECT TO_DATE('1990-11-11','YYYY_MM-DD') FROM dual; --dummy table

--NVL használata:
SELECT fizetes, jutalek, fizetes + jutalek, fizetes + NVL(jutalek, 0) FROM dolgozo;

--------------------------------------------------------------5gy---------------------------------------------------------------
--Adjuk meg mennyi a dolgozók között el?forduló maximális fizetés.
SELECT MAX(fizetes) AS max_fiz FROM dolgozo;

--Adjuk meg mennyi a dolgozók között el?forduló minimális fizetés.
SELECT MIN(fizetes) AS min_fiz FROM dolgozo;

--Adjuk meg mennyi a dolgozók között el?forduló átlagfizetés.
SELECT AVG(fizetes) AS avg_fiz FROM dolgozo;

--Adjuk meg hány dolgozó van a dolgozó táblában.
SELECT COUNT(*) AS worker_num FROM dolgozo;
--Adjuk meg azokra az osztályokra az átlagfizetést, ahol ez nagyobb mint 2000.
