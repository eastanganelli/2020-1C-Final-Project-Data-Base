SELECT
    (
    SELECT
        s.nombre
    FROM
        suministro s
    WHERE
        s.FARMACEUTICA_id = mt.FARMACEUTICA_id
) AS 'Medicamento', --Seleccionamos el nombre de los suministros donde el id coincida con el id de farmaceutica
COUNT(mt.FARMACEUTICA_id) AS 'CantidadSum' --Contamos la cantidad de suministros con ese id que hay en suministros farmaceuticos
FROM
    medtratamiento mt
INNER JOIN salidas s ON --Unimos internamente por id y estado recuperado las tablas salidas y medtratamiento
    mt.PACIENTE_id = s.PACIENTE_id AND s.Estado = 2
GROUP BY --Agrupamos por id de suministro farmaceutico
    mt.FARMACEUTICA_id
ORDER BY --Ordenamos por cantidad de sumnisitros en orden descendente.
    `CantidadSum`
DESC