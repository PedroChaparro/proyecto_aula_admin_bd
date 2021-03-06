DROP DATABASE IF EXISTS PROYECTO_AULA_BD;
CREATE DATABASE PROYECTO_AULA_BD CHARACTER SET 'utf8mb4';
USE PROYECTO_AULA_BD; 

/* -- */
CREATE TABLE TIPO_USUARIO(
	codigo_tipo_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	tipo_usuario VARCHAR(64) NOT NULL
)
CHARACTER SET 'utf8mb4' 
COMMENT 'Tabla para el manejo de usuarios / roles en el sistema, se incluyen: Administrador, Trabajador y Clientes.';

INSERT INTO TIPO_USUARIO(tipo_usuario) VALUES
	('Administrador'), 
	('Trabajador'), 
	('Cliente'); 


/* -- */
CREATE TABLE DEPARTAMENTOS(
	id_departamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	departamento VARCHAR(255) NOT NULL UNIQUE
)
CHARACTER SET 'utf8mb4' ; 

INSERT INTO DEPARTAMENTOS (departamento) VALUES
	('Antioquia'),
	('Boyacá'),
	('Córdoba'),
	('Chocó'),
	('Nariño'),
	('Santander'),
	('Meta'),
	('Atlántico'),
	('Bolívar'),
	('Caldas'),
	('Caquetá'),
	('Cauca'),
	('Cesar'),
	('Cundinamarca'),
	('Huila'),
	('La Guajira'),
	('Magdalena'),
	('Quindío'),
	('Risaralda'),
	('Sucre'),
	('Tolima'),
	('Arauca'),
	('Casanare'),
	('Putumayo'),
	('Amazonas'),
	('Guainía'),
	('Vaupés'),
	('Vichada'),
	('Guaviare'),
	('Archipiélago de San Andrés, Providencia y Santa Catalina'),
	('Bogotá D.C.'),
	('Norte de Santander'),
	('Valle del Cauca'); 

/* -- */
CREATE TABLE CIUDADES(
	id_ciudad INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	id_departamento INT UNSIGNED NOT NULL, 
	ciudad VARCHAR(255) NOT NULL, 
	
	CONSTRAINT fk_ciudad_departamento 
		FOREIGN KEY (id_departamento)
		REFERENCES `DEPARTAMENTOS`(id_departamento)
		ON UPDATE CASCADE
	
)
CHARACTER SET 'utf8mb4' ;  

/* 
################################
################################
ANTES DE INSERTAR LAS SUCURSALES ES NECESARIO INTSERTAR LAS CIUDADES DESDE
EL SCRIPT LOADER_MUNICIPIOS.sql
################################
################################
*/

/* -- */
CREATE TABLE SUCURSALES(
	id_sucursal INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	id_ciudad INT UNSIGNED NOT NULL, 
	direccion VARCHAR(255) NOT NULL UNIQUE, 
	telefono_fijo VARCHAR(7) NOT NULL UNIQUE, 
	celular VARCHAR(10) NOT NULL UNIQUE, 
	correo_electronico VARCHAR(255) NOT NULL UNIQUE, 
	
	CONSTRAINT fk_sucursal_ciudad 
		FOREIGN KEY (id_ciudad)
		REFERENCES `CIUDADES`(id_ciudad)
		ON UPDATE CASCADE, 
	
	INDEX sucursales_correo_electronico(correo_electronico)
)
CHARACTER SET 'utf8mb4' ; 

INSERT INTO SUCURSALES(id_ciudad, direccion, telefono_fijo, celular, correo_electronico) VALUES
	(486, 'Cra 4 #6-75 San Cristóbal', '6550000', '3170000000', 'sucursalbga@gmail.com'),
	(757, 'Cra 4 #6-75 San Joaquín', '6550001', '3170000001', 'sucursalmedellin@gmail.com'),
	(198, 'Cra 4 #6-75 Chapinero', '6550002', '3170000002', 'sucursalbgta@gmail.com'), 
	(1090, 'Cra 4 #6-75 El peñón', '6550003', '3170000003', 'sucursalcali@gmail.com'),
	(4, 'Cra 4 #6-75 Bella Vista', '6550004', '3170000004', 'sucursalbarranquilla@gmail.com'); 

