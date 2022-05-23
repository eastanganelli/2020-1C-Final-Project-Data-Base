--Cantidad de personal de enfermeria que se encuentra internado con covid positivo o negativo

SELECT
    MONTH(p.FechaDeInternacion) AS Mes, --Seleecionamos el mes en que se interno al paciente
    cs.Nombre AS CentroNombre, --Seleccionamos el nombre del centro sanitario
    SUM(
        cshe.funcion_id = vfl.id AND vfl.lugar = 'Enfermería'
    ) AS CANT_Internados, --Sumamos los empleados que esten en el area enfermería
    SUM(p.CovidTest=1) AS COVID_POS, --Sumamos los pacientes que dieron positivo al test covid
    (SUM(
        cshe.funcion_id = vfl.id AND vfl.lugar = 'Enfermería'
    )-SUM(p.CovidTest=1)) AS COVID_NEG --Resta entre los empleados en el area enfermeria y los pacientes con covid
FROM
    centrosanitario_has_empleado cshe
    JOIN viewfuncionylugar vfl ON --Unimos, por id de funcion en hospital y lugar en hospital = enfermeria, la tabla centrosanitario_has_empleado y la vista viewfuncionylugar
        cshe.funcion_id = vfl.id AND vfl.lugar = 'Enfermería'
    JOIN centrosanitario cs ON --Unimos, por id del centro sanitario, a la union anterior con la tabla centro sanitario
        cshe.centro_id = cs.id
        JOIN empleado e ON cshe.matricula_id=e.matricula --Unimos, por matricula del empleado, a la union anterior con la tabla empleado
        JOIN paciente p ON e.PERSONA_DNI=p.PERSONA_DNI --Unimos, por DNI de la persona, a la union anterior con la tabla paciente
GROUP BY --Agrupamos por nombre del centro sanitario
    CentroNombre
ORDER BY --Ordenamos por nombre del centro sanitario y por mes
	CentroNombre,
    Mes