SELECT
    (
    SELECT
        e.Nombre
    FROM
        enfermedad e
    WHERE
        e.idEnfermedad = pe.ENFERMEDAD_id
    ) AS 'NomEnfermedad', --Seleccionamos el nombre de la enfermedad donde el id coincida con la enfermedad que tenga el paciente
COUNT(pe.ENFERMEDAD_id) AS 'CantidadMuertos' --Contamos la cantidad de pacientes muertos por esa enfermedad
FROM
    paciente_enfermedades pe
INNER JOIN salidas s ON --Unimos internamente por id del paciente y estado fallecido las tablas salida salida y paciente_enfermedad
    pe.PACIENTE_id = s.PACIENTE_id AND s.Estado = 1
WHERE --Donde el nombre de la enfermedad no sea nulo
    'NomEnfermedad' IS NOT NULL
GROUP BY --Agrupamos por id de la enfermedad
    pe.ENFERMEDAD_id