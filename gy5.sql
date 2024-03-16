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
--                                    gamma átírása

--HIBÁS A GROUP BY-ra
SELECT * FROM dolgozo GROUP BY oazon;
--"not a GROUP BY expression"

--Aggregáló fv-ek:
SELECT oazon, AVG(fizetes) ATL, MIN(fizetes), MAX(fizetes), COUNT (DISTINCT fizetes), SUM(fizetes) FROM dolgozo GROUP BY oazon;
--                                                                  /\
--                                                     különböz? elemeket számol meg

--Csoportképzés inplicit módon
SELECT COUNT (*) FROM dolgozo; --megszámolja a sorok számát

SELECT oazon, AVG(fizetes) FROM dolgozo GROUP BY oazon; --csoportok szerinti átlag fizu
SELECT oazon, AVG(fizetes) FROM dolgozo WHERE fizetes > 1500 GROUP BY oazon; --csoportok szerinti átlag fizetés, de csak olyan fizetéseket figyelembe véve ahol az > 1500
SELECT oazon, AVG(fizetes) FROM dolgozo WHERE fizetes > 1500 GROUP BY oazon HAVING AVG(fizetes) > 2000;
--                                                                             /\
--                                                                       gyakorlatilag a GROUP BY-ra egy feltétel (a kiértékelés után)

SELECT oazon, AVG(fizetes) FROM dolgozo WHERE fizetes > 1500 GROUP BY oazon HAVING AVG(fizetes) > 2000 ORDER BY oazon, DESC; --ADC
--                                                                                                      /\              /\     /\
--                                                                                            oszlopok rendezése     csökken?  növekv?




