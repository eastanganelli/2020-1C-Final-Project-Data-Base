--Pacientes reincidentes

SELECT
    pp.NombreYApellido AS NomPaciente, --Seleccionamos nombre y apellido dela persona
    salidas.PACIENTE_id AS `Historial paciente`, --Seleccionamos el id del paciente de la tabla salida
    (COUNT(`salidas`.`PACIENTE_id`) - 1) AS `Nro Reincidencias`, --Contamos la cantidad de veces que un paciente se contagio de covid 19
    COUNT(`salidas`.`PACIENTE_id`) AS `Nro Salidas` --Contamos la cantidad de veces que se recupero de covid 19
FROM
    `salidas`
INNER JOIN paciente p ON --Unimos internamente, por id del paciente, las tablas salidas y paciente
    salidas.PACIENTE_id = p.idPACIENTE
INNER JOIN persona pp ON --Unimos internamente, por DNI de la persona, a la union anterior con la tabla persona
    p.PERSONA_DNI = pp.DNI
WHERE --Donde el estado de salida sea igual a recuperado y el id del paciente en la tabla salidas este mas de una vez
    (
        (`salidas`.`Estado` = 2) AND `salidas`.`PACIENTE_id` IN(
        SELECT
            `salidas`.`PACIENTE_id`
        FROM
            `salidas`
        WHERE
            (`salidas`.`Estado` = 2)
        GROUP BY
            `salidas`.`PACIENTE_id`
        HAVING
            (COUNT(0) > 1)
    )
    )
GROUP BY --Agrupado por id de paciente
    `salidas`.`PACIENTE_id`
ORDER BY --Ordenamos por Nro de salidas en orden descendiente
    `Nro Salidas`
DESC