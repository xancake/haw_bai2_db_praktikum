-- SELECTs
SELECT * FROM Produkt;
SELECT * FROM Kunde;
SELECT * FROM Bestellung;
SELECT * FROM Bestellposition;
SELECT * FROM Kondition;
SELECT * FROM Lieferant;

-- Aufbereitung des Datenbestands, damit die SELECTs auch alle Ergebnisse liefern
INSERT INTO Produkt VALUES(112,'Elektronik',338.97,'Intel i7 Quad Core 3,4 GHz', 'A', 10);
INSERT INTO Bestellung VALUES(10006,TO_DATE('15-05-2011', 'DD-MM-YYYY'),1003);
INSERT INTO Bestellposition VALUES(10006,100,1,1.00);
INSERT INTO Bestellposition VALUES(10006,101,1,1.00);
INSERT INTO Bestellposition VALUES(10006,102,1,1.00);
INSERT INTO Bestellposition VALUES(10006,103,1,1.00);
INSERT INTO Bestellposition VALUES(10006,104,1,1.00);
INSERT INTO Bestellposition VALUES(10006,105,1,1.00);
INSERT INTO Bestellung VALUES(10007,TO_DATE('06-02-2012', 'DD-MM-YYYY'),1003);
INSERT INTO Bestellposition VALUES(10007,106,1,1.00);
INSERT INTO Bestellposition VALUES(10007,107,1,1.00);
INSERT INTO Bestellposition VALUES(10007,108,1,1.00);
INSERT INTO Bestellposition VALUES(10007,109,1,1.00);
INSERT INTO Bestellung VALUES(10008,TO_DATE('06-02-2013', 'DD-MM-YYYY'),1003);
INSERT INTO Bestellposition VALUES(10008,110,1,1.00);
INSERT INTO Bestellposition VALUES(10008,111,1,1.00);
INSERT INTO Bestellposition VALUES(10008,112,1,1.00);


-- 1. 
---- Lagerbestand hinzufügen
ALTER TABLE Produkt ADD (Lagerbestand INTEGER);
UPDATE Produkt SET Lagerbestand=10 WHERE ABCKlassifikation='A';
UPDATE Produkt SET Lagerbestand=50 WHERE ABCKlassifikation='B';
UPDATE Produkt SET Lagerbestand=10 WHERE ABCKlassifikation='C';

---- Gesamtwert gelagerter Produkte
SELECT SUM(kleinsterpreis*Lagerbestand)
FROM Produkt p
  INNER JOIN (
    SELECT k.pID, MIN(EKPreis) AS kleinsterpreis
    FROM Kondition k
    GROUP BY k.pID
) x ON p.pID=x.pID;

-- 2. Namen der Kunden die Produkte bestellt haben, die der Lieferant mit dem Namen "Alternate" führt
SELECT DISTINCT Vorname, Nachname
FROM Kunde k
  INNER JOIN Bestellung b ON k. kdID=b.kdID
  INNER JOIN Bestellposition bp ON b.bID=bp.bID
  INNER JOIN Produkt p ON bp.pID=p.pID
  INNER JOIN Kondition k ON p.pID=k.pID
  INNER JOIN Lieferant l ON k.lID=l.lID
WHERE l.lname='Alternate';

-- 3. Produkte mit selbem Verkaufspreis wie das Teil mit ID=100
SELECT *
FROM Produkt a
  INNER JOIN Produkt b ON a.preis=b.preis
WHERE b.pID=100;

-- 4. Kunden mit Bestellungen
---- Join
SELECT DISTINCT k.*
FROM Kunde k
  INNER JOIN Bestellung b ON k.kdID=b.kdID;

---- Subquery
SELECT *
FROM Kunde k
WHERE k.kdID IN (
  SELECT b.kdID
  FROM Bestellung b
);

---- Exists
SELECT *
FROM Kunde k
WHERE EXISTS (
  SELECT b.kdID
  FROM Bestellung b
  WHERE k.kdID=b.kdID
);

-- 5. Kunden ohne Bestellungen
---- Join
SELECT k.*
FROM Kunde k
  LEFT JOIN Bestellung b ON k.kdID=b.kdID
WHERE b.BID IS NULL;

---- Subquery
SELECT *
FROM Kunde k
WHERE NOT k.kdID IN (
  SELECT b.kdID
  FROM Bestellung b
);

---- Exists
SELECT *
FROM Kunde k
WHERE NOT EXISTS (
  SELECT b.kdID
  FROM Bestellung b
  WHERE k.kdID=b.kdID
);

-- 6. Produkte mit Klassifikation 'B' die der Lieferant 3002 nicht anbietet
SELECT *
FROM Produkt p
WHERE ABCKlassifikation='B' AND p.pID NOT IN (
  SELECT k.pID
  FROM Kondition k
  WHERE k.lID=3002
);

-- 7. Namen und Anzahl der A-, B- und C-Produkte pro Lieferant
SELECT l.lName, p.ABCKlassifikation, COUNT(p.pID)
FROM Lieferant l
  INNER JOIN Kondition k ON l.lID=k.lID
  INNER JOIN Produkt p ON k.pID=p.pID
GROUP BY l.lName, p.ABCKlassifikation
ORDER BY l.lName, p.ABCKlassifikation;

-- 8. Namen der Kunden, die ALLE Produkte bestellt haben
SELECT k.Vorname, k.Nachname
FROM Kunde k
  INNER JOIN Bestellung b ON k.kdID=b.kdID
  INNER JOIN Bestellposition bp ON b.bID=bp.bID
GROUP BY k.Vorname, k.Nachname
  HAVING COUNT(bp.pID) = (
    SELECT COUNT(pID)
    FROM Produkt
);

-- 9. Produkte in Kategorien 'billig', 'mittel' und 'teuer' kategorisiert (zusatz: sortiert nach der Preisklasse
SELECT pID, bezeichnung, (CASE WHEN preis < 10 THEN 'billig'
                               WHEN preis < 100 THEN 'mittel'
                               ELSE 'teuer' END) AS preisklasse
FROM Produkt
ORDER BY preisklasse;

-- 10. Produkte mit ihrem Bestelldatum auflisten, wobei noch nie bestellte Produkte ebenfalls aufgelistet werden sollen
SELECT p.bezeichnung, b.bestelldatum
FROM Produkt p
  LEFT JOIN Bestellposition bp ON p.pID=bp.pID
  LEFT JOIN Bestellung b ON bp.bID=b.bID;

