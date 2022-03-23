/* ############## */
/* PROCEDURES */
/* ############## */

/*Procedimiento para el registro por parte de clientes*/

DROP PROCEDURE IF EXISTS register_new_client; 
DELIMITER //

CREATE PROCEDURE register_new_client(
	IN nombres VARCHAR(255), 
	IN apellidos VARCHAR(255), 
	IN identificacion VARCHAR(14), 
	IN direccion VARCHAR(255), 
	IN ciudad_residencia VARCHAR(255), 
	IN celular VARCHAR(10), 
	IN correo_electrónico VARCHAR(255), 
	IN contraseña VARCHAR(255) 
)
BEGIN 

	INSERT INTO usuarios(nombres, apellidos, identificacion, direccion, ciudad_residencia, celular, correo_electrónico, contraseña, código_tipo_usuario) VALUES(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		ciudad_residencia, 
		celular, 
		correo_electrónico, 
		contraseña, 
		3
	); 

END //

DELIMITER ; 

/*
CALL register_new_client('Pedro Andrés', 'Chaparro Quintero', '1005142366', 'Cra 4 No. 4-32 Cañaveral','Bucaramanga', '3221458999', 'pedro.chaparro.2020@upb.edu.co', 'contraseñasegura'); 
*/

/*Procedimiento para el registro de cuentas internas*/

DROP PROCEDURE IF EXISTS register_new_internal_user; 
DELIMITER //

CREATE PROCEDURE register_new_internal_user(
	IN nombres VARCHAR(255), 
	IN apellidos VARCHAR(255), 
	IN identificacion VARCHAR(14), 
	IN direccion VARCHAR(255), 
	IN ciudad_residencia VARCHAR(255), 
	IN celular VARCHAR(10), 
	IN correo_electrónico VARCHAR(255), 
	IN contraseña VARCHAR(255), 
	IN código_tipo_usuario INT UNSIGNED, 
	IN código_sucursal INT UNSIGNED
)
BEGIN 

	INSERT INTO usuarios(nombres, apellidos, identificacion, direccion, ciudad_residencia, celular, correo_electrónico, contraseña, código_tipo_usuario, código_sucursal) VALUES(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		ciudad_residencia, 
		celular, 
		correo_electrónico, 
		contraseña, 
		código_tipo_usuario, 
		código_sucursal
	); 

END //

DELIMITER ; 

/*
CALL register_new_internal_user('Daniela Catalina', 'Hernández', '1005142367', 'Cra 4 No. 4-32 El Refugio','Piedecuesta', '3221458998', 'daniela@gmail.com', 'daniela123', 1, 1); 

CALL register_new_internal_user('Juan Sebastián', 'Rojas', '1005142344', 'Cra 4 No. 4-32 Paseo Alcalá','Piedecuesta', '3145663233', 'juanrojas@gmail.com', 'juan00001', 2, 1); 
*/

/*Procedimiento para consultar vehículos disponibles*/

DROP PROCEDURE IF EXISTS get_available_vehicles; 
DELIMITER //

CREATE PROCEDURE get_available_vehicles()
BEGIN 

	SELECT * FROM VEHICLES_INFORMATION_PRETTY WHERE disponible = 1; 

END //

DELIMITER ; 

/*
CALL get_available_vehicles(); 
*/

/*Procedimiento para consultar vehículos disponibles por su tipo*/
DROP PROCEDURE IF EXISTS get_available_vehicles_filter_by_type; 
DELIMITER //

CREATE PROCEDURE get_available_vehicles_filter_by_type(
	IN tipo_vehículo VARCHAR(255) 
)
BEGIN 

	SELECT * FROM VEHICLES_INFORMATION_PRETTY
	WHERE 
		disponible = 1 AND
		VEHICLES_INFORMATION_PRETTY.tipo_vehículo = tipo_vehículo; 

END //

DELIMITER ; 

/*
CALL get_available_vehicles_filter_by_type('Compacto'); 
*/

/*Procedimiento para consultar vehículos disponibles por un rango de precios*/
DROP PROCEDURE IF EXISTS get_available_vehicles_filter_by_price; 
DELIMITER //

