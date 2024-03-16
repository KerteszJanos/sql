SELECT * FROM dolgozo;

SELECT * FROM osztaly;

SELECT * FROM fiz_kategoria;

--Null érték vizsgálatára IS kulcsszó (=, !=, >, < nem értelmes)
SELECT * FROM dolgozo WHERE null IS null;

--Lekérdezzük a fizetés dupláját
SELECT dnev, fizetes * 2 FROM dolgozo;

--Feladatok: (gyakorlat 2 pótlás)
--Kik azok a dolgozók, akiknek a fizetése nagyobb, mint 2800?
SELECT dnev FROM dolgozo WHERE fizetes > 2800;

--Kik azok a dolgozók, akik a 10-es vagy a 20-as osztályon dolgoznak?
SELECT dnev FROM dolgozo WHERE oazon = 10
UNION
SELECT dnev FROM dolgozo WHERE oazon = 20;

--Kik azok, akiknek a jutaléka nagyobb, mint 600?
SELECT dnev FROM dolgozo WHERE jutalek > 600;

--Kik azok, akiknek a jutaléka nem nagyobb, mint 600?
SELECT dnev FROM dolgozo WHERE jutalek <= 600;

--Kik azok a dolgozók, akiknek a jutaléka ismeretlen (nincs kitöltve, vagyis NULL)?
SELECT dnev FROM dolgozo WHERE jutalek IS null;

--Adjuk meg a dolgozók között el?forduló foglalkozások neveit.
SELECT foglalkozas FROM dolgozo;
--SELECT DISTINCT foglalkozas FROM dolgozo lesz?ri az ismétl?déseket.

--Adjuk meg azoknak a nevét és kétszeres fizetését, akik a 10-es osztályon dolgoznak.
SELECT dnev, 2*fizetes FROM dolgozo WHERE oazon = 10;

--Kik azok, akiknek nincs f?nöke?
SELECT dnev FROM dolgozo WHERE fonoke IS null;

--Kik azok a dolgozók, akiknek a f?nöke KING? (egyel?re leolvasva a képerny?r?l)
SELECT dnev FROM dolgozo WHERE fonoke = (SELECT dkod FROM dolgozo WHERE dnev = 'KING');

--Papírhoz méltóan helyes:
SELECT d1.dnev FROM dolgozo d1, dolgozo d2 WHERE d1.fonoke = d2.dkod AND d2.dnev = 'KING';
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--3. óra anyaga:
--Descartes szorzat és tábla átnevezés:
SELECT * FROM szeret sz1, szeret sz2;
SELECT * FROM szeret sz1 CROSS JOIN szeret sz2;

--Kik szeretnek legalább kétféle gyümölcsöt?
SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2 WHERE sz1.nev = sz2.nev AND sz1.gyumolcs != sz2.gyumolcs;

--Kik szeretnek legalább háromféle gyümölcsöt?
SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3 WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev AND sz1.gyumolcs != sz2.gyumolcs AND sz2.gyumolcs = sz3.gyumolcs AND sz3.gyumolcs != sz1.gyumolcs;

--Kik szeretnek legfeljebb kétféle gyümölcsöt?
-- minden - 2. feladat
SELECT nev FROM szeret
MINUS
SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3 WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev AND sz1.gyumolcs != sz2.gyumolcs AND sz2.gyumolcs = sz3.gyumolcs AND sz3.gyumolcs != sz1.gyumolcs;

--Kik szeretnek pontosan kétféle gyümölcsöt?
--1. feladat - 2. feladat