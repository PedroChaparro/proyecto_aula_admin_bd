/* ------------------------------------------------------------*/
/* PROCEDIMIENTOS RELACIONADOS AL MANEJO DE CUENTAS DE USUARIOS*/
/* ------------------------------------------------------------*/

/* ------------------------- */
/*        CRUD BASICS        */
/* ------------------------- */

/* ----- */
/* CREATE */

/* ----- */
/*Procedures para el manejo de cuentas de usuario
Este es el procedure que usarían los clientes al momento de registrarse desde el aplicativo web o móvil
*/
DROP PROCEDURE IF EXISTS register_new_client; 
DELIMITER //
CREATE PROCEDURE register_new_client(
	IN nombres VARCHAR(255), 
	IN apellidos VARCHAR(255), 
	IN identificacion VARCHAR(14), 
	IN direccion VARCHAR(255), 
	IN id_ciudad_residencia INT UNSIGNED, 
	IN celular VARCHAR(10), 
	IN correo_electrónico VARCHAR(255), 
	IN contraseña VARCHAR(255) 
) BEGIN 

	/*Encriptar la contraseña*/ 
	SET @hashed = SHA2(contraseña, 256);

	INSERT INTO 
	usuarios(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electrónico, 
		contraseña, 
		código_tipo_usuario
	) VALUES(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electrónico, 
		@hashed, 
		3
); END //

DELIMITER ; 

/* ----- */
/*Procedimiento para el registro de cuentas internas
Este procedure sería el usado por los administradores para crear cuentas con permisos dentro de la empresa
*/
DROP PROCEDURE IF EXISTS register_new_internal_user; 
DELIMITER //
CREATE PROCEDURE register_new_internal_user(
	IN nombres VARCHAR(255), 
	IN apellidos VARCHAR(255), 
	IN identificacion VARCHAR(14), 
	IN direccion VARCHAR(255), 
	IN id_ciudad_residencia INT UNSIGNED, 
	IN celular VARCHAR(10), 
	IN correo_electrónico VARCHAR(255), 
	IN contraseña VARCHAR(255), 
	IN código_tipo_usuario INT UNSIGNED, 
	IN código_sucursal INT UNSIGNED
) BEGIN
INSERT INTO usuarios(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electrónico, 
		contraseña, 
		código_tipo_usuario, 
		código_sucursal
	) VALUES(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electrónico, 
		contraseña, 
		código_tipo_usuario, 
		código_sucursal
	); 
END //

DELIMITER ; 

/* ----- */
/* REMOVE */
/* En este caso la cuenta no se elimina de la base de datos, ya que eso podría causar problemas
	en la integridad referencial de las órdenes de compra pasadas, solamente se cambia el estado 
	is_active a falso
*/
DROP PROCEDURE IF EXISTS disable_user; 
DELIMITER //
CREATE PROCEDURE disable_user(
	IN id_usuario INT UNSIGNED
) 
BEGIN
	UPDATE usuarios SET is_active = 0
	WHERE usuarios.id_usuario = id_usuario; 
END// 
DELIMITER ;

/* ----- */
/* UPDATE */
DROP PROCEDURE IF EXISTS update_user; 
DELIMITER //
CREATE PROCEDURE update_user(
	IN id_usuario INT UNSIGNED, 
	IN direccion VARCHAR(255), 
	IN id_ciudad_residencia INT UNSIGNED, 
	IN celular VARCHAR(10), 
	IN correo_electrónico VARCHAR(255),
	IN contraseña_actual VARCHAR(255)
) BEGIN 

	SET @success = 0; 

	/*Encriptar la contraseña*/ 
	SET @hashed = SHA2(contraseña_actual, 256); 
	
	/*Obtener la contraseña actual*/
	SELECT usuarios.contraseña INTO @saved_password
	FROM usuarios
	WHERE usuarios.id_usuario = id_usuario; 
	
	IF @hashed = @saved_password THEN
		UPDATE usuarios SET
			usuarios.direccion = direccion, 
			usuarios.id_ciudad_residencia = id_ciudad_residencia, 
			usuarios.celular = celular, 
			usuarios.`correo_electrónico` = correo_electrónico
		WHERE usuarios.id_usuario = id_usuario; 
		
		SET @success = 1; 
	END IF;

	SELECT @success;