CREATE PROCEDURE get_available_vehicles_filter_by_price(
	IN min_price DECIMAL(12,2), 
	IN max_price DECIMAL(12,2)
)
BEGIN 

	SELECT * FROM VEHICLES_INFORMATION_PRETTY
	WHERE 
		disponible = 1 AND
		VEHICLES_INFORMATION_PRETTY.valor_alquiler_semanal >= min_price AND
		VEHICLES_INFORMATION_PRETTY.valor_alquiler_semanal <= max_price; 

END //

DELIMITER ;

/*
CALL get_available_vehicles_filter_by_price(400000, 540000);
*/

/*Procedimiento para alquilar un vehículo*/
DROP PROCEDURE IF EXISTS register_vehicle_rental; 
DELIMITER //

CREATE PROCEDURE register_vehicle_rental(
	IN id_cliente INT UNSIGNED, 
	IN id_empleado INT UNSIGNED, 
	IN id_vehículo INT UNSIGNED, 
	IN id_sucursal_alquiler INT UNSIGNED,
	IN id_sucursal_entrega INT UNSIGNED, 
	IN fecha_salida TIMESTAMP, 
	IN fecha_esperada_llegada TIMESTAMP, 
	IN dias TINYINT UNSIGNED
)
BEGIN 

	/*Calcular el precio*/
	SELECT valor_alquiler_semanal, valor_alquiler_diario, descuento INTO @alquiler_semanal, @alquiler_diario, @descuento
	FROM VEHÍCULOS
	WHERE VEHÍCULOS.id_vehículo = id_vehículo;  
	
	SET @semanas = TRUNCATE((dias/7), 0);
	SET @dias_restantes = dias - (@semanas * 7); 
	
	SET @valor_cotizado = (@semanas * @alquiler_semanal) + (@dias_restantes * @alquiler_diario);
	SET @valor_cotizado = @valor_cotizado - ((@valor_cotizado * @descuento)/100); 
	
	/*El vehículo ya no estará disponible para alquilar*/
	UPDATE VEHÍCULOS 
	SET VEHÍCULOS.disponible = 0 
	WHERE VEHÍCULOS.id_vehículo = id_vehículo; 
	
	/*Insertar el dato*/
	INSERT INTO ALQUILERES(id_cliente, id_empleado, id_vehículo, id_sucursal_alquiler, id_sucursal_entrega, fecha_salida, fecha_esperada_llegada, dias, valor_cotizado) VALUES (
		id_cliente, 
		id_empleado, 
		id_vehículo, 
		id_sucursal_alquiler, 
		id_sucursal_entrega,
		fecha_salida,  
		fecha_esperada_llegada, 
		dias, 
		@valor_cotizado
	); 

END //

DELIMITER ;
 
/*
CALL register_vehicle_rental(
	1, 
	3, 
	6, 
	1, 
	3, 
	'2022/2/15', 
	'2022/2/28', 
	15
); 

CALL register_vehicle_rental(
	1, 
	3, 
	3, 
	1, 
	3, 
	'2022/2/15', 
	'2022/2/28', 
	20
); 

CALL register_vehicle_rental(
	1, 
	3, 
	3, 
	1, 
	3, 
	'2022/1/15', 
	'2022/2/01', 
	20
); 
*/

/*Procedimiento para ver el historial de alquileres*/

DROP PROCEDURE IF EXISTS get_rental_history; 
DELIMITER //

CREATE PROCEDURE get_rental_history()
BEGIN 

	SELECT * FROM rental_data_history_pretty; 
	
END //

DELIMITER ;

/*
CALL get_rental_history; 
*/

/*Procedimiento para registrar la llegada del vehículo a la sucursal destino*/
DROP PROCEDURE IF EXISTS register_vehicle_arrival; 
DELIMITER //

CREATE PROCEDURE register_vehicle_arrival(
	id_alquiler INT UNSIGNED
)
BEGIN 

	/*Se actualiza la fecha de llegada*/
	UPDATE alquileres
	SET alquileres.fecha_llegada = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 
	
END//

DELIMITER ;

/*
CALL register_vehicle_arrival(1); 
CALL register_vehicle_arrival(2);
CALL register_vehicle_arrival(3);
*/

/*Procedimiento para registrar cuando un cliente reocge el vehículo en la sucursal destino*/

DROP PROCEDURE IF EXISTS register_vehicle_pickup; 
DELIMITER //

