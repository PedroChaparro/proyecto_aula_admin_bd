/* ------------------------------------------------------------*/
/* PROCEDIMIENTOS RELACIONADOS AL MANEJO DE VEHÍCULOS 		   */
/* ------------------------------------------------------------*/

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
CALL set_disccount_to_vehicle_type(
	6, 
	30.5
);
*/ 