/* -- */
CREATE TABLE USUARIOS(
	id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	nombres VARCHAR(255) NOT NULL, 
	apellidos VARCHAR(255) NOT NULL, 
	identificacion VARCHAR(14) NOT NULL UNIQUE COMMENT 'Cédula del cliente', 
	direccion VARCHAR(255) NOT NULL, 
	id_ciudad_residencia INT UNSIGNED NOT NULL, 
	celular VARCHAR(10) NOT NULL, 
	correo_electronico VARCHAR(255) NOT NULL UNIQUE, 
	user_password VARCHAR(255) NOT NULL, 
	codigo_tipo_usuario INT UNSIGNED NOT NULL, 
	codigo_sucursal INT UNSIGNED NULL DEFAULT NULL COMMENT 'Columna usada para asociar los trabajadores a la sucursal en la que trabajan',
	is_active TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
	
	
	INDEX usuarios_id_usuario(id_usuario), 
	INDEX usuario_nombres(nombres), 
	INDEX usuario_apellidos(apellidos), 
	INDEX usuario_correo_electronico(correo_electronico),
	
	CONSTRAINT fk_usuario_tipo_usuario 
		FOREIGN KEY (codigo_tipo_usuario)
		REFERENCES `TIPO_USUARIO`(codigo_tipo_usuario)
		ON UPDATE CASCADE, 
		
	CONSTRAINT fk_usuario_sucursal
		FOREIGN KEY (codigo_sucursal)
		REFERENCES `sucursales`(id_sucursal)
		ON UPDATE CASCADE, 
		
	CONSTRAINT fk_usuario_ciudad
		FOREIGN KEY (id_ciudad_residencia)
		REFERENCES `CIUDADES`(id_ciudad)
		ON UPDATE CASCADE
)
CHARACTER SET 'utf8mb4' ;

/* -- */
CREATE TABLE TIPO_MOTOR(
	codigo_tipo_motor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	motor VARCHAR(64) NOT NULL UNIQUE
)
CHARACTER SET 'utf8mb4' ;

INSERT INTO TIPO_MOTOR(motor) VALUES
	('Atmosférico'), 
	('Monocilíndrico'), 
	('Doble cilíndro'), 
	('Cilindro opuesto'), 
	('Multicilíndrico');  

/* -- */
CREATE TABLE TIPO_VEHICULO(
	codigo_tipo_vehiculo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	tipo_vehiculo VARCHAR(64) NOT NULL
)
CHARACTER SET 'utf8mb4' ; 


INSERT INTO TIPO_VEHICULO(tipo_vehiculo) VALUES
	('Sedán / Berlina'),
	('Compacto'), 
	('Camioneta platón'),
	('Camioneta de lujo'),
	('Deportivo'),    
	('Coupé'), 
	('Familiar'), 
	('Furgoneta'), 
	('Monovolumen'), 
	('Superdeportivo'); 


/* -- */
CREATE TABLE VEHICULOS(
	id_vehiculo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	matricula VARCHAR(6) NOT NULL UNIQUE, 	
	codigo_tipo_vehiculo INT UNSIGNED NOT NULL, 
	modelo VARCHAR(64) NOT NULL, 
	numero_puertas TINYINT(2) UNSIGNED NOT NULL, 
	capacidad TINYINT(2) UNSIGNED NOT NULL, 
	has_sunroof TINYINT(1) UNSIGNED NOT NULL, 
	codigo_tipo_motor INT UNSIGNED NOT NULL, 
	color VARCHAR(64) NOT NULL, 
	disponible TINYINT(1) UNSIGNED NOT NULL, 
	valor_alquiler_semanal DECIMAL(12,2) NOT NULL, 
	valor_alquiler_diario DECIMAL(12,2) NOT NULL,
	descuento DECIMAL(3,1) NOT NULL, 
	veces_alquilado INT UNSIGNED NOT NULL DEFAULT 0,
	
	INDEX vehiculo_matricula(matricula), 
	INDEX vehiculo_modelo(modelo), 
	INDEX vehiculo_disponible(disponible), 
	INDEX vehiculo_tipo_vehiculo(codigo_tipo_vehiculo), 
	INDEX vehiculo_descuento(descuento), 
	
	CONSTRAINT fk_vehiculo_tipo_vehiculo
		FOREIGN KEY (codigo_tipo_vehiculo)
		REFERENCES TIPO_VEHICULO(codigo_tipo_vehiculo)
		ON UPDATE CASCADE, 
		
	CONSTRAINT fk_vehiculo_tipo_motor
		FOREIGN KEY (codigo_tipo_motor)
		REFERENCES TIPO_MOTOR(codigo_tipo_motor)
		ON UPDATE CASCADE
	
)
CHARACTER SET 'utf8mb4' ; 

