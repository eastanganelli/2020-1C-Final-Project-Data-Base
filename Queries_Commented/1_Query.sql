SELECT
    vpr.Mes AS Mes, --Seleccionamos la columna Mes de la vista viewpacrecup
    (
        vpco.CantidadACTIVOS + vpr.Cantidad_de_Recuperados + vpm.Cantidad_de_Muertes
    ) AS Infectados, --Sumamos la cantidad de pacientes con covid activos + cantidad de pacientes recuperados + la cantidad de pacientes fallecidos
    vpco.CantidadACTIVOS AS Activos, --Seleccionamos la cantidad de pacientes con covid activos
    vpr.Cantidad_de_Recuperados AS Recuperados, --Seleccionamos la cantidad de pacientes recuperados
    vpm.Cantidad_de_Muertes AS Muertos, --Seleccionamos la cantidad de pacientes fallecidos
    vpr.Provincia AS Zona --Seleccionamos la provincia del centro sanitario
FROM
    viewpacrecup vpr
INNER JOIN viewpacmuertos vpm ON --Unimos internamente por provincia y mes las vistas viewpacrecup y viewpacmuertos 
    vpr.Provincia = vpm.Provincia AND vpr.Mes = vpm.Mes
INNER JOIN viewpaccovid vpco ON --Unimos intermante por provincia y mes la union anterior con la vista viewpaccovid
    vpr.Provincia = vpco.Provincia AND vpr.Mes = vpco.Mes
WHERE --Donde la provincia sea CABA.
    vpr.Provincia = "Ciudad Autónoma de Buenos Aires"