END//

/* ----- */
/* Procedimiento para el inicio de sesión por parte de clientes */
DROP PROCEDURE IF EXISTS user_login; 
DELIMITER //
CREATE PROCEDURE user_login(
	IN correo_electrónico VARCHAR(255), 
	IN contraseña VARCHAR(255) 
) BEGIN 

	SET @success = 0;
	SELECT COUNT(correo_electrónico) 'exists' INTO @user_exists
	FROM usuarios
	WHERE usuarios.correo_electrónico = correo_electrónico; 
	
	/*Si el usuario existe verifica que la contraseña sea correcta*/
	IF @user_exists = 1 THEN 
		
		/*Encripta la contraseña para compararla con la que está en la base de datos*/ 
		SET @hashed = SHA2(contraseña, 256);

		SELECT usuarios.contraseña INTO @saved_password
		FROM usuarios
		WHERE usuarios.correo_electrónico = correo_electrónico; 
		
		IF @saved_password = @hashed THEN 
        
			-- Si la contraseña es correcta, regresa algunos datos del usuario para la sesión
			SELECT id_usuario, CONCAT(nombres, ' ',apellidos) 'NAME', `correo_electrónico` 'MAIL' 
            FROM USUARIOS
            WHERE USUARIOS.`correo_electrónico` = correo_electrónico;
            
		END IF; 
	
	END IF; 
END //

DELIMITER ;

-- CALL user_login('Maria.Feil@gmail.com', 'Maria.Feil2021*/'); 

/*Clientes para la sucursal de bucaramanga*/
CALL register_new_client('Violet','Nicolas','37614521','Cra 6002 Vía Ankunding Passage',538,'3145641789','Violet.Nicolas@gmail.com','Violet.Nicolas2021*/'); CALL register_new_client('Olivia','Heathcote','39090152','Cra 03550 Vía Parker Loop',538,'3146296504','Olivia.Heathcote@gmail.com','Olivia.Heathcote2021*/'); CALL register_new_client('Ted','Wintheiser','40565783','Cra 516 Vía D.Amore Valleys',538,'3146951219','Ted.Wintheiser@gmail.com','Ted.Wintheiser2021*/'); CALL register_new_client('Oliver','Runolfsson','42041414','Cra 7317 Vía Araceli Mall',538,'3147605934','Oliver.Runolfsson@gmail.com','Oliver.Runolfsson2021*/'); CALL register_new_client('Clinton','Bosco','43517045','Cra 83324 Vía Kunze Prairie',538,'3148260649','Clinton.Bosco@gmail.com','Clinton.Bosco2021*/'); CALL register_new_client('Louis','Cummerata','44992676','Cra 255 Vía Laron Drives',486,'3148915364','Louis.Cummerata@gmail.com','Louis.Cummerata2021*/'); CALL register_new_client('Diane','Smith','46468307','Cra 6091 Vía Darlene Lake',486,'3149570079','Diane.Smith@gmail.com','Diane.Smith2021*/'); CALL register_new_client('Phyllis','Krajcik','47943938','Cra 011 Vía Ubaldo Shoal',486,'3150224794','Phyllis.Krajcik@gmail.com','Phyllis.Krajcik2021*/'); CALL register_new_client('Allison','Corwin','49419569','Cra 8869 Vía Maximillian Throughway',486,'3150879509','Allison.Corwin@gmail.com','Allison.Corwin2021*/');

