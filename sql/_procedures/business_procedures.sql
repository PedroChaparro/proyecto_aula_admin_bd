/* ------------------------------------------------------------*/
/* PROCEDIMIENTOS RELACIONADOS A LAS VENTAS / RENTAS DE LA EMPRESA */
/* ------------------------------------------------------------*/

/* ----- */
/*Procedimiento para alquilar un vehículo*/
/* 
Procedimiento para realizar el elquiler de un vehículo, cambia el estado de disponible a no disponible y 
agrega el resgistro a la tabla de alquileres. 
*/
DROP PROCEDURE IF EXISTS register_vehicle_rental; 
DELIMITER //
CREATE PROCEDURE register_vehicle_rental(
	IN id_cliente INT UNSIGNED, 
	IN id_empleado INT UNSIGNED, 
	IN id_vehiculo INT UNSIGNED, 
	IN id_sucursal_alquiler INT UNSIGNED,
	IN id_sucursal_entrega INT UNSIGNED, 
	IN fecha_salida TIMESTAMP, 
	IN fecha_esperada_llegada TIMESTAMP, 
	IN dias TINYINT UNSIGNED
) BEGIN 

	-- Handler for exceptions
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;
	
	-- Transaction 
	SET autocommit = 0;
	
	START TRANSACTION;
		SET @success = 0; 

		/*Revisa que el vehículo aún se encuentre disponible*/
		SELECT disponible INTO @is_disponible
		FROM VEHICULOS
		WHERE VEHICULOS.`id_vehiculo` = id_vehiculo; 
				
			IF @is_disponible = 1 THEN
			
				/*Calcular el precio*/
				SELECT valor_alquiler_semanal, valor_alquiler_diario, descuento INTO @alquiler_semanal, @alquiler_diario, @descuento
				FROM VEHICULOS
				WHERE VEHICULOS.id_vehiculo = id_vehiculo; 
				
				SET @semanas =TRUNCATE((dias/7), 0); 
				SET @dias_restantes = dias - (@semanas * 7); 
				SET @valor_cotizado = (@semanas * @alquiler_semanal) + (@dias_restantes * @alquiler_diario); 
				SET @valor_cotizado = @valor_cotizado - ((@valor_cotizado * @descuento)/100); 
						
				/*El vehículo ya no estará disponible para alquilar*/
				UPDATE `VEHICULOS` SET 
					`VEHICULOS`.disponible = 0, 
					`VEHICULOS`.veces_alquilado = `VEHICULOS`.veces_alquilado + 1 
				WHERE `VEHICULOS`.id_vehiculo = id_vehiculo; 
						
				/*
				Insertar el registro del alquiler
				Dentro del registro del alquiler, debe insertar el precio de alquiler diario y semanal del vehículo al momento
				en que el usuario realizó la solicitud
				*/
				INSERT INTO ALQUILERES(
						id_cliente, 
						id_empleado, 
						id_vehiculo,
						id_sucursal_alquiler, 
						id_sucursal_entrega, 
						fecha_salida, 
						fecha_esperada_llegada, 
						dias, 
						valor_diario_cotizado, 
						valor_semanal_cotizado, 
						valor_cotizado
				) VALUES (
					id_cliente, 
					id_empleado, 
					id_vehiculo, 
					id_sucursal_alquiler, 
					id_sucursal_entrega,
					fecha_salida, 
					fecha_esperada_llegada, 
					dias, 
					@alquiler_diario, 
					@alquiler_semanal,
					@valor_cotizado
				); 
				
				SET @success = 1; 
				
			END IF;
			
		COMMIT; 
	
	-- Final de la operacion
	SET autocommit = 1;
	SELECT @success; 
	
END //

DELIMITER ;
 
/*
CALL register_vehicle_rental(
	1, 
	3, 
	1, 
	1, 
	2, 
	'2022/3/25', 
	'2022/3/31', 
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
/*Procedimiento para ver el historial de alquileres de todos los clientes*/
DROP PROCEDURE IF EXISTS get_rental_history; 
DELIMITER //
CREATE PROCEDURE get_rental_history() 
BEGIN
	SELECT *
	FROM rental_data_history_pretty; 
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
) BEGIN 

	/*Se actualiza la fecha de llegada*/
	UPDATE alquileres SET alquileres.fecha_llegada = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 

END//

DELIMITER ;

/*
CALL register_vehicle_arrival(1); 
CALL register_vehicle_arrival(2);
CALL register_vehicle_arrival(3);
*/

