-- Cantidad de horas trabajadas por los empleados

SELECT
    IF(((HOUR(ehcf.salida) - HOUR(ehcf.entrada) ) < 0),
        (-(1) *(HOUR(ehcf.salida) - HOUR(ehcf.entrada))),
        (HOUR(ehcf.salida) - HOUR(ehcf.entrada))) AS 'Horas Trabajadas', -- Esto es para converir las horas trabajadas en positivo, por un problema al cargar las fechas con generadores de datos
    (
        SELECT
            persona.DNI
        FROM
            persona
        WHERE
            (
                persona.DNI = empleado.PERSONA_DNI
            )
    ) AS 'DNI_Empleado', -- Seleccionamos el DNI de las personas que coincida con el de un empleado
(
    SELECT
        persona.NombreYApellido
    FROM
        persona
    WHERE
        (
            persona.DNI = empleado.PERSONA_DNI
        )
) AS 'Nombre y Apellido', -- Seleccionamos el nombre y apellido de las personas cuyo dni coincida con el de un empleado
cs.nombre AS "Centro Sanitario" -- Seleccionamos el nombre del centro sanitario
FROM
    (
        empleado_has_centrofichado ehcf
    JOIN empleado ON empleado.matricula = ehcf.EMPLEADO_id -- Unimos, por matricula del empleado, la tabla empleado_has_centrofichado con la tabla empleado
    JOIN centrosanitario cs ON ehcf.CENTRO_id = cs.id -- Unimos, por id del centro sanitario, a la union anterior con la tabla centrosanitario
    )
WHERE
    (IF(((HOUR(ehcf.salida) - HOUR(ehcf.entrada)) < 0),(-(1) *(HOUR(ehcf.salida) - HOUR(ehcf.entrada))),(HOUR(ehcf.salida) - HOUR(ehcf.entrada))) > 0) -- Donde las horas trabajadas sean mayores a 0
ORDER BY -- Ordenamos por horas trabajadas en orden descendente
    `Horas Trabajadas`
DESC