/*Clientes para la sucursal de medellín*/ CALL register_new_client('Angelo','Osinski','50895200','Cra 755 Vía Coty Mount',486,'3151534224','Angelo.Osinski@gmail.com','Angelo.Osinski2021*/'); CALL register_new_client('Jimmie','Thompson','52370831','Cra 06365 Vía Green Pike',757,'3152188939','Jimmie.Thompson@gmail.com','Jimmie.Thompson2021*/'); CALL register_new_client('Mable','Fahey','53846462','Cra 8974 Vía Tromp Squares',757,'3152843654','Mable.Fahey@gmail.com','Mable.Fahey2021*/'); CALL register_new_client('Matthew','Howell','55322093','Cra 4120 Vía Cormier Walk',757,'3153498369','Matthew.Howell@gmail.com','Matthew.Howell2021*/'); CALL register_new_client('Mary','White','56797724','Cra 465 Vía Adelbert Islands',757,'3154153084','Mary.White@gmail.com','Mary.White2021*/'); CALL register_new_client('Verna','Hessel','58273355','Cra 588 Vía Rempel Island',757,'3154807799','Verna.Hessel@gmail.com','Verna.Hessel2021*/'); CALL register_new_client('Javier','Senger','59748986','Cra 0455 Vía Hammes Avenue',757,'3155462514','Javier.Senger@gmail.com','Javier.Senger2021*/'); CALL register_new_client('Betsy','Hahn','61224617','Cra 695 Vía Ottis Grove',757,'3156117229','Betsy.Hahn@gmail.com','Betsy.Hahn2021*/'); CALL register_new_client('Elizabeth','Champlin','62700248','Cra 5366 Vía Gottlieb Point',757,'3156771944','Elizabeth.Champlin@gmail.com','Elizabeth.Champlin2021*/'); CALL register_new_client('Bertha','Corwin','64175879','Cra 4300 Vía Hellen Locks',757,'3157426659','Bertha.Corwin@gmail.com','Bertha.Corwin2021*/'); CALL register_new_client('Jean','Ratke','65651510','Cra 6511 Vía Domenick Parks',757,'3158081374','Jean.Ratke@gmail.com','Jean.Ratke2021*/');

/*Clientes para la sucursal de bogotá*/ CALL register_new_client('Brent','Cruickshank','67127141','Cra 4453 Vía Fadel Drive',198,'3158736089','Brent.Cruickshank@gmail.com','Brent.Cruickshank2021*/'); CALL register_new_client('Brandi','Lowe','68602772','Cra 041 Vía Camden Forges',198,'3159390804','Brandi.Lowe@gmail.com','Brandi.Lowe2021*/'); CALL register_new_client('Moses','Lubowitz','70078403','Cra 24629 Vía Goyette Inlet',198,'3160045519','Moses.Lubowitz@gmail.com','Moses.Lubowitz2021*/'); CALL register_new_client('Jonathon','Macejkovic','71554034','Cra 498 Vía Von Estates',198,'3160700234','Jonathon.Macejkovic@gmail.com','Jonathon.Macejkovic2021*/'); CALL register_new_client('Nina','Welch','73029665','Cra 1981 Vía Victor Isle',198,'3161354949','Nina.Welch@gmail.com','Nina.Welch2021*/'); CALL register_new_client('Hector','Braun','74505296','Cra 12182 Vía Brayan Landing',198,'3162009664','Hector.Braun@gmail.com','Hector.Braun2021*/'); CALL register_new_client('Cedric','Schuster','75980927','Cra 23374 Vía Larson Drives',198,'3162664379','Cedric.Schuster@gmail.com','Cedric.Schuster2021*/'); CALL register_new_client('Isaac','Ankunding','77456558','Cra 6472 Vía Alycia Knolls',198,'3163319094','Isaac.Ankunding@gmail.com','Isaac.Ankunding2021*/'); CALL register_new_client('Stella','Raynor','78932189','Cra 2868 Vía Skyla Stravenue',198,'3163973809','Stella.Raynor@gmail.com','Stella.Raynor2021*/'); CALL register_new_client('Faith','Doyle','80407820','Cra 797 Vía Estella Track',198,'3164628524','Faith.Doyle@gmail.com','Faith.Doyle2021*/');

