DROP TABLE Kondition;
DROP TABLE Lieferant;
DROP TABLE Bestellposition;
DROP TABLE Produkt;
DROP TABLE Bestellung;
DROP TABLE Kunde;


CREATE TABLE Kunde(
  kdID INTEGER PRIMARY KEY,
  Vorname VARCHAR(50),
  Nachname VARCHAR(50) NOT NULL,
  Ort VARCHAR(50)
);

CREATE TABLE Bestellung(
  bID INTEGER PRIMARY KEY,
  Bestelldatum DATE NOT NULL,
  kdID INTEGER NOT NULL,
  FOREIGN KEY(kdID) REFERENCES Kunde(kdID) ON DELETE CASCADE
);

CREATE TABLE Produkt(
  pID INTEGER PRIMARY KEY,
  Kategorie VARCHAR(30),
  Preis DECIMAL(8,2) NOT NULL CHECK(Preis >= 0.00),
  Bezeichnung VARCHAR(200) NOT NULL
);

ALTER TABLE Produkt ADD (ABCKlassifikation CHAR(1) NOT NULL CHECK(ABCKlassifikation IN ('A','B','C')));

CREATE TABLE Bestellposition(
  bID INTEGER NOT NULL,
  pID INTEGER NOT NULL,
  Menge INTEGER NOT NULL CHECK(Menge >= 1),
  Preis DECIMAL(8,2) NOT NULL CHECK(Preis >= 0.00),
  CONSTRAINT bpID PRIMARY KEY(pID,bID),
  FOREIGN KEY(bID) REFERENCES Bestellung(bID) ON DELETE CASCADE,
  FOREIGN KEY(pID) REFERENCES Produkt(pID) ON DELETE CASCADE
);

CREATE TABLE Lieferant (
  lID INTEGER PRIMARY KEY,
  lName VARCHAR(50) NOT NULL,
  PLZ CHAR(5),
  Ort VARCHAR(50),
  Strasse VARCHAR(50)
);

ALTER TABLE Lieferant ADD (TelefonNr VARCHAR(20));

CREATE TABLE Kondition (
  lID INTEGER NOT NULL,
  pID INTEGER NOT NULL,
  EKPreis DECIMAL(8,2) NOT NULL CHECK(EKPreis >= 0.00),
  PRIMARY KEY (lID, pID),
  FOREIGN KEY (lID) REFERENCES Lieferant(lID) ON DELETE CASCADE,
  FOREIGN KEY (pID) REFERENCES Produkt(pID) ON DELETE CASCADE
);