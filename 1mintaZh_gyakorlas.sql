drop table got_hazak;
drop table got_karakterek;
drop table got_csatak;

create table got_hazak (
    haz_nev varchar2(20) PRIMARY KEY,
    motto varchar2(200)
);

create table got_karakterek (
    nev varchar2(20) PRIMARY KEY,
    vagyon number,
    haz_nev varchar2(20),
    sereg number
);

create table got_csatak (
    haz_nev varchar2(20),
    csata_nev varchar2(20),
    gyozott varchar2(10),
    CONSTRAINT pk_got_csatak PRIMARY KEY (haz_nev, csata_nev)
);

insert into got_csatak values('Stark', 'Fattyak csatája', 'igen');
insert into got_csatak values('Bolton', 'Fattyak csatája', 'nem');
insert into got_csatak values('Arryn', 'Fattyak csatája', 'igen');
insert into got_csatak values('Frey', 'Vörös nász', 'igen');
insert into got_csatak values('Stark', 'Vörös nász', 'nem');
insert into got_csatak values('Stark', 'Trident-i csata','igen');
insert into got_csatak values('Baratheon', 'Trident-i csata','igen');
insert into got_csatak values('Targaryen', 'Trident-i csata','nem');
insert into got_csatak values('Stark', 'Harangok csatája','igen');
insert into got_csatak values('Baratheon', 'Harangok csatája','igen');
insert into got_csatak values('Targaryen', 'Harangok csatája','nem');
--insert into got_csatak values('Lannister', 'Feketevízi csata', 'igen');
--insert into got_csatak values('Baratheon', 'Feketevízi csata', 'nem');
--insert into got_csatak values('Targaryen', 'Goldroad-i csata', 'igen');
--insert into got_csatak values('Lannister', 'Goldroad-i csata', 'nem');

insert into got_hazak values('Targaryen', 'Tűz és vér');
insert into got_hazak values('Baratheon','Miénk a harag');
insert into got_hazak values('Stark','Közeleg a tél');
insert into got_hazak values('Lannister','Halld üvöltésem');
insert into got_hazak values('Grejyoy','Mi nem vetünk');
insert into got_hazak values('Tully','Család, kötelesség, becsület');
insert into got_hazak values('Martell','Meg nem hajol, meg nem rogy, meg nem törik');
insert into got_hazak values('Tyrell', 'Erőssé növünk');
insert into got_hazak values('Bolton', 'Pengéink élesek');
insert into got_hazak values('Arryn', 'Hatalmas, mint a becsület');

insert into got_karakterek values('Eddard Stark', 2000, 'Stark', 1000);
insert into got_karakterek values('Robb Stark', 7000, 'Stark', 5000);
insert into got_karakterek values('Catelyn Stark',1500,'Stark',200);
insert into got_karakterek values('Robert Baratheon',4000,'Baratheon',4000);
insert into got_karakterek values('Stannis Baratheon',6000,'Baratheon',4000);
insert into got_karakterek values('Jaime Lannister',5000,'Lannister',null);
insert into got_karakterek values('Tywin Lannister', 150000, 'Lannister', 6000);
insert into got_karakterek values('Tyrion Lannister', 2000, 'Lannister', 0);
insert into got_karakterek values('Cersei Lannister',5000,'Lannister',5000);
insert into got_karakterek values('Viserys Targaryen', 200, 'Targaryen', null);
insert into got_karakterek values('Daenerys Targaryen',6000,'Targaryen',7000);
insert into got_karakterek values('Theon Greyjoy',null,'Greyjoy',3000);
insert into got_karakterek values('Edmure Tully',3000,'Tully',null);
insert into got_karakterek values('Oberyn Martell', null, 'Martell', 0);

COMMIT;

select * from got_karakterek;
select * from got_hazak;
select * from got_csatak;

--1/a Melyik h�znak van legal�bb k�t olyan karaktere, akik nem k�pesek a vagyonukb�l fenntartani a sereg�ket (egy katona �lelmez�se 15 arany)? (H�z_n�v)
SELECT haz_nev 
FROM got_karakterek 
WHERE vagyon < sereg 
GROUP BY haz_nev 
HAVING COUNT(*) >= 2;

--1/b Melyik h�znak van legal�bb k�t olyan karaktere, akik k�pesek a vagyonukb�l fenntartani a sereg�ket (egy katona �lelmez�se 15 arany)? (H�z_n�v)
SELECT haz_nev 
FROM got_karakterek 
WHERE vagyon >= sereg 
GROUP BY haz_nev 
HAVING COUNT(*) >= 2;



--2/a Add meg a 20000-n�l nagyobb �sszvagyonnal rendelkez? h�zak a teljes sereg�nek erej�t! Ahol a sereg m�rete ismeretlen 1000-rel sz�molj! (h�z_n�v, teljes_sereg)
SELECT haz_nev, SUM(NVL(sereg,1000)) AS teljes_sereg
FROM got_karakterek
GROUP BY haz_nev
HAVING SUM(vagyon) > 20000;

