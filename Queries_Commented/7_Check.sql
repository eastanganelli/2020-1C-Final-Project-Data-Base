ALTER TABLE suministro_ingreso ADD CONSTRAINT CHK_CostoUni CHECK (costoUnitario<20000);
--Checkea que lo que se ingresea sea un costo unitario menor a 20000