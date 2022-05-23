-- Cantidad de pacientes en los diversos niveles del triage, reportados por centro y por mes

SELECT
    MONTH(p.FechaDeInternacion) AS Mes, -- Seleccionamos el mes en que internaron a la persona
    (
    SELECT
        cs.Nombre
    FROM
        centrosanitario cs
    WHERE
        p.CENTROSANITARIO_id = cs.id
) AS Centro, -- Seleccionamos el nombre del centro sanitario en el cual coincida el id con el del centro sanitario en el que esta la persona internada 
SUM(dt.TRIAGECOLOR_id = 1) AS ROJO, -- Sumamos la cantidad de pacientes que hay en las distintas etapas del triage
SUM(dt.TRIAGECOLOR_id = 2) AS NARANJA,
SUM(dt.TRIAGECOLOR_id = 3) AS AMARILLO,
SUM(dt.TRIAGECOLOR_id = 4) AS VERDE,
SUM(dt.TRIAGECOLOR_id = 5) AS AZUL
FROM
    diagtriage dt
INNER JOIN paciente p ON -- unimos internamente por id la tabla diagtirage con la tabla paciente
    dt.PACIENTE_id = p.idPACIENTE
GROUP BY -- Agrupamos por mes y id del centro sanitario
    p.CENTROSANITARIO_id,
    Mes
ORDER BY -- Ordenamos por centro sanitario y mes en orden ascendente
    `Centro`, Mes ASC