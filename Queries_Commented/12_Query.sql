--Checkeos de urgencias de stock

SELECT
    s.nombre AS 'Suministro', --Seleccionamos el nombre del suministro
    s.cantidad AS 'Cantidad Debajo de 10', --Seleccionamos la cantidad de la tabla suministro
    slp.tipoPeti AS 'Lvl Peticion Sum', --Nivel de petición que posee ese suministro --Seleccionamos el tipo de peticion
    IF(
        s.cantidad >= 6 AND slp.id <= 2,
        'Baja',
        IF(
            s.cantidad < 6 AND slp.id >= 3,
            'Crtica',
            'Media'
        )
    ) AS 'Urgencia de STOCK' --Urgencia para pedir más
FROM
    suministro s
INNER JOIN suministro_lvlpeticion slp ON --Unimos internamente, por id de nivel de peticion, las tablas suministro y suministro_lvlpeticion
    s.nivel_peticion = slp.id
WHERE --Donde la cantidad sea menor a 10
    s.cantidad < 10  
ORDER BY s.nivel_peticion  DESC --Se ordena por Peticion Suministro