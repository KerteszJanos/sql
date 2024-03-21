SELECT TO_DATE('1990-11-11','YYYY_MM-DD') FROM dolgozo;
SELECT TO_DATE('1990-11-11','YYYY_MM-DD') FROM dual; --dummy table

--NVL haszn�lata:
SELECT fizetes, jutalek, fizetes + jutalek, fizetes + NVL(jutalek, 0) FROM dolgozo;

--------------------------------------------------------------5gy---------------------------------------------------------------
--Adjuk meg mennyi a dolgoz�k k�z�tt el?fordul� maxim�lis fizet�s.
SELECT MAX(fizetes) AS max_fiz FROM dolgozo;

--Adjuk meg mennyi a dolgoz�k k�z�tt el?fordul� minim�lis fizet�s.
SELECT MIN(fizetes) AS min_fiz FROM dolgozo;

--Adjuk meg mennyi a dolgoz�k k�z�tt el?fordul� �tlagfizet�s.
SELECT AVG(fizetes) AS avg_fiz FROM dolgozo;

--Adjuk meg h�ny dolgoz� van a dolgoz� t�bl�ban.
SELECT COUNT(*) AS worker_num FROM dolgozo;
--Adjuk meg azokra az oszt�lyokra az �tlagfizet�st, ahol ez nagyobb mint 2000.