/* ----- */
/*Procedimiento para registrar cuando un cliente reocge el vehículo en la sucursal destino
Cuando el cliente recoje el vehículo, se añade el registro a la columna de fecha_entrega_pactada añadiendo
los días de alquiler a la fecha de recogida. 
*/
DROP PROCEDURE IF EXISTS register_vehicle_pickup; 
DELIMITER //
CREATE PROCEDURE register_vehicle_pickup(
	id_alquiler INT UNSIGNED
) BEGIN 

	/*Se actualiza la fecha de recogida*/
	UPDATE alquileres SET alquileres.fecha_recogida = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 
		
		/*Se actualiza la fecha máxima de entrega a partir de los días del alquiler y la fecha de recogida*/
	UPDATE alquileres SET alquileres.fecha_entrega_pactada = ADDDATE(alquileres.fecha_recogida, alquileres.dias)
	WHERE alquileres.id_alquiler = id_alquiler;

END // 

DELIMITER ;

/*
CALL register_vehicle_pickup(1); 
CALL register_vehicle_pickup(2); 
CALL register_vehicle_pickup(3); 
*/

/* ----- */
/*Procedimiento para registrar cuando un cliente entrega el vehículo
Si el cliente entregó el vehículo luego de la fecha pactada, se calculan el monto por mora a partir
de los días de demora. 
*/
DROP PROCEDURE IF EXISTS register_vehicle_return; 
DELIMITER //
CREATE PROCEDURE register_vehicle_return(
	id_alquiler INT UNSIGNED
) BEGIN 

	/*Se agrega el registro de la devolución del vehículo por parte del cliente*/
	UPDATE alquileres SET alquileres.fecha_entrega = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 
		
		/*Se calculan los días de mora*/
	SELECT fecha_entrega_pactada, fecha_entrega, id_vehiculo INTO @fecha_entrega_pactada, @fecha_entrega, @vehiculo
	FROM alquileres
	WHERE alquileres.id_alquiler = id_alquiler; 
		
		IF @fecha_entrega_pactada < @fecha_entrega THEN 
			SET @mora = TIMESTAMPDIFF(DAY, @fecha_entrega_pactada,@fecha_entrega);
			UPDATE alquileres SET alquileres.dias_mora = @mora
			WHERE alquileres.id_alquiler = id_alquiler; 
		END IF; 
		
		/*Se actualiza el estado disponible del vehículo*/
	UPDATE `VEHICULOS` SET
			`VEHICULOS`.disponible = 1
	WHERE `VEHICULOS`.`id_vehiculo` = @vehiculo;

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
) BEGIN 

	SET @recargo = 0; 
	
	/*Se genera el valor a pagar a partir del valor cotizado y los días de mora (si se da el caso)*/
	
	/*Valor base que el cliente paga si no hay nada de mora*/
	SELECT a.valor_cotizado, a.dias_mora, a.valor_diario_cotizado INTO @total_pagar, @dias_mora, @freezed_daily
	FROM alquileres AS a
	WHERE a.id_alquiler = id_alquiler; 
		
	/*Interés por mora que se cobra al cliente por los días de retraso*/
	IF (@dias_mora > 0) THEN 
		/*Cálculo del 8% de recargo*/ 
		SET @interes = (@dias_mora * @freezed_daily) * 0.08; 
		SET @recargo = (@dias_mora * @freezed_daily) + @interes; 
	END IF; 	
	
	/*Crea la factura, siendo el total a pagar el valor cotizado por el cliente mas los recargos por mora, 
	en caso de ser necesario */
	INSERT INTO factura (id_alquiler, totaL_pagar) VALUES (
		id_alquiler, 
		(@totaL_pagar + @recargo)
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
) BEGIN
	SELECT *
	FROM factura AS f
	WHERE f.id_alquiler = id_alquiler; 
END //

DELIMITER ;

/* 
CALL consult_bill(1); 
*/

/* ------- */
/*Procedimiento para registrar el pago de una factura
Se sobre-entiende que el pago completo se realiza en un solo pago*/
DROP PROCEDURE IF EXISTS register_payment; 

DELIMITER //
CREATE PROCEDURE register_payment(
 IN id_factura INT UNSIGNED
) BEGIN 

	/*Cambia la columna de estado was_paid*/
	UPDATE factura SET 
			factura.was_paid = 1,
			factura.valor_pagado = factura.totaL_pagar
	WHERE factura.id_factura = id_factura; 

END//

DELIMITER ; 

/* 
CALL register_payment(1); 
*/
