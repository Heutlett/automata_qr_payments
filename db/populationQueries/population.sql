INSERT INTO usuarios (nombre_usuario, contrasena, correo, rol)
VALUES ('adrian19921', '1234', 'carlosadrian19921@gmail.com', 1);

INSERT INTO usuarios (nombre_usuario, contrasena, correo, rol)
VALUES ('bele1974', '1234', 'beleida@gmail.com', 1);

INSERT INTO cuentas (id_usuario, cedula_tipo, cedula_numero, id_extranjero, nombre, nombre_comercial, tel_codigo_pais, tel_numero, fax_codigo_pais, fax_numero, correo, ubicacion_codigo, ubicacion_senas, senas_extranjero, inscrito) 
VALUES (1, '01', 604530340, 'NA', 'CARLOS ADRIAN ARAYA RAMIREZ', 'ADRIAN ARAYA', 506, 88393511, 'NA', 'NA', 'carlosadrian19921@gmail.com', 60801, 'PRIMERA ENTRADA SEGUNDA CASA A MANO IZQUIERDA', 'NA', 1);

INSERT INTO cuentas (id_usuario, cedula_tipo, cedula_numero, id_extranjero, nombre, nombre_comercial, tel_codigo_pais, tel_numero, fax_codigo_pais, fax_numero, correo, ubicacion_codigo, ubicacion_senas, senas_extranjero, inscrito) 
VALUES (2, '01', 602570874, 'NA', 'BELEIDA DEL CARMEN RAMIREZ RODRIGUEZ', 'NA', 506, 84283249, 'NA', 'NA', 'beleida@gmail.com', 60801, 'PRIMERA ENTRADA SEGUNDA CASA A MANO IZQUIERDA', 'NA', 1);

INSERT INTO actividades_comerciales (id_cuenta, codigo_actividad) 
VALUES (1, '722003');

