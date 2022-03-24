/* ------------------------------------------------------------*/
/* PROCEDIMIENTOS RELACIONADOS AL MANEJO DE CUENTAS DE USUARIOS*/
/* ------------------------------------------------------------*/

/* ----- */
/*Procedures para el manejo de cuentas de usuario ¿*/

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

	/*Encriptar la contraseña*/
	SET @hashed = SHA2(contraseña, 256); 
	
	INSERT INTO usuarios(nombres, apellidos, identificacion, direccion, ciudad_residencia, celular, correo_electrónico, contraseña, código_tipo_usuario) VALUES(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		ciudad_residencia, 
		celular, 
		correo_electrónico, 
		@hashed, 
		3
	); 

END //

DELIMITER ; 

/*
CALL register_new_client('Pedro Andrés', 'Chaparro Quintero', '1005142366', 'Cra 4 No. 4-32 Cañaveral','Bucaramanga', '3221458999', 'pedro.chaparro.2020@upb.edu.co', 'contraseñasegura'); 
*/


/* ----- */
/* Procedimiento para el inicio de sesión por parte de clientes */
DROP PROCEDURE IF EXISTS user_login; 
DELIMITER //

CREATE PROCEDURE user_login(
	IN correo_electrónico VARCHAR(255), 
	IN contraseña VARCHAR(255) 
)
BEGIN 

	SET @success = 0; 

	SELECT COUNT(correo_electrónico) 'exists' INTO @user_exists FROM usuarios
			WHERE usuarios.correo_electrónico = correo_electrónico; 
	
	/*Si el usuario existe verifica que la contraseña sea correcta*/
	IF @user_exists = 1 THEN  
		
		SET @hashed = SHA2(contraseña, 256); 
		
		SELECT usuarios.contraseña INTO @saved_password FROM usuarios 
			WHERE usuarios.correo_electrónico = correo_electrónico; 
			
		SELECT @saved_password; 
		
		IF @saved_password = @hashed THEN
			SET @success = 1; 
		END IF;

	END IF; 
	
	/*Retorna True (1) o False (0) según si el login fue correcto*/
	SELECT @success; 
	
END //

DELIMITER ;


/*
CALL user_login('pedro.chaparro.2020@upb.edu.co', 'contraseñasegura'); 
*/


/* ----- */
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
