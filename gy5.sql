SELECT * FROM dolgozo , osztaly WHERE dolgozo.oazon = osztaly.oazon;
 
SELECT * FROM dolgozo NATURAL JOIN osztaly;


SELECT * FROM dolgozo NATURAL JOIN dolgozo d1;
SELECT * FROM dolgozo JOIN osztaly ON dolgozo.oazon = osztaly.oazon;

SELECT * FROM dolgozo LEFT OUTER JOIN osztaly ON dolgozo.oazon = osztaly.oazon;
--               /\
--         ezeket tartjuk meg

SELECT * FROM dolgozo RIGHT OUTER JOIN osztaly ON dolgozo.oazon = osztaly.oazon;
--                                       /\
--                              ezeket tartjuk meg

SELECT * FROM dolgozo FULL OUTER JOIN osztaly ON dolgozo.oazon = osztaly.oazon;

--------------------------------------------------------------------------------------------------------------------------------
SELECT oazon, AVG(fizetes) FROM dolgozo GROUP BY oazon;
--                                         /\
--                                    gamma �t�r�sa

--HIB�S A GROUP BY-ra
SELECT * FROM dolgozo GROUP BY oazon;
--"not a GROUP BY expression"

--Aggreg�l� fv-ek:
SELECT oazon, AVG(fizetes) ATL, MIN(fizetes), MAX(fizetes), COUNT (DISTINCT fizetes), SUM(fizetes) FROM dolgozo GROUP BY oazon;
--                                                                  /\
--                                                     k�l�nb�z? elemeket sz�mol meg

--Csoportk�pz�s inplicit m�don
SELECT COUNT (*) FROM dolgozo; --megsz�molja a sorok sz�m�t

SELECT oazon, AVG(fizetes) FROM dolgozo GROUP BY oazon; --csoportok szerinti �tlag fizu
SELECT oazon, AVG(fizetes) FROM dolgozo WHERE fizetes > 1500 GROUP BY oazon; --csoportok szerinti �tlag fizet�s, de csak olyan fizet�seket figyelembe v�ve ahol az > 1500
SELECT oazon, AVG(fizetes) FROM dolgozo WHERE fizetes > 1500 GROUP BY oazon HAVING AVG(fizetes) > 2000;
--                                                                             /\
--                                                                       gyakorlatilag a GROUP BY-ra egy felt�tel (a ki�rt�kel�s ut�n)

SELECT oazon, AVG(fizetes) FROM dolgozo WHERE fizetes > 1500 GROUP BY oazon HAVING AVG(fizetes) > 2000 ORDER BY oazon, DESC; --ADC
--                                                                                                      /\              /\     /\
--                                                                                            oszlopok rendez�se     cs�kken?  n�vekv?




