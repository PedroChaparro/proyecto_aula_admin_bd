/* ------------------------------------------------------------*/
/* PROCEDIMIENTOS RELACIONADOS A LAS VENTAS / RENTAS DE LA EMPRESA */
/* ------------------------------------------------------------*/

/* ----- */
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

/* ----- */
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

/* ----- */
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

/* ----- */
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

/* ----- */
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

/* ----- */
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

/* ----- */
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
	
		SELECT 'hola'; 
		/*Si no ha sido pagada, actualiza los datos para mostrarlos*/
		/* ESTOY TRABAJANDO EN ESTO */
	
	END IF; 

END //

DELIMITER ;