INSERT INTO VEHICULOS(matricula, codigo_tipo_vehiculo, modelo, numero_puertas, capacidad, has_sunroof, codigo_tipo_motor, color, disponible, valor_alquiler_semanal, valor_alquiler_diario, descuento) VALUES 
('GOA001',1,'Onix',4,5,1,2,'Negro',1,460000,55857, 0),
('GOA002',1,'Logan',4,5,0,3,'Blanco',1,470000,57071, 0),
('GOA003',1,'Beat',4,5,1,4,'Azul',1,480000,58285, 0),
('GOA004',1,'Versa',4,5,0,5,'Rojo',1,490000,59500, 0),
('GOA005',1,'Joy',4,5,1,2,'Gris',1,440000,53428, 0),
('GOA006',2,'Sandero',4,4,1,3,'Negro',1,575000,69821, 0),
('GOA007',2,'Twingo',2,4,0,4,'Blanco',1,540000,65571, 0),
('GOA008',2,'Picanto',4,4,1,5,'Azul',1,580000,70428, 0),
('GOA009',2,'Gravity',4,4,0,2,'Rojo',1,575000,69821, 0),
('GOA010',2,'Ibiza',2,4,1,3,'Gris',1,540000,65571, 0),
('GOA011',3,'Amarok',4,5,0,4,'Negro',1,640000,77714, 0),
('GOA012',3,'Saveiro',4,5,0,5,'Blanco',1,655000,79535, 0),
('GOA013',3,'Ranger',4,5,0,2,'Azul',1,665000,80750, 0),
('GOA014',3,'Raptor',4,5,0,3,'Rojo',1,670000,81357, 0),
('GOA015',3,'F-150',4,5,0,4,'Gris',1,620000,75285, 0),
('GOA016',4,'Evoque ',4,5,0,5,'Negro',1,575000,69821, 0),
('GOA017',4,'Acadia',4,5,0,2,'Blanco',1,540000,65571, 0),
('GOA018',4,'Navigator',4,5,0,3,'Azul',1,580000,70428, 0),
('GOA019',4,'QX80 Infiniti',4,5,0,4,'Rojo',1,575000,69821, 0),
('GOA020',4,'Cayenne',4,5,0,5,'Gris',1,540000,65571, 0),
('GOA021',5,'Supra',2,2,0,2,'Negro',1,740000,89857, 0),
('GOA022',5,'DB11',4,4,0,3,'Blanco',1,720000,87428, 0),
('GOA023',5,'Subaru',4,4,1,4,'Azul',1,695000,84392, 0),
('GOA024',5,'M5',2,2,0,5,'Rojo',1,710000,86214, 0),
('GOA025',5,'MX-5 RF',2,2,0,2,'Gris',1,765000,92892, 0),
('GOA026',6,'e-tron GT',4,4,1,3,'Negro',1,575000,69821, 0),
('GOA027',6,'Camaro',4,4,1,4,'Blanco',1,540000,65571, 0),
('GOA028',6,'Mustang',4,4,1,5,'Azul',1,580000,70428, 0),
('GOA029',6,'Shelby',4,4,1,2,'Rojo',1,575000,69821, 0),
('GOA030',6,'F-Type',4,4,1,3,'Gris',1,540000,65571, 0),
('GOA031',7,'Qashqai',4,5,0,4,'Negro',1,460000,55857, 0),
('GOA032',7,'Compass',4,5,0,5,'Blanco',1,470000,57071, 0),
('GOA033',7,'Odyssey',4,5,0,2,'Azul',1,480000,58285, 0),
('GOA034',7,'Jetta',4,5,0,3,'Rojo',1,490000,59500, 0),
('GOA035',7,'Accent',4,5,0,4,'Gris',1,440000,53428, 0),
('GOA036',8,'Dokker',4,7,0,5,'Negro',1,640000,77714, 0),
('GOA037',8,'Kangoo',2,9,0,2,'Blanco',1,655000,79535, 0),
('GOA038',8,'Dobló',4,7,0,3,'Azul',1,665000,80750, 0),
('GOA039',8,'Proace City',2,9,0,4,'Rojo',1,670000,81357, 0),
('GOA040',8,'Rifter',4,7,0,5,'Gris',1,620000,75285, 0),
('GOA041',9,'Active Tourer',4,5,0,2,'Negro',1,460000,55857, 0),
('GOA042',9,'Jazz',4,5,0,3,'Blanco',1,470000,57071, 0),
('GOA043',9,'E-Rifter',4,5,0,4,'Azul',1,480000,58285, 0),
('GOA044',9,'E-Berlingo',2,5,0,5,'Rojo',1,490000,59500, 0),
('GOA045',9,'Space Tourer',2,5,0,2,'Gris',1,440000,53428, 0),
('GOA046',10,'AUV',2,2,1,1,'Negro',1,2200000,267142, 0),
('GOA047',10,'R8',4,2,1,1,'Blanco',1,1850000,224642, 0),
('GOA048',10,'Sián',2,2,1,1,'Azul',1,1950000,236785, 0),
('GOA049',10,'Spyder',2,2,1,1,'Rojo',1,1850000,224642, 0),
('GOA050',10,'Gemera',2,2,1,1,'Gris',1,1850000,224642, 0); 

