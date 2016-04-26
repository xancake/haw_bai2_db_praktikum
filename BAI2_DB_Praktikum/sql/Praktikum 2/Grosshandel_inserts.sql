INSERT INTO Kunde VALUES(1000,'Niels','Larsen');
INSERT INTO Kunde VALUES(1001,'Borch','Lennartson');
INSERT INTO Kunde VALUES(1002,'Hans','Peter');
INSERT INTO Kunde VALUES(1003,'Marie','Maulig');
INSERT INTO Kunde VALUES(1004,'Jack','Sheraq');
INSERT INTO Kunde VALUES(1005,'Wolfgang','Wehrmacht');
INSERT INTO Kunde VALUES(1006,'Genghis','Khan');
INSERT INTO Kunde VALUES(1007,'Mao','Mao');
INSERT INTO Kunde VALUES(1008,'Hendrik','Vodka');
INSERT INTO Kunde VALUES(1009,'Putin','Obama');
INSERT INTO Kunde VALUES(1010,'Jürgen','Von der Lippe');
INSERT INTO Kunde VALUES(1011,'Lisa','Lustig');
INSERT INTO Kunde VALUES(1012,'','Lustig');

INSERT INTO Produkt VALUES(100,'Elektronik',338.97,'MSI GTX 970 Gaming 4g 4096GB');
INSERT INTO Produkt VALUES(101,'Obst',1.50,'Hochwertiger Apfel aus freiland Haltung');
INSERT INTO Produkt VALUES(102,'PKW',26000.00,'Mazda MX-5');
INSERT INTO Produkt VALUES(103,'Elektronik',180.00,'Cherry Mechanical Keyboard');
INSERT INTO Produkt VALUES(104,'Spaßartikel',13.37,'Jimi Hendrixs Luftgitarre');
INSERT INTO Produkt VALUES(105,'Elektronik',12.50,'WLAN-Kabel');
INSERT INTO Produkt VALUES(106,'Spaßartikel',3.00,'Ring der Unantastbarkeit (+5 Dexterity)');
INSERT INTO Produkt VALUES(107,'Schmuck',0.99,'Der eine Ring (gebraucht)');
INSERT INTO Produkt VALUES(108,'Elektronik',600.00,'Samsung 4K 240HZ 50" LED Monitor');
INSERT INTO Produkt VALUES(109,'Badezimmerbedarf',1.00,'Ed Hardy Klobrille');
INSERT INTO Produkt VALUES(110,'Lernbedarf',3141.59,'Premium 50 Blatt Block (kariert)');
INSERT INTO Produkt VALUES(111,'',999999.99,'Mystery Gift');

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


-- TEST Abschnitt

INSERT INTO Produkt VALUES(420,'Schrott',-50.00,'Hey Baby von Justin Bieber');
INSERT INTO Bestellposition VALUES(10005,103,0,666.42);
INSERT INTO Bestellposition VALUES(10005,106,2,-666.42);
