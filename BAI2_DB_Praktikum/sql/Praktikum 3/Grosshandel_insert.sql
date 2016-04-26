INSERT INTO Kunde VALUES(1000,'Niels','Larsen', 'Hamburg');
INSERT INTO Kunde VALUES(1001,'Borch','Lennartson', 'Hamburg');
INSERT INTO Kunde VALUES(1002,'Hans','Peter', 'Berlin');
INSERT INTO Kunde VALUES(1003,'Marie','Maulig', 'München');
INSERT INTO Kunde VALUES(1004,'Jack','Sheraq', 'Freiburg');
INSERT INTO Kunde VALUES(1005,'Wolfgang','Wehrmacht', 'Berlin');
INSERT INTO Kunde VALUES(1006,'Genghis','Khan', 'Frankfurth');
INSERT INTO Kunde VALUES(1007,'Mao','Mao', 'Dresden');
INSERT INTO Kunde VALUES(1008,'Hendrik','Vodka', 'Düsseldorf');
INSERT INTO Kunde VALUES(1009,'Putin','Obama', 'Bremen');
INSERT INTO Kunde VALUES(1010,'Jürgen','Von der Lippe', 'Stade');
INSERT INTO Kunde VALUES(1011,'Lisa','Lustig', 'Burgstadt');
INSERT INTO Kunde VALUES(1012,'','Lustig', 'Burgen');

INSERT INTO Produkt VALUES(100,'Elektronik',338.97,'MSI GTX 970 Gaming 4g 4096GB','A');
INSERT INTO Produkt VALUES(101,'Obst',1.50,'Hochwertiger Apfel aus freiland Haltung','B');
INSERT INTO Produkt VALUES(102,'PKW',26000.00,'Mazda MX-5','C');
INSERT INTO Produkt VALUES(103,'Elektronik',180.00,'Cherry Mechanical Keyboard','A');
INSERT INTO Produkt VALUES(104,'Spaßartikel',13.37,'Jimi Hendrixs Luftgitarre','C');
INSERT INTO Produkt VALUES(105,'Elektronik',12.50,'WLAN-Kabel','A');
INSERT INTO Produkt VALUES(106,'Spaßartikel',3.00,'Ring der Unantastbarkeit (+5 Dexterity)','C');
INSERT INTO Produkt VALUES(107,'Schmuck',0.99,'Der eine Ring (gebraucht)','B');
INSERT INTO Produkt VALUES(108,'Elektronik',600.00,'Samsung 4K 240HZ 50" LED Monitor','A');
INSERT INTO Produkt VALUES(109,'Badezimmerbedarf',1.00,'Ed Hardy Klobrille','C');
INSERT INTO Produkt VALUES(110,'Lernbedarf',3141.59,'Premium 50 Blatt Block (kariert)','B');
INSERT INTO Produkt VALUES(111,'',999999.99,'Mystery Gift','B');

INSERT INTO Bestellung VALUES(10000,'06-06-1944',1005);
INSERT INTO Bestellposition VALUES(10000,106,20,2.50);
INSERT INTO Bestellposition VALUES(10000,109,3,1.00);

INSERT INTO Bestellung VALUES(10001,'07-05-1206',1006);
INSERT INTO Bestellposition VALUES(10001,108,3,600.00);
INSERT INTO Bestellposition VALUES(10001,100,4,300.00);
INSERT INTO Bestellposition VALUES(10001,103,2,180.00);
INSERT INTO Bestellposition VALUES(10001,105,1,13.00);

INSERT INTO Bestellung VALUES(10002,'16-10-2014',1000);
INSERT INTO Bestellposition VALUES(10002,104,1,13.37);

INSERT INTO Bestellung VALUES(10003,'02-10-2014',1001);
INSERT INTO Bestellposition VALUES(10003,107,2,0.99);

INSERT INTO Bestellung VALUES(10004,'25-08-2010',1001);
INSERT INTO Bestellposition VALUES(10004,100,2,330.00);
INSERT INTO Bestellposition VALUES(10004,101,15,1.50);

INSERT INTO Bestellung VALUES(10005,'24-12-2014',1000);
INSERT INTO Bestellposition VALUES(10005,101,1000,0.50);
INSERT INTO Bestellposition VALUES(10005,106,1,3.00);

INSERT INTO Lieferant VALUES(3000,'Alternate','12345','Berlin','Wasweißichstrasse','040 / 123 45 67');
INSERT INTO Lieferant VALUES(3001,'Mindfactory','12346','Wilhelmshaven','Robertstrasse','+49 / 3 141 592');
INSERT INTO Lieferant VALUES(3002,'Bauer von nebenan','54321','Dorf','Dorfstrasse','040 / 1337 001');
INSERT INTO Lieferant VALUES(3003,'Weasleys Zauberhafte Zauberscherze','A00AA','London','Winkelgasse',NULL);
INSERT INTO Lieferant VALUES(3004,'Autoladen','01248','Hamburg','Fahrradstrasse','+49 / 80085 538');

