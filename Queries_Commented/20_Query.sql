-- Tiempo que tardaron los paciente en recuperarse

SELECT
    (
        (
        SELECT
            p.NombreYApellido
        FROM
            persona p
        WHERE
            p.DNI = paciente.PERSONA_DNI
    )
    ) AS `PacienteNombre`, -- Seleccionamos el nombre y apellido de la persona, donde el dni del paciente coincida con el de la persona 
    salidas.FechaYHora AS `fecha salida`, -- Seleccionamos la fechaYhora de salida
    paciente.FechaDeInternacion AS `fecha entrada`, -- Seleccionamos la fecha de internacion
    IF(
        TO_DAYS(
            CAST(salidas.FechaYHora AS DATE)
        ) - TO_DAYS(
            CAST(
                paciente.FechaDeInternacion AS DATE
            )
        ) > 0,
        TO_DAYS(
            CAST(salidas.FechaYHora AS DATE)
        ) - TO_DAYS(
            CAST(
                paciente.FechaDeInternacion AS DATE
            )
        ),
        (
            TO_DAYS(
                CAST(salidas.FechaYHora AS DATE)
            ) - TO_DAYS(
                CAST(
                    paciente.FechaDeInternacion AS DATE
                )
            )
        ) *(-1)
    ) AS `Tiempo de Recuperación (Días)` -- Dias que demora el paciente en recuperarse
FROM
    salidas
INNER JOIN paciente ON salidas.PACIENTE_id = paciente.idPACIENTE -- Unimos internamente, por id de paciente, las tablas salidas y paciente
WHERE -- Donde el estado de salida sea recuperado y el test de covid haya sido positivo
    salidas.Estado = 2 AND paciente.CovidTest = 1
ORDER BY -- Ordenando por id de paciente
    salidas.PACIENTE_id