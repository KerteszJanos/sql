task: task1
sql:
(
    (
        SELECT etterem_nev
        FROM menu
    )
    MINUS
    (
        SELECT etterem_nev
        FROM menu
        WHERE etel_nev = 'palacsinta'
    )
)
INTERSECT
(
    SELECT etterem_nev
    FROM menu
    WHERE etel_nev = 'z�lds�ges ragu'
);

task: task2
sql:
SELECT etel_nev, SUM(mennyiseg * kaloria)
FROM (menu NATURAL JOIN recept NATURAL JOIN alapanyag)
WHERE etterem_nev = 'Bety�r bisztr�'
GROUP BY etel_nev;

task: task3
sql:
SELECT etel_nev
FROM (recept NATURAL JOIN alapanyag)
GROUP BY etel_nev
HAVING SUM(mennyiseg * kaloria) < 300;


task: task4
sql:
SELECT DISTINCT etterem_nev
FROM
(
    (
        SELECT etel_nev
        FROM recept
    )
    MINUS
    (
        SELECT etel_nev
        FROM (alapanyag NATURAL JOIN recept)
        WHERE kategoria = 'tejterm�k'
    )
)
NATURAL JOIN
(
menu
);

task: task5
sql:
SELECT etel_nev
FROM recept
GROUP BY etel_nev
HAVING COUNT(*) =
(
    SELECT MIN(alapanyag_db)
    FROM
    (
        SELECT etel_nev, COUNT(*) AS alapanyag_db
        FROM recept
        GROUP BY etel_nev
    )
);




