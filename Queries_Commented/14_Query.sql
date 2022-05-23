--Pacientes en terapia intensiva con/sin respirador y con/sin covid por centro sanitario por mes

SELECT
    MONTH(p.FechaDeInternacion) AS Mes, --Seleccionamos el mes en el que internaron al paciente
    cs.Nombre AS Centro, --Seleccionamos el nombre del centro sanitario
    SUM(
        p.CovidTest = 1 AND tpi.Respirador = 0
    ) AS CantidadSinRespiCOVID, --Sumamos la cantidad de internados que tienen covid pero no respirador
    SUM(
        p.CovidTest = 0 AND tpi.Respirador = 0
    ) AS CantidadSinRespiNoCOVID, --Sumamos la cantidad de internados que no tienen covid y tampoco respirador
    SUM(
        p.CovidTest = 1 AND tpi.Respirador = 1
    ) AS CantidadRespiCOVID, --Sumamos la cantidad de internados que tienene covid y respirador
    SUM(
        p.CovidTest = 0 AND tpi.Respirador = 1
    ) AS CantidadRespiNoCOVID --Sumamos la cantidad de internados que no tienen covid pero si respirador
FROM
    terapiaintensiva tpi
INNER JOIN paciente p ON --Unimos, por id del paciente, la tabla terapiaintensiva con la tabla paciente
    tpi.PACIENTE_id = p.idPACIENTE
    JOIN centrosanitario cs ON p.CENTROSANITARIO_id=cs.id --Unimos, por id del centro sanitario, la union anterior con la tabla centrosanitario
GROUP BY --Agrupamos por id del centro sanitario y por mes
    p.CENTROSANITARIO_id,
    Mes
ORDER BY --Ordenamos por mes y centro sanitario en orden ascendente
    Mes,
    `Centro` ASC