/* Clientes para la sucursal de cali */ CALL register_new_client('Jonathon','Yost','81883451','Cra 45757 Vía Farrell Club',1090,'3165283239','Jonathon.Yost@gmail.com','Jonathon.Yost2021*/'); CALL register_new_client('Emilio','Bartell','83359082','Cra 62492 Vía Anabelle Causeway',1090,'3165937954','Emilio.Bartell@gmail.com','Emilio.Bartell2021*/'); CALL register_new_client('Adrian','Zulauf','84834713','Cra 122 Vía Denesik Tunnel',1090,'3166592669','Adrian.Zulauf@gmail.com','Adrian.Zulauf2021*/'); CALL register_new_client('Dale','Harris','86310344','Cra 1774 Vía Schowalter Parkways',1090,'3167247384','Dale.Harris@gmail.com','Dale.Harris2021*/'); CALL register_new_client('Jean','Kreiger','87785975','Cra 8120 Vía Kertzmann Skyway',1090,'3167902099','Jean.Kreiger@gmail.com','Jean.Kreiger2021*/'); CALL register_new_client('Delbert','Schamberger','89261606','Cra 783 Vía Karlee Tunnel',1090,'3168556814','Delbert.Schamberger@gmail.com','Delbert.Schamberger2021*/'); CALL register_new_client('Clyde','O','90737237','Cra 738 Vía Amara Streets',1090,'3169211529','Clyde.O@gmail.com','Clyde.O2021*/'); CALL register_new_client('Jody','Romaguera','92212868','Cra 0514 Vía Goyette Throughway',1090,'3169866244','Jody.Romaguera@gmail.com','Jody.Romaguera2021*/'); CALL register_new_client('Gerardo','McLaughlin','93688499','Cra 0410 Vía Solon Ville',1090,'3170520959','Gerardo.McLaughlin@gmail.com','Gerardo.McLaughlin2021*/'); CALL register_new_client('Mona','Heathcote','95164130','Cra 2906 Vía Doyle Prairie',1090,'3171175674','Mona.Heathcote@gmail.com','Mona.Heathcote2021*/');

/*Clientes para la sucursal de Barranquilla*/ CALL register_new_client('Joanne','Buckridge','96639761','Cra 38659 Vía Mosciski Fords',4,'3171830389','Joanne.Buckridge@gmail.com','Joanne.Buckridge2021*/'); CALL register_new_client('Jan','Boehm','98115392','Cra 481 Vía Rippin Ranch',4,'3172485104','Jan.Boehm@gmail.com','Jan.Boehm2021*/'); CALL register_new_client('Deborah','Nicolas','99591023','Cra 46593 Vía Zoila Spring',4,'3173139819','Deborah.Nicolas@gmail.com','Deborah.Nicolas2021*/'); CALL register_new_client('Maria','Feil','101066654','Cra 47586 Vía Issac Avenue',4,'3173794534','Maria.Feil@gmail.com','Maria.Feil2021*/'); CALL register_new_client('Rachel','Zboncak','102542285','Cra 1946 Vía Ruecker Rapids',4,'3174449249','Rachel.Zboncak@gmail.com','Rachel.Zboncak2021*/'); CALL register_new_client('Rebecca','Morissette','104017916','Cra 4367 Vía Schmidt Pass',4,'3175103964','Rebecca.Morissette@gmail.com','Rebecca.Morissette2021*/'); CALL register_new_client('Kelli','Zemlak','105493547','Cra 7946 Vía Robel Mill',4,'3175758679','Kelli.Zemlak@gmail.com','Kelli.Zemlak2021*/'); CALL register_new_client('Kellie','Kunde','106969178','Cra 909 Vía Ofelia Crossroad',4,'3176413394','Kellie.Kunde@gmail.com','Kellie.Kunde2021*/'); CALL register_new_client('Debra','McGlynn','108444809','Cra 285 Vía McGlynn Garden',4,'3177068109','Debra.McGlynn@gmail.com','Debra.McGlynn2021*/'); CALL register_new_client('Johanna','Halvorson','109920440','Cra 967 Vía Connelly Loop',4,'3177722824','Johanna.Halvorson@gmail.com','Johanna.Halvorson2021*/');

