
--Melyek azok a gyümölcsök, amelyeket Micimackó nem szeret? (de valaki más igen)
SELECT nev FROM szeret
    MINUS
SELECT nev FROM szeret 
        WHERE gyumolcs = 'körte';
        
--Kik szeretik az almát?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma';
        
--Kik nem szeretik a körtét? (de valami mást igen)
SELECT nev FROM szeret
    MINUS
SELECT nev FROM szeret
        WHERE gyumolcs = 'körte';
        
--Kik szeretik vagy az almát vagy a körtét?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma'
UNION
SELECT nev FROM szeret
        WHERE gyumolcs = 'körte';
        
--Kik szeretik az almát is és a körtét is?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma'
INTERSECT
SELECT nev FROM szeret
        WHERE gyumolcs = 'körte';
        
--Kik azok, akik szeretik az almát, de nem szeretik a körtét?
SELECT nev FROM szeret
        WHERE gyumolcs = 'alma'
INTERSECT
(SELECT nev FROM szeret
MINUS
SELECT nev FROM szeret
        WHERE gyumolcs = 'körte');
