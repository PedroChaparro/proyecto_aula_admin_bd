SELECT * FROM alquileres; 
SELECT * FROM factura; 
SELECT * FROM sucursales; 
SELECT * FROM tipo_usuario; 
SELECT * FROM tipo_vehículo; 
SELECT * FROM usuarios; 
SELECT * FROM vehículos; 
SELECT * FROM rental_data_history_pretty; 
SELECT * FROM vehicles_information_pretty; 
SELECT * FROM USERS_SUMMARY_PRETTY; 
SELECT * FROM INTERNAL_USERS_SUMMARY_PRETTY; 

/*VISTA PARA MOSTRAR INFORMACIÓN DE LOS CLIENTES DE UNA MANERA RESUMIDA*/
DROP VIEW IF EXISTS USERS_SUMMARY_PRETTY; 
CREATE VIEW USERS_SUMMARY_PRETTY AS
SELECT id_usuario, CONCAT(nombres, ' ',apellidos) 'Nombre completo', correo_electrónico, c.ciudad, tu.tipo_usuario
FROM USUARIOS, ciudades AS c, TIPO_USUARIO AS tu
WHERE USUARIOS.id_ciudad_residencia = c.id_ciudad AND
		USUARIOS.código_tipo_usuario = tu.`código_tipo_usuario`; 
		
/*VISTA PARA MOSTRAR INFORMACIÓN DEL PERSONAL INTERNO DE UNA MANERA RESUMIDA*/
DROP VIEW IF EXISTS INTERNAL_USERS_SUMMARY_PRETTY; 
CREATE VIEW INTERNAL_USERS_SUMMARY_PRETTY AS
SELECT id_usuario, CONCAT(nombres, ' ',apellidos) 'Nombre completo', USUARIOS.`correo_electrónico`, c.ciudad, tu.tipo_usuario
FROM USUARIOS, TIPO_USUARIO AS TU, SUCURSALES AS s, CIUDADES AS c
WHERE 	USUARIOS.código_tipo_usuario = tu.`código_tipo_usuario` AND
			USUARIOS.`código_sucursal` = s.id_sucursal AND
			s.id_ciudad = c.id_ciudad; 

	id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	nombres VARCHAR(255) NOT NULL, 
	apellidos VARCHAR(255) NOT NULL, 
	identificacion VARCHAR(14) NOT NULL UNIQUE COMMENT 'Cédula del cliente', 
	direccion VARCHAR(255) NOT NULL, 
	id_ciudad_residencia INT UNSIGNED NOT NULL, 
	celular VARCHAR(10) NOT NULL, 
	correo_electrónico VARCHAR(255) NOT NULL UNIQUE, 
	contraseña VARCHAR(255) NOT NULL, 
	código_tipo_usuario INT UNSIGNED NOT NULL, 
	código_sucursal INT UNSIGNED NULL DEFAULT NULL COMMENT 'Columna usada para asociar los trabajadores a la sucursal en la que trabajan',
	is_active TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,

/*VISTA PARA MOSTRAR LA INFORMACIÓN DE LAS FACTURAS DE UN MODO FÁCIL DE ENTENDER*/
DROP VIEW IF EXISTS BILLS_PRETTY; 
CREATE VIEW BILLS_PRETTY AS
SELECT f.id_factura, CONCAT(u.nombres,' ',u.apellidos) 'Nombre cliente', a1.dias_mora,  f.totaL_pagar, f.valor_pagado, f.was_paid
FROM (factura AS f, usuarios AS u, alquileres AS a)
LEFT JOIN alquileres a1 ON a1.id_alquiler = f.id_alquiler
WHERE	 	f.id_alquiler = a.id_alquiler AND
			a.id_cliente = u.id_usuario; 

/*VISTA PARA MOSTRAR LA INFORMACIÓNDE LOS VEHÍCULOS DE UN MODO FÁCIL DE ENTENDER*/
DROP VIEW IF EXISTS VEHICLES_INFORMATION_PRETTY; 
CREATE VIEW VEHICLES_INFORMATION_PRETTY AS
SELECT v.matrícula, tv.tipo_vehículo, v.modelo, v.numero_puertas, v.capacidad, v.has_sunroof, tm.motor, v.color, v.descuento, v.valor_alquiler_semanal, v.valor_alquiler_diario, v.disponible 
FROM VEHÍCULOS AS v, tipo_vehículo AS tv, tipo_motor AS tm
WHERE v.código_tipo_vehículo = tv.código_tipo_vehículo AND
		v.código_tipo_motor = tm.código_tipo_motor; 

/*VISTA PARA MOSTRAR LA INFORMACIÓN DE LOS ALQUILERES DE UN MODO FÁCIL DE ENTENDER*/
DROP VIEW IF EXISTS rental_data_history_pretty; 
CREATE VIEW rental_data_history_pretty AS
SELECT CONCAT(u1.nombres,' ',u1.apellidos) 'Nombre_cliente', CONCAT(u2.nombres,' ',u2.apellidos) 'Nombre_vendedor', v.modelo, v.matrícula, c1.ciudad 'Ciudad_alquiler', c2.ciudad 'Ciudad_entrega', a.dias, a.valor_cotizado, a.fecha_salida , a.fecha_esperada_llegada,  a.fecha_llegada
FROM vehículos AS v, alquileres AS a
LEFT JOIN usuarios u1 ON u1.id_usuario = a.id_cliente
LEFT JOIN usuarios u2 ON u2.id_usuario = a.id_empleado
LEFT JOIN sucursales s1 ON s1.id_sucursal = a.id_sucursal_alquiler
LEFT JOIN ciudades c1 ON c1.id_ciudad = s1.id_ciudad
LEFT JOIN sucursales s2 ON s2.id_sucursal = a.id_sucursal_entrega
LEFT JOIN ciudades c2 ON c2.id_ciudad = s2.id_ciudad
WHERE v.id_vehículo = a.id_vehículo; 
		