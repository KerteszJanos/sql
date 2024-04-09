 
--Melyek azok a gy�m�lcs�k, amelyeket Micimack� nem szeret? (de valaki m�s igen)
SELECT nev FROM szeret
    MINUS
SELECT nev FROM szeret 
        WHERE gyumolcs = 'k�rte';
        
--Kik szeretik az alm�t?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma';
        
--Kik nem szeretik a k�rt�t? (de valami m�st igen)
SELECT nev FROM szeret
    MINUS
SELECT nev FROM szeret
        WHERE gyumolcs = 'k�rte';
        
--Kik szeretik vagy az alm�t vagy a k�rt�t?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma'
UNION
SELECT nev FROM szeret
        WHERE gyumolcs = 'k�rte';
        
--Kik szeretik az alm�t is �s a k�rt�t is?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma'
INTERSECT
SELECT nev FROM szeret
        WHERE gyumolcs = 'k�rte';
        
--Kik azok, akik szeretik az alm�t, de nem szeretik a k�rt�t?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma'
INTERSECT
(SELECT nev FROM szeret
MINUS
SELECT nev FROM szeret
        WHERE gyumolcs = 'k�rte');
