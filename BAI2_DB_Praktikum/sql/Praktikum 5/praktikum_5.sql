----- DBP 5.1
DROP VIEW ATeile;
CREATE VIEW ATeile AS
  SELECT * FROM Produkt WHERE ABCKlassifikation = 'A';

DROP VIEW NameBez;
CREATE VIEW NameBez AS 
  SELECT p.Bezeichnung, l.LName 
  FROM Produkt p
    INNER JOIN Kondition k ON p.PID=k.PID
    INNER JOIN Lieferant l ON k.LID=l.LID;

DROP VIEW BestellPositionsAnzahl;
CREATE VIEW BestellPositionsAnzahl AS
  SELECT b.BID, COUNT(bp.PID) Bestellpositionen
  FROM Bestellung b
    INNER JOIN Bestellposition bp ON b.BID=bp.BID
  GROUP BY b.BID;

----- DBP 5.2
SELECT * FROM ATeile;
SELECT * FROM NameBez;
SELECT * FROM BestellPositionsAnzahl;

----- DBP 5.3
INSERT INTO ATeile VALUES (113,'Elektronik', 42.00, 'Tolle Tastatur','A',5); --JA
UPDATE ATeile SET Preis=50 WHERE PID=113; --JA
DELETE FROM ATeile WHERE PID=103; --JA

INSERT INTO NameBez VALUES ('LOL','Whatever'); --NEIN
UPDATE NameBez SET Bezeichnung='Whatever' WHERE LName='Alternate'; --NEIN
DELETE FROM NameBez WHERE Bezeichnung='WLAN-Kabel'; --JA

INSERT INTO BestellPositionsAnzahl VALUES (13370,100); --NEIN
UPDATE BestellPositionsAnzahl SET Bestellpositionen=10 WHERE BID=10000; --NEIN
DELETE FROM BestellPositionsAnzahl WHERE BID=10000; --NEIN

----- DBP 5.4

-- 4.1 Tabelle Anlegen
CREATE TABLE Geschaeftspartner (
  partnerID INTEGER NOT NULL,
  plz VARCHAR(5),
  ort VARCHAR(35),
  strasse VARCHAR(50),
  telefonnr VARCHAR(20),
  migrationID INTEGER, -- ID der migrierten Datensätze; fällt nach der Migration wieder raus
  PRIMARY KEY (partnerID)
);

CREATE SEQUENCE gp_seq;

-- Kunden um PLZ, Strasse und TelefonNr erweitern (mit etwas Varianz) für realistische Migration
ALTER TABLE Kunde ADD (plz VARCHAR(5), strasse VARCHAR(50), telefonnr VARCHAR(20));
UPDATE Kunde SET strasse='Leetstreet 1337';
UPDATE Kunde SET plz='21000', strasse='Hamburger Strasse' WHERE ort='Hamburg';
UPDATE Kunde SET plz='71289', strasse='Platz des himmlischen Friedens', telefonnr='0190 / 666 666' WHERE vorname='Mao';

-- Gemeinsame Daten aus Kunde nach Geschaeftspartner migrieren und danach aufräumen
ALTER TABLE Kunde ADD (gpID INTEGER);
INSERT INTO Geschaeftspartner (partnerID, plz, ort, strasse, telefonnr, migrationID) (SELECT gp_seq.nextval, plz, ort, strasse, telefonnr, kdID FROM Kunde);
UPDATE Kunde SET gpID=(SELECT partnerID FROM Geschaeftspartner WHERE kdID=migrationID);
UPDATE Geschaeftspartner SET migrationID=NULL;
ALTER TABLE Kunde DROP (plz, ort, strasse, telefonnr);
ALTER TABLE Kunde ADD CONSTRAINT kgp_fk FOREIGN KEY (gpID) REFERENCES Geschaeftspartner(partnerID);

-- Gemeinsame Daten aus Lieferant nach Geschaeftspartner migrieren und danach aufräumen
ALTER TABLE Lieferant ADD (gpID INTEGER);
INSERT INTO Geschaeftspartner (partnerID, plz, ort, strasse, telefonnr, migrationID) (SELECT gp_seq.nextval, plz, ort, strasse, telefonnr, lID FROM Lieferant);
UPDATE Lieferant SET gpID=(SELECT partnerID FROM Geschaeftspartner WHERE lID=migrationID);
UPDATE Geschaeftspartner SET migrationID=NULL;
ALTER TABLE Lieferant DROP (plz, ort, strasse, telefonnr);
ALTER TABLE Lieferant ADD CONSTRAINT lgp_fk FOREIGN KEY (gpID) REFERENCES Geschaeftspartner(partnerID);

-- Migrations-Feld löschen
ALTER TABLE Geschaeftspartner DROP (migrationID);

-- Lieferant soll eine zweite eigene Spalte besitzen
ALTER TABLE Lieferant ADD (wertung INTEGER CHECK(wertung>0 AND wertung<=10));
UPDATE Lieferant SET wertung=9 WHERE lID=3000;
UPDATE Lieferant SET wertung=5 WHERE lID=3001;
UPDATE Lieferant SET wertung=9 WHERE lID=3002;
UPDATE Lieferant SET wertung=7 WHERE lID=3003;
UPDATE Lieferant SET wertung=2 WHERE lID=3004;

-- Kunde und Lieferant umbenennen
ALTER TABLE Kunde RENAME TO Kundendaten;
ALTER TABLE Lieferant RENAME TO Lieferantendaten;

-- Views für die Tabellen Kunde und Lieferant anlegen
CREATE VIEW Kunde AS (SELECT kdID, vorname, nachname, partnerid, plz, ort, strasse, telefonnr FROM Kundendaten k INNER JOIN Geschaeftspartner gp ON k.gpID=gp.partnerID);
CREATE VIEW Lieferant AS (SELECT lid, lname, wertung, partnerid, plz, ort, strasse, telefonnr FROM Lieferantendaten l INNER JOIN Geschaeftspartner gp ON l.gpID=gp.partnerID);

-- SELECTs
SELECT * FROM Kunde;
SELECT * FROM Lieferant;
SELECT * FROM Geschaeftspartner;

-- 2.d) Namen der Kunden, die in einer Stadt wohnen, die Burg in ihrem Namen führt
SELECT Vorname, Nachname FROM Kunde WHERE Ort LIKE '%burg%' OR Ort LIKE '%Burg%';

-- 2.h) Bezeichnung der Produkte, für den Kunden mit dem Vornamen "Borch"
SELECT Bezeichnung
FROM Produkt p
  INNER JOIN Bestellposition bp ON p.pID=bp.pID
  INNER JOIN Bestellung b ON bp.bID=b.bID
  INNER JOIN Kunde k ON b.kdID=k.kdID
WHERE Vorname='Borch';