INSERT INTO Kondition VALUES(3000,100,150.00);
INSERT INTO Kondition VALUES(3000,103,100.00);
INSERT INTO Kondition VALUES(3000,105,1.50);
INSERT INTO Kondition VALUES(3000,108,400.00);
INSERT INTO Kondition VALUES(3001,100,149.99);
INSERT INTO Kondition VALUES(3001,103,101.00);
INSERT INTO Kondition VALUES(3001,105,1.00);
INSERT INTO Kondition VALUES(3001,108,420.00);
INSERT INTO Kondition VALUES(3002,101,1.20);
INSERT INTO Kondition VALUES(3002,111,1.00);
INSERT INTO Kondition VALUES(3003,101,0.80);
INSERT INTO Kondition VALUES(3003,104,3.14);
INSERT INTO Kondition VALUES(3003,106,6.00);
INSERT INTO Kondition VALUES(3003,107,0.50);
INSERT INTO Kondition VALUES(3003,109,0.01);
INSERT INTO Kondition VALUES(3003,110,1.50);
INSERT INTO Kondition VALUES(3003,111,10000.00);
INSERT INTO Kondition VALUES(3004,102,20000.00);
INSERT INTO Kondition VALUES(3004,111,200.00);


-- TEST Abschnitt

INSERT INTO Produkt VALUES(420,'Schrott',-50.00,'Hey Baby von Justin Bieber','B'); -- Preis nicht negativ
INSERT INTO Produkt VALUES(421,'Schreibwaren',0.50,'Din A4 Papier','D'); -- Kategorie nicht in A, B oder C
INSERT INTO Produkt VALUES(422,'Empty',0.0,'The Void',NULL); -- Kategorie NULL
INSERT INTO Bestellposition VALUES(10005,103,0,666.42);
INSERT INTO Bestellposition VALUES(10005,106,2,-666.42);


-- Abwandlung von DATE-Inserts für Lars in Squirrel SQL

INSERT INTO Bestellung VALUES(10000,TO_DATE('06-06-1944', 'DD-MM-YYYY'),1005);
INSERT INTO Bestellposition VALUES(10000,106,20,2.50);
INSERT INTO Bestellposition VALUES(10000,109,3,1.00);

INSERT INTO Bestellung VALUES(10001,TO_DATE('07-05-1206', 'DD-MM-YYYY'),1006);
INSERT INTO Bestellposition VALUES(10001,108,3,600.00);
INSERT INTO Bestellposition VALUES(10001,100,4,300.00);
INSERT INTO Bestellposition VALUES(10001,103,2,180.00);
INSERT INTO Bestellposition VALUES(10001,105,1,13.00);

INSERT INTO Bestellung VALUES(10002,TO_DATE('16-10-2014', 'DD-MM-YYYY'),1000);
INSERT INTO Bestellposition VALUES(10002,104,1,13.37);

INSERT INTO Bestellung VALUES(10003,TO_DATE('02-10-2014', 'DD-MM-YYYY'),1001);
INSERT INTO Bestellposition VALUES(10003,107,2,0.99);

INSERT INTO Bestellung VALUES(10004,TO_DATE('25-08-2010', 'DD-MM-YYYY'),1001);
INSERT INTO Bestellposition VALUES(10004,100,2,330.00);
INSERT INTO Bestellposition VALUES(10004,101,15,1.50);

INSERT INTO Bestellung VALUES(10005,TO_DATE('24-12-2014', 'DD-MM-YYYY'),1000);
INSERT INTO Bestellposition VALUES(10005,101,1000,0.50);
INSERT INTO Bestellposition VALUES(10005,106,1,3.00);


-- Update-Abschnitt

UPDATE Produkt SET ABCKlassifikation='C';
UPDATE Produkt SET ABCKlassifikation='B' WHERE Kategorie IN ('Obst', 'Schmuck', 'Lernbedarf');
UPDATE Produkt SET ABCKlassifikation='A' WHERE Kategorie IN ('Elektronik');

UPDATE Lieferant SET TelefonNr='040 / 123 45 67' WHERE lID=3000;
UPDATE Lieferant SET TelefonNr='+49 / 3 141 592' WHERE lID=3001;
UPDATE Lieferant SET TelefonNr='040 / 1337 001' WHERE lID=3002;
UPDATE Lieferant SET TelefonNr='+49 / 80085 538' WHERE lID=3004;
