-- Cantidad de recuperados y fallecidos de covid por mes

SELECT
    MONTH(p.FechaDeInternacion) AS Mes, -- Seleccionamos el mes en que se interno al paciente
    cs.Nombre AS CentroNombre, -- Seleccionamos el nombre del centro sanitario
    SUM(s.Estado = 1) AS MuertosCOVID, -- Sumamos la cantidad de salidas por fallecimiento
    SUM(s.Estado = 2) AS RecupCOVID, -- Sumamos la cantidad de salidas por recuperacion
    (
        SUM(s.Estado = 1) + SUM(s.Estado = 2)
    ) AS "TotalCOVID" -- Sumamos los fallecidos y los recuperados
FROM
    centrosanitario_has_empleado cshe
JOIN centrosanitario cs ON -- Unimos, por id del centro sanitario las tablas centrosanitario_has_empleado y centrosanitario
    cshe.centro_id = cs.id
JOIN empleado e ON -- Unimos, por matricula del empleado, la union anterior con la tabla empleado
    cshe.matricula_id = e.matricula
JOIN paciente p ON -- Unimos, por DNI, la union anterior con la tabla paciente
    e.PERSONA_DNI = p.PERSONA_DNI
JOIN salidas s ON -- Unimos, por id del paciente, la union anterior con la tabla salidas
    p.idPACIENTE = s.PACIENTE_id
GROUP BY -- Agrupamos por nombre del centro sanitario
    CentroNombre
ORDER BY -- Ordenamos por nombre del centro sanitario y por mes
    CentroNombre,
    Mes