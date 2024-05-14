--AlÃ¡bb nÃ©mely feladathoz szÃ¼ksÃ©ges sÃ©mÃ¡t lÃ©trehozÃ³ utasÃ­tÃ¡sok talÃ¡lhatÃ³ak.
--Ezeket az utasÃ­tÃ¡sokat megvÃ¡ltoztathatod, Ã©s akÃ¡r Ãºjabb parancsokat is Ã­rhatsz ide.
--Az els? task direktÃ­va el?tt elhelyezett szÃ¶vegek nem befolyÃ¡soljÃ¡k az automata Ã©rtÃ©kelÃ©st

CREATE TABLE magassagok(
  x INT PRIMARY KEY,
  y INT
);

INSERT INTO magassagok VALUES(3,1);
INSERT INTO magassagok VALUES(5,20);
INSERT INTO magassagok VALUES(9,25);
INSERT INTO magassagok VALUES(4,10);
INSERT INTO magassagok VALUES(7,10);
INSERT INTO magassagok VALUES(1,1);
INSERT INTO magassagok VALUES(2,1);
INSERT INTO magassagok VALUES(10,30);
INSERT INTO magassagok VALUES(6,20);
INSERT INTO magassagok VALUES(8,22);
INSERT INTO magassagok VALUES(11,25);
/

--task: palindrom
--sql:
--Ã�rj PL/SQL fÃ¼ggvÃ©nyt palindrom nÃ©ven, mely 1 bemen? paramÃ©tert kap Ã©s visszaadja, hogy a szÃ³ palindrom-e (vagyis ugyanaz-e visszafelÃ© leÃ­rva)! Pl.: ZH2('dagad') => 1, ZH2('alma') => 0
CREATE OR REPLACE FUNCTION palindrom(input_string IN VARCHAR2) RETURN NUMBER IS
    reversed_string VARCHAR2(100);
BEGIN
    FOR i IN REVERSE 1..LENGTH(input_string) LOOP
        reversed_string := reversed_string || SUBSTR(input_string, i, 1);
    END LOOP;
    
    IF input_string = reversed_string THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;
/
SELECT palindrom('dagad') FROM dual;
/
--task: csucsok
--sql:
--Ã�rj PL/SQL fÃ¼ggvÃ©nyt csucsok nÃ©ven, amely megadja, hogy hÃ¡ny csÃºcs van az adatok kÃ¶zÃ¶tt! Egy pont akkor csÃºcs, ha az el?tte Ã©s utÃ¡na lÃ©v? X koordinÃ¡tÃ¡n is kisebb magassÃ¡gÃ©rtÃ©k szerepel. (pl: (11,1) (12,2) (13,3) (14,1) koordinÃ¡tÃ¡k esetÃ©n a csÃºcsok szÃ¡ma 1, ami a (13,3) ponton van)
CREATE OR REPLACE FUNCTION csucsok RETURN INT IS 
    CURSOR curs IS SELECT * FROM magassagok;
    ctr INT;
    prev INT;
    prevprev INT;
BEGIN
    ctr := 0;
    prev := -1;
    prevprev := -1;
    FOR rec IN curs LOOP
        IF prev = -1 THEN
            prev := rec.x;
        ELSIF prevprev = -1 THEN
            prevprev := rec.x;
        ELSE
            IF prev < prevprev AND prevprev > rec.x THEN
                ctr := ctr +1;
            END IF;
        END IF;
        prev := prevprev;
        prevprev := rec.x;
    END LOOP; 
    RETURN ctr; 
END csucsok;
/
SELECT csucsok() FROM dual;
/
--task: hegyoldal
--sql:
--Ã�rj PL/SQL fÃ¼ggvÃ©nyt hegyoldal nÃ©ven, amely megadja a leghoszabb emelked? hegyoldal hosszÃ¡t! Egy sorozat akkor hegyoldal, ha az X koordinÃ¡tÃ¡kon egymÃ¡s utÃ¡n egyre magasabb Ã©rtÃ©kek szerepelnek. (pl: (11,1) (12,2) (13,3) (14,1) koordinÃ¡tÃ¡k esetÃ©n a legnagyobb hegyoldal 3 hosszÃº)
CREATE OR REPLACE FUNCTION hegyoldal RETURN INT IS 
    CURSOR curs IS SELECT * FROM magassagok;
    prev INT;
    ctr INT;
    maxEmel INT;
BEGIN
    ctr := 0;
    maxEmel := 0;
    prev := -1;
    FOR rec IN curs LOOP
        IF prev = -1 THEN
            prev := rec.x;
        ELSE
            IF prev < rec.x THEN
                ctr := ctr + 1;
                IF ctr > maxEmel THEN
                    maxEmel := ctr;
                END IF;
            ELSE
                ctr := 0;
            END IF;
        END IF;
        prev := rec.x;
    END LOOP; 
    RETURN maxEmel; 
END hegyoldal;
/
SELECT hegyoldal() FROM dual;