/*Creación de los administradores de cada sucursal*/ CALL register_new_internal_user('Carlos','Laferte','36616203','Cra 5ta #6-70 La Rioja',538,'3117156320','carloslaferte@outlook.com','Carlos.Laferte2021*/',1,1);
CALL register_new_internal_user('Alejandra','Hernández','1004152789','Cra 6ta #20-50 El Prado',757,'3147895201','alejandrahdez@gmail.com','Alejandra.Hernandez2021*/',1,2);
CALL register_new_internal_user('Juan Sebastián','Urán','1004789522','Cll 5C #782-740 Kennedy',198,'3168952200','juanuran@outlook.com','Juan.Uran2021*/',1,3);
CALL register_new_internal_user('Maria','Vargas','37895620','Cll 7D #20-35 La Merced',1090,'3187452033','mariavargas@gmail.com','Maria.Vargas2021*/',1,4);
CALL register_new_internal_user('Breiner','Aguilar','1002156321','Cra 7 #20-35 Barlovento',4,'3174552217','breineraguilar@outlook.com','Breiner.Aguilar2021*/',1,5);

/* Creación de los trabajadores de cada sucursal */
CALL register_new_internal_user('Eva','Batz','36781299','Cra 155 Bechtelar Street',538,'3167852239','Eva.Batz@gmail.com','Eva.Batz2021*/',2,1); CALL register_new_internal_user('Brett','Abshire','36860203','Cra 73254 Padberg Cliff',538,'3167932080','Brett.Abshire@gmail.com','Brett.Abshire2021*/',2,1); CALL register_new_internal_user('Suzanne','Toy','36939107','Cra 89576 Maggio Meadows',757,'3168011921','Suzanne.Toy@gmail.com','Suzanne.Toy2021*/',2,2); CALL register_new_internal_user('Jennifer','Morar','37018011','Cra 750 Stella Brook',757,'3168091762','Jennifer.Morar@gmail.com','Jennifer.Morar2021*/',2,2); CALL register_new_internal_user('Salvatore','Douglas','37096915','Cra 6624 OConnell Well',198,'3168171603','Salvatore.Douglas@gmail.com','Salvatore.Douglas2021*/',2,3); CALL register_new_internal_user('Emilio','Welch','37175819','Cra 26737 Quigley Mission',198,'3168251444','Emilio.Welch@gmail.com','Emilio.Welch2021*/',2,3); CALL register_new_internal_user('Karl','Ziemann','37254723','Cra 3161 Hermiston Flat',1090,'3168331285','Karl.Ziemann@gmail.com','Karl.Ziemann2021*/',2,4); CALL register_new_internal_user('Kellie','Dietrich','37333627','Cra 84537 Jana Centers',1090,'3168411126','Kellie.Dietrich@gmail.com','Kellie.Dietrich2021*/',2,4); CALL register_new_internal_user('Wilbur','Grimes','37412531','Cra 1758 Wilderman Ways',4,'3168490967','Wilbur.Grimes@gmail.com','Wilbur.Grimes2021*/',2,5); CALL register_new_internal_user('Roman','Hoeger','37491435','Cra 31737 Hanna Viaduct',4,'3168570808','Roman.Hoeger@gmail.com','Roman.Hoeger2021*/',2,5);