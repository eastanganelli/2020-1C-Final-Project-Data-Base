SELECT
    vccc.CENTRO_NOMBRE AS Centro, --Seleccionamos la columna con el nombre del centro sanitario de la vista viewcentroempchcovid
    vccc.SemanaControl AS NroSemana, --Seleccionamos la columna SemanaControl de la vista viewcentroempchcovid
    (
        (
        SELECT
            COUNT(vcaux.SemanaControl)
        FROM
            viewcentroempchcovid vcaux
        WHERE
            vccc.CENTRO_ID = vcaux.CENTRO_ID AND vccc.SemanaControl = vcaux.SemanaControl AND vcaux.COVID_RES = 1
    )
    ) AS COVIDpositivos, --Contamos los controles semanales, de las vistas viewcentroempchcovid y viewcentroempchcovid, donde coincidan los ids de los centro sanitarios, las semanas de control y donde el resultado del test sea positivo
    (
        (
        SELECT
            COUNT(vcaux.COVID_RES)
        FROM
            viewcentroempchcovid vcaux
        WHERE
            vccc.CENTRO_ID = vcaux.CENTRO_ID AND vccc.SemanaControl = vcaux.SemanaControl
    )
    ) AS 'CantChecks' --Contamos la cantidad de test 
FROM
    viewcentroempchcovid vccc,
    centrosanitario cs
WHERE
    (
    SELECT
        COUNT(vcaux.COVID_RES)
    FROM
        viewcentroempchcovid vcaux
    WHERE
        vccc.CENTRO_ID = vcaux.CENTRO_ID AND vccc.SemanaControl = vcaux.SemanaControl
    ) > 0 --Donde la contidad de test sena mayores que 0
GROUP BY --Agrupamos por id del centro y semana
    vccc.SemanaControl,
    vccc.CENTRO_ID
ORDER BY --Ordenamos por id del centro y semana
    vccc.CENTRO_ID,
    vccc.SemanaControl