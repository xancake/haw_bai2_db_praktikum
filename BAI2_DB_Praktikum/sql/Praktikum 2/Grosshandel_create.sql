DROP TABLE Konditionen;
DROP TABLE Lieferant;
DROP TABLE Bestellposition;
DROP TABLE Bestellung;
DROP TABLE Produkt;
DROP TABLE Kunde;

CREATE TABLE Kunde(
  kID INTEGER NOT NULL,
  Vorname VARCHAR(50),
  Nachname VARCHAR(50) NOT NULL,
  CONSTRAINT Kunde_PK PRIMARY KEY (kID)
);

CREATE TABLE Produkt(
  pID INTEGER NOT NULL,
  Kategorie VARCHAR(30),
  Preis DECIMAL(8,2) NOT NULL CHECK(Preis >= 0),
  Bezeichnung VARCHAR(200),
  CONSTRAINT Produkt_PK PRIMARY KEY (pID)
);

CREATE TABLE Bestellung(
  bID INTEGER NOT NULL,
  Datum DATE NOT NULL,
  kID INTEGER NOT NULL,
  CONSTRAINT Bestellung_PK PRIMARY KEY (bID),
  CONSTRAINT Bestellung_FK FOREIGN KEY (kID) REFERENCES Kunde(kID) ON DELETE CASCADE
);

CREATE TABLE Bestellposition(
  bID INTEGER NOT NULL,
  pID INTEGER NOT NULL,
  Menge INTEGER NOT NULL CHECK(Menge > 0),
  Preis DECIMAL(8,2) NOT NULL CHECK(Preis >= 0),
  CONSTRAINT Bestellposition_PK PRIMARY KEY (pID, bID),
  CONSTRAINT Bestellposition_FK_Bestellung FOREIGN KEY (bID) REFERENCES Bestellung(bID),
  CONSTRAINT Bestellposition_FK_Produkt FOREIGN KEY (pID) REFERENCES Produkt(pID)
);


-- Lieferant
CREATE TABLE Lieferant (
  lID INTEGER NOT NULL,
  lName varchar(50) NOT NULL,
  PLZ char(5),
  Ort varchar(50),
  Strasse varchar(50),
  CONSTRAINT Lieferant_PK PRIMARY KEY (lID)
);

CREATE TABLE Konditionen (
  lID INTEGER NOT NULL,
  pID INTEGER NOT NULL,
  EKPreis DECIMAL(8,2) NOT NULL CHECK(EKPreis >= 0),
  CONSTRAINT Konditionen_PK PRIMARY KEY (lID, pID),
  CONSTRAINT Konditionen_FK_Lieferant FOREIGN KEY (lID) REFERENCES Lieferant(lID),
  CONSTRAINT Konditionen_FK_Produkt FOREIGN KEY (pID) REFERENCES Produkt(pID)
);