--task: autok_letrehozas
--sql:
--Hozz lÃ©tre egy autok nev? tÃ¡blÃ¡t, amely autÃ³k adatait tartalmazza (rendszam : szÃ¶veg, tulajdonos : szÃ¶veg, birsag : szÃ¡m). Rendelj a tÃ¡blÃ¡hoz Ã©rtelmes els?dleges kulcsot!
CREATE TABLE autok  
( 
    rendszam VARCHAR2(20) PRIMARY KEY, 
    tulajdonos VARCHAR2(20), 
    birsag INT
);
--SELECT * FROM autok;
--task: traffipax_letrehozas
--sql:
--Hozz lÃ©tre egy traffipax nev? tÃ¡blÃ¡t, amely traffipaxok mÃ©rÃ©si adatait tartalmazza (rendszam : szÃ¶veg, x (x. kilomÃ©terk? az autÃ³pÃ¡lyÃ¡n) : szÃ¡m, ido (x. kilomÃ©terk? elÃ©rÃ©sÃ©nek ideje mÃ¡sodpercben) : szÃ¡m). Rendelj a tÃ¡blÃ¡hoz Ã©rtelmes idegen kulcsot!
CREATE TABLE traffipax  
( 
    rendszam VARCHAR2(20),
    x INT,
    ido INT,
    CONSTRAINT rendszam_fk FOREIGN KEY (rendszam) REFERENCES autok(rendszam)
);
--SELECT * FROM traffipax;

--task: elso_auto
--sql:
--Az els? tÃ¡blÃ¡ba vegyÃ©l fel 3 autÃ³t tetsz?leges Ã©rtelmes adatokkal. A bÃ­rsÃ¡g mez? mindhÃ¡rom jÃ¡rm? esetÃ©ben legyen 0.
INSERT INTO autok VALUES ('AAA-000', 'Jani', 0);

--task: masodik_auto
--sql:
INSERT INTO autok VALUES ('BBB-111', 'Georgi', 0);

--task: harmadik_auto
--sql:
INSERT INTO autok VALUES ('CCC-222', 'Ati', 0);
--SELECT * FROM autok;

--task: elso_traffipax
--sql:
--A mÃ¡sodik tÃ¡blÃ¡ban, kett? kivÃ¡lasztott autÃ³hoz vedd fel az x=0 ido=0 sorokat, valamint 3-3 tetsz?leges x Ã©s id? Ã©rtÃ©ket. A harmadik autÃ³hoz ne vegyÃ©l fel semmit.
INSERT INTO traffipax VALUES ('AAA-000', 0, 0);


--task: masodik_traffipax
--sql:
INSERT INTO traffipax VALUES ('BBB-111', 0, 0);



--task: harmadik_traffipax
--sql:
INSERT INTO traffipax VALUES ('AAA-000', 1, 1);


--task: negyedik_traffipax
--sql:
INSERT INTO traffipax VALUES ('AAA-000', 2, 2);


--task: otodik_traffipax
--sql:
INSERT INTO traffipax VALUES ('AAA-000', 3, 3);


--task: hatodik_traffipax
--sql:
INSERT INTO traffipax VALUES ('BBB-111', 4, 4);


--task: hetedik_traffipax
--sql:
INSERT INTO traffipax VALUES ('BBB-111', 5, 5);


--task: nyolcadik_traffipax
--sql:
INSERT INTO traffipax VALUES ('BBB-111', 6, 6);
--SELECT * FROM traffipax;

--task: felesleges_traffipax_torles
--sql:
--Ã�rj egy tÃ¶rl? utasÃ­tÃ¡st ami minden olyan autÃ³t tÃ¶rÃ¶l a rendszerb?l amihez nem tartozik traffipax bejegyzÃ©s Ã©s a bÃ­rsÃ¡g Ã©rtÃ©ke 0.
--DELETE FROM autok WHERE 

--task: traffi
--sql:
--Ã�rj PL/SQL fÃ¼ggvÃ©nyt traffi nÃ©ven, ami kiszÃ¡mÃ­tja a lÃ©trehozott tÃ¡blÃ¡bÃ³l a tÃ¡volsÃ¡gok Ã©s id?k alapjÃ¡n, hogy ki Ã©s milyen hosszan lÃ©pte tÃºl a sebessÃ©gkorlÃ¡tozÃ¡st (130km/h -> 130/3600km/s), minden km-Ã©rt amit az autÃ³ gyorshajtÃ¡ssal tÃ¶ltÃ¶tt adjon 1500Ft-os bÃ­rsÃ¡got. A fÃ¼ggvÃ©ny tÃ©rjen vissza az Ã¶sszes autÃ³ra kiszabott bÃ­rsÃ¡gok Ã¶sszegÃ©vel.
--Pl.: ('aaa-111', 0,0), ('aaa-111',10,150) bejegyzÃ©sek esetÃ©n: Az autÃ³ 150 mÃ¡sodperc alatt 10 km-t tett meg, tehÃ¡t 240 km/h-val ment. 10 km gyorshajtÃ¡s miatt 10*1500 bÃ¼ntetÃ©st adunk hozzÃ¡ a jelenlegi Ã©rtÃ©khez az autÃ³ tÃ¡blÃ¡ban.
--(Amennyiben az el?z? feladatot nem sikerÃ¼lt megoldanud, kÃ©szÃ­ts mÃ¡solatot a vpetya.traffipax Ã©s vpetya.autok tÃ¡blÃ¡rÃ³l. A mÃ¡solÃ¡shoz hasznÃ¡lt fÃ¼ggvÃ©nyt nem kell beadnod)
Ennek a szÃ¶vegnek a helyÃ©re Ã­rd az utasÃ­tÃ¡st, amely lÃ©trehozza a PL/SQL fÃ¼ggvÃ©nyt!

