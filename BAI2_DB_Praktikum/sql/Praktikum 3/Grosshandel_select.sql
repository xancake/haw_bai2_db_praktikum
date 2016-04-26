SELECT * FROM Kunde;
SELECT * FROM Produkt;
SELECT * FROM Bestellung;
SELECT * FROM Bestellposition;
SELECT * FROM Lieferant;
SELECT * FROM Kondition;

-- a) Anzahl der von uns geführten Produkte
SELECT COUNT(*) FROM Produkt;

-- b) Bezeichnungen aller Produkte in der ABC-Klasse A, aufsteigend sortiert
SELECT Bezeichnung FROM Produkt WHERE ABCKlassifikation = 'A' ORDER BY Bezeichnung ASC;

-- c) Nummer des Lieferanten der Produkt 100 am günstigsten anbietet
SELECT lID FROM Kondition WHERE pID=100 AND EKPreis <= (SELECT MIN(EKPreis) FROM Kondition WHERE pID=100);

-- d) Namen der Kunden, die in einer Stadt wohnen, die Burg in ihrem Namen führt
SELECT Vorname, Nachname FROM Kunde WHERE Ort LIKE '%burg%' OR Ort LIKE '%Burg%';

-- e) Durchschnittspreis der Konditionen von Produkt 111
SELECT AVG(EKPreis) FROM Kondition WHERE pID=111;

-- f) Anzahl der Bestellpositionen zu jeder Bestellung
SELECT bID, COUNT(*) FROM Bestellposition GROUP BY bID;

-- g) Gesamtwert der Bestellpositionen pro Kunde
SELECT k.kdID, Vorname, Nachname, SUM(Preis)
FROM Kunde k
  INNER JOIN Bestellung b ON k.kdID=b.kdID
  INNER JOIN Bestellposition bp ON b.bID=bp.bID
GROUP BY k.kdID, Vorname, Nachname;

-- h) Bezeichnung der Produkte, für den Kunden mit dem Vornamen "Borch"
SELECT Bezeichnung
FROM Produkt p
  INNER JOIN Bestellposition bp ON p.pID=bp.pID
  INNER JOIN Bestellung b ON bp.bID=b.bID
  INNER JOIN Kunde k ON b.kdID=k.kdID
WHERE Vorname='Borch';