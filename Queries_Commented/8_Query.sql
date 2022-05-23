SELECT
    cs.id, --Seleccionamos el id del centro sanitario
    cs.Nombre AS "Centrosanitario", --Seleccionamos el nombre del centro sanitario
    (
    SELECT
        prov.Provincia
    FROM
        provincia prov
    WHERE
        `prov`.`idPROVINCIA` = cs.PROVINCIA_idPROVINCIA
    ) AS "Pronvicia", --Seleccionamos la provincia del centro sanitario
IF(
    (
    SELECT
        csfm.avgRecuperados
    FROM
        viewcsfemavgrede csfm
    WHERE
        csfm.idCS = cs.id
    ) IS NULL,
"NO HAY DATOS", --Si el promedio de mujeres recuperadas es nulo entonces devolvemos no hay datos
(
    SELECT
        csfm.avgRecuperados
    FROM
        viewcsfemavgrede csfm
    WHERE
        csfm.idCS = cs.id
)
) AS "AVGMujRecup", --Sino devolvemos el promedio de mujeres recuperadas
IF(
    (
    SELECT
        csfm.avgRecuperados
    FROM
        viewcsfemavgrede csfm
    WHERE
        csfm.idCS = cs.id
) IS NULL,
"NO HAY DATOS", --Si el promedio de mujeres fallecidas es nulo entonces devolvemos no hay datos
(
    SELECT
        csfm.avgMuertos
    FROM
        viewcsfemavgrede csfm
    WHERE
        csfm.idCS = cs.id
)
) AS "AVGMujMuertas", --Sino devolvemos el promedio de mujeres fallecidas
IF(
    (
    SELECT
        csfm.avgRecuperados
    FROM
        viewcsmasavgrede csfm
    WHERE
        csfm.idCS = cs.id
    GROUP BY
        csfm.idCS
) IS NULL,
"NO HAY DATOS", --Si el promedio de hombres recuperados es nulo entonces devolvemos no hay datos
(
    SELECT
        csfm.avgRecuperados
    FROM
        viewcsmasavgrede csfm
    WHERE
        csfm.idCS = cs.id
    GROUP BY
        csfm.idCS
)
) AS "AVGHomRecup", --Sino devolvemos el promedio de hombres recuperados
IF(
    (
    SELECT
        csfm.avgRecuperados
    FROM
        viewcsmasavgrede csfm
    WHERE
        csfm.idCS = cs.id
    GROUP BY
        csfm.idCS
) IS NULL,
"NO HAY DATOS", --Si el promedio de hombres fallecidos es nulo devolvemos no hay datos
(
    SELECT
        csfm.avgMuertos
    FROM
        viewcsmasavgrede csfm
    WHERE
        csfm.idCS = cs.id
    GROUP BY
        csfm.idCS
)
) AS "AVGHomMUERTOSS" --Sino devolvemos el promedio de hombres fallecidos
FROM
    centrosanitario cs
GROUP BY --agrupados por nombre del centro sanitario
    cs.Nombre  
ORDER BY `Pronvicia` ASC --Ordenamos por arden ascendente de provincias