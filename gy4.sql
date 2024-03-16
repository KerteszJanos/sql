--Kik azok a dolgozók, akiknek a f?nöke KING? (nem leolvasva)
SELECT d1.dnev FROM dolgozo d1 , dolgozo d2 WHERE d1.fonoke = d2.dkod AND d2.dnev = 'KING';

--Adjuk meg azoknak a f?nököknek a nevét, akiknek a foglalkozása nem 'MANAGER' (dnev)
SELECT d2.dnev FROM dolgozo d1 , dolgozo d2 WHERE d1.fonoke = d2.dkod 
MINUS
SELECT dnev from dolgozo WHERE foglalkozas='MANAGER';

--Adjuk meg azokat a dolgozókat, akik többet keresnek a f?nöküknél.
SELECT d1.dnev FROM dolgozo d1, dolgozo d2 WHERE d1.fizetes > d2.fizetes AND d1.fonoke = d2.dkod;

--Kik azok a dolgozók, akik f?nökének a f?nöke KING?
SELECT d1.dnev FROM dolgozo d1, dolgozo d2, dolgozo d3 WHERE d1.fonoke = d2.dkod AND d2.fonoke = d3.dkod AND d3.dnev = 'KING';

--Kik szeretnek minden gyümölcsöt
