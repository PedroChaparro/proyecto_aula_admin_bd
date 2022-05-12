/* ------------------------------------------------------------*/
/* PROCEDIMIENTOS RELACIONADOS AL MANEJO DE VEHICULOS 		   */
/* ------------------------------------------------------------*/

/* ------------------------- */
/*        CRUD BASICS        */
/* ------------------------- */

/*
Funcion para saber si un vehiculo existe a partir de la matricula
/*/
DROP FUNCTION IF EXISTS vehicle_exists_from_plate;

DELIMITER //

CREATE FUNCTION vehicle_exists_from_plate(
	matricula VARCHAR(6)
)
RETURNS BOOLEAN
NOT DETERMINISTIC
BEGIN 

	SELECT COUNT(matricula) INTO @is_plate_duplicated
    FROM vehiculos
    WHERE vehiculos.matricula = matricula;
    
    IF(@is_plate_duplicated = 0) THEN 
		RETURN FALSE;
	ELSE
		RETURN TRUE;
	END IF;
    
END//

DELIMITER ;

/* ----- */
/* CREATE */
DROP PROCEDURE IF EXISTS register_vehicle; 
DELIMITER //
CREATE PROCEDURE register_vehicle(
	IN matricula VARCHAR(6), 
	IN codigo_tipo_vehiculo INT UNSIGNED, 
	IN modelo VARCHAR(64), 
	IN numero_puertas TINYINT(2) UNSIGNED, 
	IN capacidad TINYINT(2) UNSIGNED,
	IN has_sunroof TINYINT(1) UNSIGNED, 
	IN codigo_tipo_motor INT UNSIGNED, 
	IN color VARCHAR(64), 
	IN disponible TINYINT(1) UNSIGNED, 
	IN valor_alquiler_semanal DECIMAL(12,2), 
	IN valor_alquiler_diario DECIMAL(12,2),
	IN descuento DECIMAL(3,1) 
) BEGIN

	/* Se verifica que no exista un vehiculo con la misma matricula */
    SET @vehicle_exists = vehicle_exists_from_plate(matricula);

	IF(@vehicle_exists = FALSE) THEN
		INSERT INTO VEHICULOS(
			matricula, 
			codigo_tipo_vehiculo, 
			modelo, 
			numero_puertas, 
			capacidad, 
			has_sunroof, 
			codigo_tipo_motor, 
			color, 
			disponible, 
			valor_alquiler_semanal, 
			valor_alquiler_diario, 
			descuento
		) VALUES (
			matricula, 
			codigo_tipo_vehiculo, 
			modelo, 
			numero_puertas, 
			capacidad, 
			has_sunroof, 
			codigo_tipo_motor, 
			color, 
			disponible, 
			valor_alquiler_semanal, 
			valor_alquiler_diario, 
			descuento
		); 
        
        SELECT JSON_OBJECT('code', 201, 'error', null) 'Response';
        
    ELSE 
    
		/*Si es repetido se envia un codigo de respuesta*/
		SELECT JSON_OBJECT('code', -400, 'error', 'La entrada para la matricula del vehiculo es duplicada') 'Response';
    
    END IF;
    
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
	IN id_vehiculo INT UNSIGNED
) BEGIN
	UPDATE VEHICULOS SET disponible = 0
	WHERE VEHICULOS.`id_vehiculo` = id_vehiculo; 
END//

DELIMITER ;

/* ----- */
/* UPDATE */
DROP PROCEDURE IF EXISTS update_vehicle; 
DELIMITER //
CREATE PROCEDURE update_vehicle(
	IN id_vehiculo INT UNSIGNED,
	IN matricula VARCHAR(6), 
	IN has_sunroof TINYINT(1) UNSIGNED, 
	IN codigo_tipo_motor INT UNSIGNED, 
	IN color VARCHAR(64), 
	IN disponible TINYINT(1) UNSIGNED, 
	IN valor_alquiler_semanal DECIMAL(12,2), 
	IN valor_alquiler_diario DECIMAL(12,2),
	IN descuento DECIMAL(3,1) 
) BEGIN

	/* Se verifica que no exista un vehiculo con la misma matricula */
    SET @vehicle_exists = vehicle_exists_from_plate(matricula);
    
    IF(@vehicle_exists = TRUE) THEN 
    
		UPDATE VEHICULOS SET
			VEHICULOS.`matricula` = matricula, 
			VEHICULOS.has_sunroof = has_sunroof, 
			VEHICULOS.`codigo_tipo_motor` = codigo_tipo_motor, 
			VEHICULOS.color = color, 
			VEHICULOS.disponible = disponible, 
			VEHICULOS.valor_alquiler_semanal = valor_alquiler_semanal, 
			VEHICULOS.valor_alquiler_diario = valor_alquiler_diario, 
			VEHICULOS.descuento = descuento
		WHERE VEHICULOS.`id_vehiculo` = `id_vehiculo`;
        
        SELECT JSON_OBJECT('code', 200, 'error', null) 'Response';
        
    ELSE 
		
        SELECT JSON_OBJECT('code', -400, 'error', 'No se encontro el vehiculo especificado') 'Response';
        
    END IF;
    
    END//
    
DELIMITER ;

/* ----- */
/*Procedimiento para consultar vehiculos disponibles*/
DROP PROCEDURE IF EXISTS get_available_vehicles; 
DELIMITER //
CREATE PROCEDURE get_available_vehicles() BEGIN
	SELECT *
	FROM VEHICLES_INFORMATION_PRETTY
	WHERE disponible = 1; 
END //

DELIMITER ; 

/*
CALL get_available_vehicles(); 
*/

/* ----- */
/*Procedimiento para consultar vehiculos disponibles por su tipo*/
DROP PROCEDURE IF EXISTS get_available_vehicles_filter_by_type; 
DELIMITER //
CREATE PROCEDURE get_available_vehicles_filter_by_type(
	IN tipo_vehiculo VARCHAR(255) 
) BEGIN
	SELECT *
	FROM VEHICLES_INFORMATION_PRETTY
	WHERE 
		disponible = 1 AND
		VEHICLES_INFORMATION_PRETTY.tipo_vehiculo = tipo_vehiculo; 
END //

DELIMITER ; 

/*
CALL get_available_vehicles_filter_by_type('Compacto'); 
*/

/* ----- */
/*Procedimiento para consultar vehiculos disponibles por un rango de precios*/
DROP PROCEDURE IF EXISTS get_available_vehicles_filter_by_price; 
DELIMITER //
CREATE PROCEDURE get_available_vehicles_filter_by_price(
	IN min_price DECIMAL(12,2), 
	IN max_price DECIMAL(12,2)
) BEGIN
	SELECT *
	FROM VEHICLES_INFORMATION_PRETTY
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
	IN tipo_vehiculo INT UNSIGNED, 
	IN descuento DECIMAL(3,1)
) BEGIN
	UPDATE VEHICULOS SET VEHICULOS.descuento = descuento
	WHERE VEHICULOS.`codigo_tipo_vehiculo` = tipo_vehiculo;
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