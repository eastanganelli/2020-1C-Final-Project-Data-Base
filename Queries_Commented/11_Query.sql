--Listado de empleados que estuvieron el dia que fallecio un paciente por covid 

SELECT
    s.FechaYHora AS FechaMuerte, --Seleccionamos la fecha y hora de la tabla salidas
    p.NombreYApellido AS Paciente, --Seleccionamos el nombre y apellido de la tabla persona
    cs.Nombre AS Centro, --Seleccionamos el nombre de la tabla centro sanitario
    vecsf.NombreYApellido AS NombreEmpleado --Seleccionamos el nombre y apellido de la vista viewempleadocsfichado
FROM
    salidas s
INNER JOIN paciente ON s.PACIENTE_id = paciente.idPACIENTE AND paciente.CovidTest=1 --Unimos internamente por id las tablas paciente y salidas
INNER JOIN persona p ON --Unimos internamente por dni la union anterior con la tabla persona
    paciente.PERSONA_DNI = p.DNI
INNER JOIN viewempleadocsfichado vecsf ON --Unimos internamente por id del centro sanitario la union anterior con la vista viewempleadocsfichado
    paciente.CENTROSANITARIO_id = vecsf.CENTRO_id
JOIN centrosanitario cs ON --Unimos por id del centrosanitario la union anterior con la tabla centrosanitario
    paciente.CENTROSANITARIO_id = cs.id
WHERE --Donde el estado de salida sea fallecido y la fecha y hora de salida se encuentre entre la fecha de entrada y la fecha de salida de la vista viewempleadocsfichado
    s.Estado = 1 AND s.FechaYHora BETWEEN vecsf.entrada AND vecsf.salida