CREATE PROCEDURE register_vehicle_pickup(
	id_alquiler INT UNSIGNED
)
BEGIN 

	/*Se actualiza la fecha de recogida*/
	UPDATE alquileres
	SET alquileres.fecha_recogida = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 
	
	/*Se actualiza la fecha máxima de entrega a partir de los días del alquiler y la fecha de recogida*/
	UPDATE alquileres
	SET alquileres.fecha_entrega_pactada = ADDDATE(alquileres.fecha_recogida, alquileres.dias)
	WHERE alquileres.id_alquiler = id_alquiler; 

END // 

DELIMITER ;

/*
CALL register_vehicle_pickup(1); 
CALL register_vehicle_pickup(2); 
CALL register_vehicle_pickup(3); 
*/

/*Procedimiento para registrar cuando un cliente entrega el vehículo*/
DROP PROCEDURE IF EXISTS register_vehicle_return; 
DELIMITER //

CREATE PROCEDURE register_vehicle_return(
	id_alquiler INT UNSIGNED
)
BEGIN 

	/*Se agrega el registro de la devolución del vehículo por parte del cliente*/
	UPDATE alquileres
	SET alquileres.fecha_entrega = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 
	
	/*Se calculan los días de mora*/
	SELECT fecha_entrega_pactada, fecha_entrega INTO @fecha_entrega_pactada, @fecha_entrega
	FROM alquileres
	WHERE alquileres.id_alquiler = id_alquiler; 
	
	IF @fecha_entrega_pactada < @fecha_entrega THEN
	
			SET @mora = TIMESTAMPDIFF(DAY, @fecha_entrega_pactada,@fecha_entrega);
			
			UPDATE alquileres
			SET alquileres.dias_mora = @mora
			WHERE alquileres.id_alquiler = id_alquiler; 
			
	END IF; 

END // 

DELIMITER ; 

/*
CALL register_vehicle_return(1); 
CALL register_vehicle_return(2); 
CALL register_vehicle_return(3); 
*/

/*Procedimiento para agregar descuento a un tipo de vehículo específico*/
DROP PROCEDURE IF EXISTS set_disccount_to_vehicle_type; 
DELIMITER //

CREATE PROCEDURE set_disccount_to_vehicle_type(
	IN tipo_vehículo INT UNSIGNED, 
	IN descuento DECIMAL(3,1)
)
BEGIN 

	UPDATE VEHÍCULOS
	SET VEHÍCULOS.descuento = descuento
	WHERE VEHÍCULOS.`código_tipo_vehículo` = tipo_vehículo; 
	 

END //

DELIMITER ; 

/*
CALL set_disccount_to_vehicle_type(
	6, 
	30.5
);
*/ 

/*Procedimiento para crear una factura*/

DROP PROCEDURE IF EXISTS create_bill; 

DELIMITER //

CREATE PROCEDURE create_bill(
	id_alquiler INT UNSIGNED
)
BEGIN 
	
	/*Se obtiene el valor a pagar desde la tabla alquileres*/
	SELECT a.valor_cotizado INTO @total_pagar
	FROM alquileres AS a
	WHERE a.id_alquiler = id_alquiler; 
	
	INSERT INTO factura (id_alquiler, totaL_pagar) VALUES (
		id_alquiler, 
		@totaL_pagar
	); 

END //

DELIMITER ; 

/*
CALL create_bill(
	1
); 

CALL create_bill(
	2
); 

CALL create_bill(
	3
); 
*/

/*Procedimiento para consultar una factura*/

DROP PROCEDURE IF EXISTS consult_bill; 
DELIMITER //

CREATE PROCEDURE consult_bill(
	id_alquiler INT UNSIGNED
)
BEGIN 

	/*SE OBTIENE EL ESTADO DE LA FACTURA*/
	SELECT f.was_paid INTO @bill_was_paid
	FROM FACTURA AS f
	WHERE f.id_alquiler = id_alquiler; 
	
	/*Si ya fue pagada solamente muestra los datos*/
	IF @bill_was_paid = 1 THEN
	
		SELECT * 
		FROM factura AS f
		WHERE f.id_alquiler = id_alquiler; 
	
	ELSE
	
		/*Si no ha sido pagada, actualiza los datos para mostrarlos*/
		/* ESTOY TRABAJANDO EN ESTO */
	
	END IF; 

END //

DELIMITER ;
