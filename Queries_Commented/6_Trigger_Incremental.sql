SET NAMES 'utf8';

--
-- Set default database
--
USE tp_basededatos;

--
-- Drop trigger `Suministro_Se_Recibe`
--
DROP TRIGGER Suministro_Se_Recibe;

DELIMITER $$

--
-- Create trigger `Suministro_Se_Recibe`
--
CREATE 
	DEFINER = 'root'@'localhost'
TRIGGER Suministro_Se_Recibe
	AFTER UPDATE
	ON suministro_ingreso
	FOR EACH ROW
BEGIN
    UPDATE suministro s
    SET s.cantidad = s.cantidad + NEW.ingreso_cantidad
    WHERE s.id = NEW.SUMINISTRO_id;
END
$$

DELIMITER ;

--Cunado se inserta un suministro de ingreso se actualiza la tabla con la suma entre la cantidad que habia y la que se ingresa