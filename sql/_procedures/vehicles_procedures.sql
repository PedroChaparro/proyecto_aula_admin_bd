/* ------------------------------------------------------------*/
/* PROCEDIMIENTOS RELACIONADOS AL MANEJO DE VEHÍCULOS 		   */
/* ------------------------------------------------------------*/

/* ------------------------- */
/*        CRUD BASICS        */
/* ------------------------- */

/* ----- */
/* CREATE */
DROP PROCEDURE IF EXISTS register_vehicle; 
DELIMITER //

CREATE PROCEDURE register_vehicle(
	IN matrícula VARCHAR(6), 
	IN código_tipo_vehículo INT UNSIGNED, 
	IN modelo VARCHAR(64), 
	IN número_puertas TINYINT(2) UNSIGNED, 
	IN capacidad TINYINT(2) UNSIGNED,
	IN has_sunroof TINYINT(1) UNSIGNED, 
	IN código_tipo_motor INT UNSIGNED, 
	IN color VARCHAR(64), 
	IN disponible TINYINT(1) UNSIGNED, 
	IN valor_alquiler_semanal DECIMAL(12,2), 
	IN valor_alquiler_diario DECIMAL(12,2),
	IN descuento DECIMAL(3,1) 
)
BEGIN

	INSERT INTO VEHÍCULOS(
		matrícula, 
		código_tipo_vehículo, 
		modelo, 
		número_puertas, 
		capacidad, 
		has_sunroof, 
		código_tipo_motor, 
		color, 
		disponible, 
		valor_alquiler_semanal, 
		valor_alquiler_diario, 
		descuento
	) VALUES (
		matrícula, 
		código_tipo_vehículo, 
		modelo, 
		número_puertas, 
		capacidad, 
		has_sunroof, 
		código_tipo_motor, 
		color, 
		disponible, 
		valor_alquiler_semanal, 
		valor_alquiler_diario, 
		descuento
	); 


END//
DELIMITER ;

/* ----- */
/* DELETE */
/* En este caso el vehículo no se elimina de la base de datos, ya que eso podría causar problemas
	en la integridad referencial de las órdenes de compra pasadas, solamente se cambia el estado 
	disponible a falso
*/
DROP PROCEDURE IF EXISTS disable_vehicle; 
DELIMITER //

CREATE PROCEDURE disable_vehicle(
	IN id_vehículo INT UNSIGNED
)
BEGIN 
	
	UPDATE VEHÍCULOS SET disponible = 0 
		WHERE VEHÍCULOS.`id_vehículo` = id_vehículo; 
	
END//

DELIMITER ;

/* ----- */
/* UPDATE */
DROP PROCEDURE IF EXISTS update_vehicle; 
DELIMITER //

CREATE PROCEDURE update_vehicle(
	IN id_vehículo INT UNSIGNED,
	IN matrícula VARCHAR(6), 
	IN has_sunroof TINYINT(1) UNSIGNED, 
	IN código_tipo_motor INT UNSIGNED, 
	IN color VARCHAR(64), 
	IN disponible TINYINT(1) UNSIGNED, 
	IN valor_alquiler_semanal DECIMAL(12,2), 
	IN valor_alquiler_diario DECIMAL(12,2),
	IN descuento DECIMAL(3,1) 
)
BEGIN

	UPDATE VEHÍCULOS SET
		VEHÍCULOS.`matrícula` = matrícula, 
		VEHÍCULOS.has_sunroof = has_sunroof, 
		VEHÍCULOS.`código_tipo_motor` = código_tipo_motor, 
		VEHÍCULOS.color = color, 
		VEHÍCULOS.disponible = disponible, 
		VEHÍCULOS.valor_alquiler_semanal = valor_alquiler_semanal, 
		VEHÍCULOS.valor_alquiler_diario = valor_alquiler_diario, 
		VEHÍCULOS.descuento = descuento
	WHERE VEHÍCULOS.`id_vehículo` = 


END//
DELIMITER ;

/* ----- */
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

/* ----- */
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

/* ----- */
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

/* ----- */
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
CALL set_disccount_to_vehicle_type(1, 20); 
*/

/*
CALL set_disccount_to_vehicle_type(
	6, 
	30.5
);
*/ 