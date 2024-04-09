SELECT * FROM dolgozo;
 
SELECT * FROM osztaly;

SELECT * FROM fiz_kategoria;

--Null �rt�k vizsg�lat�ra IS kulcssz� (=, !=, >, < nem �rtelmes)
SELECT * FROM dolgozo WHERE null IS null;

--Lek�rdezz�k a fizet�s dupl�j�t
SELECT dnev, fizetes * 2 FROM dolgozo;

--Feladatok: (gyakorlat 2 p�tl�s)
--Kik azok a dolgoz�k, akiknek a fizet�se nagyobb, mint 2800?
SELECT dnev FROM dolgozo WHERE fizetes > 2800;

--Kik azok a dolgoz�k, akik a 10-es vagy a 20-as oszt�lyon dolgoznak?
SELECT dnev FROM dolgozo WHERE oazon = 10
UNION
SELECT dnev FROM dolgozo WHERE oazon = 20;

--Kik azok, akiknek a jutal�ka nagyobb, mint 600?
SELECT dnev FROM dolgozo WHERE jutalek > 600;

--Kik azok, akiknek a jutal�ka nem nagyobb, mint 600?
SELECT dnev FROM dolgozo WHERE jutalek <= 600;

--Kik azok a dolgoz�k, akiknek a jutal�ka ismeretlen (nincs kit�ltve, vagyis NULL)?
SELECT dnev FROM dolgozo WHERE jutalek IS null;

--Adjuk meg a dolgoz�k k�z�tt el?fordul� foglalkoz�sok neveit.
SELECT foglalkozas FROM dolgozo;
--SELECT DISTINCT foglalkozas FROM dolgozo lesz?ri az ism�tl?d�seket.

--Adjuk meg azoknak a nev�t �s k�tszeres fizet�s�t, akik a 10-es oszt�lyon dolgoznak.
SELECT dnev, 2*fizetes FROM dolgozo WHERE oazon = 10;

--Kik azok, akiknek nincs f?n�ke?
SELECT dnev FROM dolgozo WHERE fonoke IS null;

--Kik azok a dolgoz�k, akiknek a f?n�ke KING? (egyel?re leolvasva a k�perny?r?l)
SELECT dnev FROM dolgozo WHERE fonoke = (SELECT dkod FROM dolgozo WHERE dnev = 'KING');

--Pap�rhoz m�lt�an helyes:
SELECT d1.dnev FROM dolgozo d1, dolgozo d2 WHERE d1.fonoke = d2.dkod AND d2.dnev = 'KING';
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--3. �ra anyaga:
--Descartes szorzat �s t�bla �tnevez�s:
SELECT * FROM szeret sz1, szeret sz2;
SELECT * FROM szeret sz1 CROSS JOIN szeret sz2;

--Kik szeretnek legal�bb k�tf�le gy�m�lcs�t?
SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2 WHERE sz1.nev = sz2.nev AND sz1.gyumolcs != sz2.gyumolcs;

--Kik szeretnek legal�bb h�romf�le gy�m�lcs�t?
SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3 WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev AND sz1.gyumolcs != sz2.gyumolcs AND sz2.gyumolcs = sz3.gyumolcs AND sz3.gyumolcs != sz1.gyumolcs;

--Kik szeretnek legfeljebb k�tf�le gy�m�lcs�t?
-- minden - 2. feladat
SELECT nev FROM szeret
MINUS
SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3 WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev AND sz1.gyumolcs != sz2.gyumolcs AND sz2.gyumolcs = sz3.gyumolcs AND sz3.gyumolcs != sz1.gyumolcs;

--Kik szeretnek pontosan k�tf�le gy�m�lcs�t?
--1. feladat - 2. feladat