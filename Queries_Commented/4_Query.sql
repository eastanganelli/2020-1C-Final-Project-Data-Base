SELECT
    (
        (
        SELECT
            p.NombreYApellido
        FROM
            persona p
        WHERE
            (p.DNI = e.PERSONA_DNI)
    )
    ) AS "Nombre Enfermero", --Seleccionamos la columna nombre y apellido de la tabla persona donde el dni de la persona coincida con el dni del empleado
    CAST(ehcf.entrada AS DATE) AS "YYYY/MM/DD" --Fecha de entrada de la tabla empleado_has_centrofichado
FROM
    (
        empleado_has_centrofichado ehcf
    JOIN empleado e ON --Union por matricula entre empleado_has_centrofichado y empleado
        (
            (ehcf.EMPLEADO_id = e.matricula)
        )
    )
WHERE
    CAST(ehcf.entrada AS DATE) IN(
    SELECT
        CAST(
            viewdiamayormuertos.Fecha AS DATE
        )
    FROM
        viewdiamayormuertos
) --Donde la fecha de entrada sea igual a la del dia con mayor cantidad de fallecidos