--Kik azok a dolgoz�k, akiknek a f?n�ke KING? (nem leolvasva)
SELECT d1.dnev FROM dolgozo d1 , dolgozo d2 WHERE d1.fonoke = d2.dkod AND d2.dnev = 'KING';
 
--Adjuk meg azoknak a f?n�k�knek a nev�t, akiknek a foglalkoz�sa nem 'MANAGER' (dnev)
SELECT d2.dnev FROM dolgozo d1 , dolgozo d2 WHERE d1.fonoke = d2.dkod 
MINUS
SELECT dnev from dolgozo WHERE foglalkozas='MANAGER';

--Adjuk meg azokat a dolgoz�kat, akik t�bbet keresnek a f?n�k�kn�l.
SELECT d1.dnev FROM dolgozo d1, dolgozo d2 WHERE d1.fizetes > d2.fizetes AND d1.fonoke = d2.dkod;

--Kik azok a dolgoz�k, akik f?n�k�nek a f?n�ke KING?
SELECT d1.dnev FROM dolgozo d1, dolgozo d2, dolgozo d3 WHERE d1.fonoke = d2.dkod AND d2.fonoke = d3.dkod AND d3.dnev = 'KING';

--Kik szeretnek minden gy�m�lcs�t
