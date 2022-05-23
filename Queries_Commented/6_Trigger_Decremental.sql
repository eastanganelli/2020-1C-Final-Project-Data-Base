SET NAMES 'utf8';

--
-- Set default database
--
USE tp_basededatos;

--
-- Drop trigger `Suministro_Se_Sustrae`
--
DROP TRIGGER Suministro_Se_Sustrae;

DELIMITER $$

--
-- Create trigger `Suministro_Se_Sustrae`
--
CREATE 
	DEFINER = 'root'@'localhost'
TRIGGER Suministro_Se_Sustrae
	BEFORE INSERT
	ON suministro_egreso
	FOR EACH ROW
BEGIN
        UPDATE
        suministro s
        SET s.cantidad = s.cantidad - NEW.cantidad
        WHERE s.id = NEW.SUMINISTRO_id;
END
$$

DELIMITER ;

--Cunado se inserta un suministro de egreso se actualiza la tabla con la resta entre la cantidad que habia y la que se extrae