/* -- */
CREATE TABLE ALQUILERES(
	id_alquiler INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	id_cliente INT UNSIGNED NOT NULL, 
	id_empleado INT UNSIGNED NOT NULL,
	id_vehiculo INT UNSIGNED NOT NULL,  
	id_sucursal_alquiler INT UNSIGNED NOT NULL, 
	id_sucursal_entrega INT UNSIGNED NOT NULL, 
	dias TINYINT UNSIGNED NOT NULL, 
	valor_diario_cotizado DECIMAL(12,2) NOT NULL COMMENT 'Columna para congelar el valor diario al que el cliente alquiló el vehículo', 
	valor_semanal_cotizado DECIMAL(12,2) NOT NULL COMMENT 'Column para congelar el valor semanal al que el cliente alquiló el vehículo', 
	valor_cotizado DECIMAL(12,2) NOT NULL COMMENT 'Columna para congelar el valor total que el cliente cotizó por el vehículo', 
	valor_pagado DECIMAL(12,2) NULL DEFAULT NULL,
	
	fecha_salida TIMESTAMP NOT NULL, 
	
	fecha_esperada_llegada TIMESTAMP NOT NULL COMMENT 'Fecha esperada de llegada del vehículo a la sucursal destino', 
	fecha_llegada TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha registrada de llegada del vehículo a la sucursal destino', 
	
	fecha_recogida TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha en la que el cliente recoge el vehículo en la sucursal destino', 
	
	fecha_entrega_pactada TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha máxima para que el cliente entregue el vehículo', 
	fecha_entrega TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha en la que el cliente engregó el vehículo', 
	dias_mora TINYINT UNSIGNED NULL DEFAULT NULL COMMENT 'Una vez se entregue el vehículo, se calcula si hubo retrasos', 
	
	INDEX alquileres_id_cliente(id_cliente), 
	INDEX alquileres_id_vehiculo(id_vehiculo), 
	
	CONSTRAINT fk_alquileres_cliente
		FOREIGN KEY (id_cliente)
		REFERENCES USUARIOS(id_usuario)
		ON UPDATE CASCADE, 
	
	CONSTRAINT fk_alquileres_trabajador
		FOREIGN KEY (id_empleado)
		REFERENCES USUARIOS(id_usuario)
		ON UPDATE CASCADE, 
		
	CONSTRAINT fk_alquileres_sucursal_alquiler
		FOREIGN KEY (id_sucursal_alquiler)
		REFERENCES SUCURSALES(id_sucursal)
		ON UPDATE CASCADE, 
	
	CONSTRAINT fk_alquileres_sucursal_entrega
		FOREIGN KEY (id_sucursal_entrega)
		REFERENCES SUCURSALES(id_sucursal)
		ON UPDATE CASCADE, 
	
	CONSTRAINT fk_alquileres_vehículo
		FOREIGN KEY (id_vehiculo)
		REFERENCES VEHICULOS(id_vehiculo)
		ON UPDATE CASCADE
	
)
CHARACTER SET 'utf8mb4' ; 

/* -- */ 
CREATE TABLE FACTURA(
	id_factura INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	id_alquiler INT UNSIGNED NOT NULL, 
	totaL_pagar DECIMAL(12,2) NOT NULL, 
	valor_pagado DECIMAL(12,2) NOT NULL DEFAULT 0, 
	was_paid TINYINT(1) NOT NULL DEFAULT 0, 
	
	CONSTRAINT fk_factura_alquiler
		FOREIGN KEY (id_alquiler)
		REFERENCES ALQUILERES(id_alquiler)
		ON UPDATE CASCADE
)
CHARACTER SET 'utf8mb4' ; 
	
/* 
##############################################
CREACIÓN DE LOS USUARIOS PARA LAS APLICACIONES
##############################################
*/

CREATE USER 'WebApp'@'%' IDENTIFIED WITH mysql_native_password BY 'WebAppPassword41*/'; 
GRANT EXECUTE ON `PROYECTO_AULA_BD`.* TO 'WebApp'@'%'; 

CREATE USER 'MobileApp'@'%' IDENTIFIED WITH mysql_native_password BY 'MobileAppPassword41*/'; 
GRANT EXECUTE ON `PROYECTO_AULA_BD`.* TO 'MobileApp'@'%'; 

SHOW SESSION VARIABLES LIKE 'character\_set\_%';
SHOW SESSION VARIABLES LIKE 'collation\_%';
SHOW TABLE STATUS;
