SELECT
    edm.Med_DNI, --Seleccionamos el dni del medico de la vista viewempnomdnimat
    edm.Med_Nom, --Seleccionamos el nombre del medico de la vista viewempnomdnimat
    edm.Med_Matricula, --Seleccionamos la matricula del medico de la vista viewempnomdnimat
    sumcar.IngresoID, --Seleccionamos el id de ingreso de la vista viewsummascaros
    sumcar.CostoUni, --Seleccionamos el costo unitario de la vista viewsummascaros
    sumcar.CostoMenor AS "CostoCompared",  --Seleccionamos el costo menor de la vista viewsummascaros
    sumcar.Compara AS "IDCompared", --Seleccionamos el id contra el que se compara de la vista viewsummascaros
    sumcar.Nombre AS "Nom_Sum", --Seleccionamos el nombre del suministro de la vista viewsummascaros
    psum.nombre AS "Nom_proveedor", --Seleccionamos el nombre del proveedor de la vista viewproveedorsum
    psum.direccion, --Seleccionamos el direccion del proveedor de la vista viewproveedorsum
    psum.Provincia, --Seleccionamos la provincia del proveedor de la vista viewproveedorsum
    psum.email, --Seleccionamos el email del proveedor de la vista viewproveedorsum
    psum.Telefono --Seleccionamos el telefono del proveedor de la vista viewproveedorsum
FROM
    (
        viewsummascaros sumcar
    JOIN viewproveedorsum psum ON --Encontramos la union por id entre las vistas viewsummascaros y viewproveedorsum
        psum.INGRESO_id = sumcar.IngresoID
    JOIN viewempnomdnimat edm ON --Encontramos la union por id entre la union anterior y la vista viewempnomdnimat
        sumcar.EmpID = edm.EmpID
    )
GROUP BY --Agrupamos por nombre del suministro mas caro.
    sumcar.Nombre