--2/b Add meg a 10000 alatti �sszvagyonnal rendelkez? h�zak a teljes sereg�nek erej�t! Ahol a sereg m�rete ismeretlen 2000-rel sz�molj! (h�z_n�v, teljes_sereg)
SELECT haz_nev, SUM(NVL(sereg,2000)) AS teljes_sereg
FROM got_karakterek
GROUP BY haz_nev
HAVING SUM(vagyon) < 10000;

--Egy m�sik szyntax a 2/a-ra !!!FONTOS!!! �gy tudunk natural joinokat pl lek�rdez�sek k�z� �rni.
SELECT haz_nev, teljes_sereg
FROM 
(
SELECT haz_nev, SUM(vagyon)
FROM got_karakterek
GROUP BY haz_nev
HAVING SUM(vagyon) > 20000
)
NATURAL JOIN
(
SELECT haz_nev, SUM(NVL(sereg,1000)) AS teljes_sereg
FROM got_karakterek
GROUP BY haz_nev
);




--3/a Add meg azt a h�zat/h�zakat, ami nem vett r�szt az �sszes csat�ban! (H�z_n�v)
SELECT haz_nev
FROM
(
SELECT SUM(COUNT(DISTINCT csata_nev)) AS osszcsat
FROM got_csatak
GROUP BY csata_nev
)
CROSS JOIN
(
SELECT haz_nev, COUNT(csata_nev) AS csatak
FROM got_csatak
GROUP BY haz_nev
)
WHERE csatak < osszcsat;

--3/b Add meg azt a h�zat/h�zakat, ami r�szt vett az �sszes csat�ban! (H�z_n�v)
SELECT haz_nev
FROM
(
SELECT SUM(COUNT(DISTINCT csata_nev)) AS osszcsat
FROM got_csatak
GROUP BY csata_nev
)
CROSS JOIN
(
SELECT haz_nev, COUNT(csata_nev) AS csatak
FROM got_csatak
GROUP BY haz_nev
)
WHERE csatak = osszcsat;

--vagy pl.:
SELECT haz_nev
FROM
(
SELECT SUM(COUNT(DISTINCT csata_nev)) AS osszcsat
FROM got_csatak
GROUP BY csata_nev
)
CROSS JOIN
(
got_csatak
)
GROUP BY haz_nev
HAVING COUNT(csata_nev) = MAX(osszcsat); --<--<--< "Ki lopjuk az inform�ci�t



--4/a Add meg az egyes h�zak legnagyobb sereggel rendelkez? karakter�t (egyenl?s�g eset�n karaktereit). (h�z_n�v, sereg, karakter)
SELECT haz_nev, sereg, nev
FROM
(
SELECT haz_nev, MAX(sereg) AS mxs
FROM got_karakterek
GROUP BY haz_nev
)
NATURAL JOIN
(
got_karakterek
)
WHERE sereg = mxs;

--4/b Add meg az egyes h�zak legkevesebb vagyonnal rendelkez? karakter�t (egyenl?s�g eset�n karaktereit). (h�z_n�v, vagyon, karakter)
SELECT haz_nev, sereg, nev
FROM
(
SELECT haz_nev, MIN(sereg) AS mns
FROM got_karakterek
GROUP BY haz_nev
)
NATURAL JOIN
(
got_karakterek
)
WHERE sereg = mns;



--5/a Add meg mi a mott�ja annak a h�znak amelyik elvesztette a legkevesebb szerepl?s (legkevesebb h�z k�z�tt zajl�) csat�t! (mott�)
SELECT DISTINCT motto
FROM
(
got_hazak
)
NATURAL JOIN
(
SELECT haz_nev
FROM
(
    got_csatak
)
CROSS JOIN
(
    SELECT csata_nev AS mincsat
    FROM got_csatak
    GROUP BY csata_nev
    HAVING COUNT(*) = 
    (
        SELECT MIN(count_column)
        FROM 
        (
            SELECT COUNT(*) AS count_column
            FROM got_csatak
            GROUP BY csata_nev
        )
    )
)
WHERE
csata_nev = mincsat AND gyozott = 'nem'
);

--5/b Add meg mi a mott�ja annak a h�znak/h�zaknak amelyik elvesz�tette a legt�bb szerepl?s (legt�bb h�z k�z�tt zajl�) csat�t! (mott�)
SELECT DISTINCT motto
FROM
(
got_hazak
)
NATURAL JOIN
(
SELECT haz_nev
FROM
(
    got_csatak
)
CROSS JOIN
(
    SELECT csata_nev AS mincsat
    FROM got_csatak
    GROUP BY csata_nev
    HAVING COUNT(*) = 
    (
        SELECT MAX(count_column)
        FROM 
        (
            SELECT COUNT(*) AS count_column
            FROM got_csatak
            GROUP BY csata_nev
        )
    )
)
WHERE
csata_nev = mincsat AND gyozott = 'nem'
);
