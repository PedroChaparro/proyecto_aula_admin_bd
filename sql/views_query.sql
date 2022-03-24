SELECT * FROM alquileres; 
SELECT * FROM factura; 
SELECT * FROM sucursales; 
SELECT * FROM tipo_usuario; 
SELECT * FROM tipo_vehículo; 
SELECT * FROM usuarios; 
SELECT * FROM vehículos; 
SELECT * FROM rental_data_history_pretty; 
SELECT * FROM vehicles_information_pretty; 

/*VISTA PARA MOSTRAR LA INFORMACIÓN DE LAS FACTURAS DE UN MODO FÁCIL DE ENTENDER*/
CREATE VIEW BILLS_PRETTY AS
SELECT f.id_factura, CONCAT(u.nombres,' ',u.apellidos) 'Nombre cliente', a1.dias_mora,  f.totaL_pagar, f.valor_pagado, f.was_paid
FROM (factura AS f, usuarios AS u, alquileres AS a)
LEFT JOIN alquileres a1 ON a1.id_alquiler = f.id_alquiler
WHERE	 	f.id_alquiler = a.id_alquiler AND
			a.id_cliente = u.id_usuario; 

/*VISTA PARA MOSTRAR LA INFORMACIÓNDE LOS VEHÍCULOS DE UN MODO FÁCIL DE ENTENDER*/
DROP VIEW IF EXISTS VEHICLES_INFORMATION_PRETTY; 
CREATE VIEW VEHICLES_INFORMATION_PRETTY AS
SELECT v.matrícula, tv.tipo_vehículo, v.modelo, v.numero_puertas, v.capacidad, v.has_sunfoof, tm.motor, v.color, v.valor_alquiler_semanal, v.valor_alquiler_diario, v.disponible 
FROM VEHÍCULOS AS v, tipo_vehículo AS tv, tipo_motor AS tm
WHERE v.código_tipo_vehículo = tv.código_tipo_vehículo AND
		v.código_tipo_motor = tm.código_tipo_motor; 

/*VISTA PARA MOSTRAR LA INFORMACIÓN DE LOS ALQUILERES DE UN MODO FÁCIL DE ENTENDER*/
DROP VIEW IF EXISTS rental_data_history_pretty; 
CREATE VIEW rental_data_history_pretty AS
SELECT CONCAT(u1.nombres,' ',u1.apellidos) 'Nombre cliente', CONCAT(u2.nombres,' ',u2.apellidos) 'Nombre vendedor', v.modelo, v.matrícula, a.dias, a.valor_cotizado, a.fecha_salida, s1.id_ciudad 'Sucursal alquiler', a.fecha_esperada_llegada,  a.fecha_llegada, s2.id_ciudad 'Sucursal entrega'
FROM vehículos AS v, alquileres AS a
LEFT JOIN usuarios u1 ON u1.id_usuario = a.id_cliente
LEFT JOIN usuarios u2 ON u2.id_usuario = a.id_empleado
LEFT JOIN sucursales s1 ON s1.id_sucursal = a.id_sucursal_alquiler
LEFT JOIN sucursales s2 ON s2.id_sucursal = a.id_sucursal_entrega
WHERE v.id_vehículo = a.id_vehículo; 
		