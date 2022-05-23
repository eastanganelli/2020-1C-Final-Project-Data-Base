--Cantidad de personal de terapia intensiva que se encuentra internado con covid positivo o negativo

SELECT
    MONTH(p.FechaDeInternacion) AS Mes, --Seleccionamos el mes de internacion del paciente
    cs.Nombre AS CentroNombre, --Seleccionamos el nombre del centro sanitario
    SUM(
        cshe.funcion_id = vfl.id AND vfl.lugar = 'Unidad de Tratamientos Intensivos'
    ) AS CANT_Internados, --Sumamos los medicos que estan en la unidad de tratamientos intensivos
    SUM(p.CovidTest=1) AS COVID_POS, --Sumamos los pacientes con test de covid positivo
    (SUM(
        cshe.funcion_id = vfl.id AND vfl.lugar = 'Unidad de Tratamientos Intensivos'
    )-SUM(p.CovidTest=1)) AS COVID_NEG --Resta entre los medicos que estan en la unidad de tratamientos intensivos y los pacientes con covid positivo
FROM
    centrosanitario_has_empleado cshe
    JOIN viewfuncionylugar vfl ON --Unimos, por id de la funcion del empleado en el hospital y donde el lugar sea igual a unindad de tratamientos intensivos, a la tabla centrosanitario_has_empleado con la vista viewfuncionylugar
        cshe.funcion_id = vfl.id AND vfl.lugar = 'Unidad de Tratamientos Intensivos'
    JOIN centrosanitario cs ON --unimos, por id del centro sanitario, a la union anterior con la tabla centrosanitario
        cshe.centro_id = cs.id
        JOIN empleado e ON cshe.matricula_id=e.matricula --Unimos, por matricula del empleado, a la union anterior con la tabla empleado
        JOIN paciente p ON e.PERSONA_DNI=p.PERSONA_DNI --Unimos, por DNI, a la union anterior con la tabla paciente
GROUP BY --Agrupamos por nombre del centro sanitario
    CentroNombre
ORDER BY --Ordenamos por nombre del centro sanitario y mes
  CentroNombre,
    Mes