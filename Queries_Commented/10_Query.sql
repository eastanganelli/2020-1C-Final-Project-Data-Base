SELECT
    fecovid.DNI_Empleado AS "DNI_Empleado", --seleccionamos el dni del empleado de la vista viewfamiliaresempacheck
    (
    SELECT
        p.NombreYApellido 
    FROM
        persona p
    WHERE
        p.DNI = fecovid.DNI_Empleado
) AS "Empleado Nombre", --Seleccionamos la columna nombreyapellido de la tabla persona donde el dni de la persona coincida con el del empleado en la vista viewfamiliaresempacheck
fecovid.DNIFamiliar AS "DNI2Check", --Seleccionamos la columna DNIFamiliar de la vista viewfamiliaresempacheck
fecovid.NomFamiliar AS "Persona2Check", --Seleccionamos la columna NomFamiliar de la vista viewfamiliaresempacheck
"FAMILIAR" AS "Relacion"
FROM
    viewfamiliaresempacheck fecovid
WHERE
    fecovid.DNIFamiliar IS NOT NULL AND fecovid.NomFamiliar IS NOT NULL AND fecovid.DNI_Empleado IS NOT NULL --Donde el DNIFamiliar, nomfamiliar y dni_empleado de la vista viewfamiliaresempacheck no son nulos
UNION --UNION DE AMBAS CONSULTAS
SELECT
    etobc.EmpleadoCOVIDDNI AS "DNI_Empleado", --Seleccionamos la columna EmpleadoCOVIDDNI de la vista viewempleadosasercheck
    (
    SELECT
        p.NombreYApellido
    FROM
        persona p
    WHERE
        p.DNI = etobc.EmpleadoCOVIDDNI
) AS "Empleado Nombre", --Seleccionamos la columna nombreyapellido de la tabla persona donde el dni de la persona coincida con el dni de la vista viewempleadosasercheck
etobc.Empleado2CheckDNI AS "DNI2Check", --Seleccionamos la columna Empleado2CheckDNI de la vista viewempleadosasercheck
etobc.Empleado2Check AS "Persona2Check", --Seleccionamos la columna Empleado2Check(nombre de la persona que checkeamos) de la vista viewempleadosasercheck
"COMPAÑERO TRABAJO" AS "Relacion"
FROM
    viewempleadosasercheck etobc
WHERE
    etobc.Empleado2CheckDNI IS NOT NULL AND etobc.Empleado2Check IS NOT NULL AND etobc.EmpleadoCOVIDDNI IS NOT NULL --Donde Empleado2CheckDNI, Empleado2Check y EmpleadoCOVIDDNI de la vista viewempleadosasercheck no son nulos
    -- La ultima columna de cada consulta es el tipo de relacion que tenia con esa persona.