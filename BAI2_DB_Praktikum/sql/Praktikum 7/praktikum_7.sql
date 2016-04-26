---- 7.1 Trigger anlegen
-- Bestellung gesamtpreis hinzufügen
ALTER TABLE Bestellung ADD (gesamtpreis DECIMAL(10,2) DEFAULT 0 NOT NULL);

-- gesamtpreis für bereits bestehende Bestellpositionen berechnen
UPDATE Bestellung b
SET gesamtpreis = (
	SELECT SUM(preis*menge)
	FROM Bestellposition bp
	WHERE b.bID=bp.bID
);

-- Trigger anlegen
DROP TRIGGER bestellung_gesamtpreis;
CREATE TRIGGER bestellung_gesamtpreis
  AFTER INSERT OR UPDATE OR DELETE ON Bestellposition
  FOR EACH ROW
BEGIN
  -- ON INSERT
  IF :OLD.bID IS NULL THEN
    UPDATE Bestellung b
    SET gesamtpreis = gesamtpreis + :NEW.preis * :NEW.menge
    WHERE b.bID = :NEW.bID;
  END IF;
  
  -- ON DELETE
  IF :NEW.bID IS NULL THEN
    UPDATE Bestellung b
    SET gesamtpreis = gesamtpreis - :OLD.preis * :OLD.menge
    WHERE b.bID = :OLD.bID;
  END IF;
  
  -- ON UPDATE
  IF :OLD.bID IS NOT NULL AND :NEW.bID IS NOT NULL THEN
    UPDATE Bestellung b
    SET gesamtpreis = gesamtpreis - (:OLD.preis * :OLD.menge) + (:NEW.preis * :NEW.menge);
	WHERE b.bID = :NEW.bID;
  END IF;
END;


---- 7.2
SELECT *
FROM Kunde k
WHERE ort='Hamburg'
  AND EXISTS (SELECT * FROM Bestellung b WHERE k.kdID=b.kdID)
ORDER BY k.vorname, k.nachname;
