CREATE DATABASE laboratorio_3; 
USE laboratorio_3; 

CREATE TABLE TIPO_USUARIO(
	código_tipo_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	tipo_usuario VARCHAR(64) NOT NULL
)
COLLATE 'utf8mb4_general_ci'; 

CREATE TABLE SUCURSALES(
	id_sucursal INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	ciudad VARCHAR(255) NOT NULL, 
	dirección VARCHAR(255) NOT NULL UNIQUE, 
	teléfono_fijo VARCHAR(7) NOT NULL UNIQUE, 
	celular VARCHAR(10) NOT NULL UNIQUE, 
	correo_electrónico VARCHAR(255) NOT NULL UNIQUE, 
	
	INDEX sucursales_correo_electrónico(correo_electrónico)
)
COLLATE 'utf8mb4_general_ci'; 

CREATE TABLE USUARIOS(
	id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	nombres VARCHAR(255) NOT NULL, 
	apellidos VARCHAR(255) NOT NULL, 
	identificacion VARCHAR(14) NOT NULL UNIQUE COMMENT 'Cédula del cliente', 
	direccion VARCHAR(255) NOT NULL, 
	ciudad_residencia VARCHAR(255) NOT NULL, 
	celular VARCHAR(10) NOT NULL, 
	correo_electrónico VARCHAR(255) NOT NULL UNIQUE, 
	contraseña VARCHAR(255) NOT NULL, 
	código_tipo_usuario INT UNSIGNED NOT NULL, 
	código_sucursal INT UNSIGNED NULL DEFAULT NULL, 
	
	
	INDEX usuarios_id_usuario(id_usuario), 
	INDEX usuario_nombres(nombres), 
	INDEX usuario_apellidos(apellidos), 
	INDEX usuario_correo_electrónico(correo_electrónico),
	
	CONSTRAINT fk_usuario_tipo_usuario 
		FOREIGN KEY (código_tipo_usuario)
		REFERENCES `TIPO_USUARIO`(código_tipo_usuario)
		ON UPDATE CASCADE, 
	
	CONSTRAINT fk_usuario_sucursal
		FOREIGN KEY (código_sucursal)
		REFERENCES `SUCURSALES`(id_sucursal)
		ON UPDATE CASCADE
)
COLLATE 'utf8mb4_general_ci';

CREATE TABLE TIPO_VEHÍCULO(
	código_tipo_vehículo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	tipo_vehículo VARCHAR(64) NOT NULL
)
COLLATE 'utf8mb4_general_ci'; 

CREATE TABLE VEHÍCULOS(
	id_vehículo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	matrícula VARCHAR(6) NOT NULL UNIQUE, 	
	código_tipo_vehículo INT UNSIGNED NOT NULL, 
	modelo VARCHAR(64) NOT NULL, 
	numero_puertas TINYINT(2) UNSIGNED NOT NULL, 
	capacidad TINYINT(2) UNSIGNED NOT NULL, 
	has_sunfoof TINYINT(1) UNSIGNED NOT NULL, 
	motor VARCHAR(64) NOT NULL, 
	color VARCHAR(64) NOT NULL, 
	disponible TINYINT(1) UNSIGNED NOT NULL, 
	valor_alquiler_semanal DECIMAL(12,2) NOT NULL, 
	valor_alquiler_diario DECIMAL(12,2) NOT NULL,
	descuento DECIMAL(3,1) NOT NULL, 
	
	INDEX vehículos_matrícula(matrícula), 
	INDEX vehículos_modelo(modelo), 
	INDEX vehículos_disponible(disponible), 
	INDEX vehículos_tipo_vehículo(código_tipo_vehículo), 
	INDEX vehículos_descuento(descuento), 
	
	CONSTRAINT fk_vehículo_tipo_vehículo
		FOREIGN KEY (código_tipo_vehículo)
		REFERENCES TIPO_VEHÍCULO(código_tipo_vehículo)
		ON UPDATE CASCADE
	
)
COLLATE 'utf8mb4_general_ci'; 

CREATE TABLE ALQUILERES(
	id_alquiler INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	id_cliente INT UNSIGNED NOT NULL, 
	id_empleado INT UNSIGNED NOT NULL,
	id_vehículo INT UNSIGNED NOT NULL,  
	id_sucursal_alquiler INT UNSIGNED NOT NULL, 
	id_sucursal_entrega INT UNSIGNED NOT NULL, 
	dias TINYINT UNSIGNED NOT NULL, 
	valor_cotizado DECIMAL(12,2) NOT NULL, 
	valor_pagado DECIMAL(12,2) NULL DEFAULT NULL,
	
	fecha_salida TIMESTAMP NOT NULL, 
	
	fecha_esperada_llegada TIMESTAMP NOT NULL COMMENT 'Fecha esperada de llegada del vehículo a la sucursal destino', 
	fecha_llegada TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha registrada de llegada del vehículo a la sucursal destino', 
	
	fecha_recogida TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha en la que el cliente recoge el vehículo en la sucursal destino', 
	
	fecha_entrega_pactada TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha máxima para que el cliente entregue el vehículo', 
	fecha_entrega TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha en la que el cliente engregó el vehículo', 
	dias_mora TINYINT UNSIGNED NULL DEFAULT NULL COMMENT 'Una vez se entregue el vehículo, se calcula si hubo retrasos', 
	
	INDEX alquileres_id_cliente(id_cliente), 
	INDEX alquileres_id_vehículo(id_vehículo), 
	
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
		FOREIGN KEY (id_vehículo)
		REFERENCES VEHÍCULOS(id_vehículo)
		ON UPDATE CASCADE
	
)
COLLATE 'utf8mb4_general_ci'; 

 
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
COLLATE 'utf8mb4_general_ci'; 

/* ############## */
/* INSERTAR DATOS EN LAS TABLAS */
/* ############## */


INSERT INTO TIPO_USUARIO(tipo_usuario) VALUES
	('Administrador'), 
	('Trabajador'), 
	('Cliente'); 
	
INSERT INTO SUCURSALES(ciudad, dirección, teléfono_fijo, celular, correo_electrónico) VALUES
	('Bucaramanga', 'Cra 4 #6-75 San Cristóbal', '6550000', '3170000000', 'sucursalbga@gmail.com'),
	('Medellín', 'Cra 4 #6-75 San Joaquín', '6550001', '3170000001', 'sucursalmedellin@gmail.com'),
	('Bogotá', 'Cra 4 #6-75 Chapinero', '6550002', '3170000002', 'sucursalbgta@gmail.com'), 
	('Cali', 'Cra 4 #6-75 El peñón', '6550003', '3170000003', 'sucursalcali@gmail.com'),
	('Barranquilla', 'Cra 4 #6-75 Bella Vista', '6550004', '3170000004', 'sucursalbarranquilla@gmail.com'); 

INSERT INTO TIPO_VEHÍCULO(tipo_vehículo) VALUES
	('Sedán'),
	('Compacto'), 
	('Camioneta platón'),
	('Camioneta de lujo'),
	('Deportivo'),    
	('Coupé'); 

INSERT INTO VEHÍCULOS(matrícula, código_tipo_vehículo, modelo, numero_puertas, capacidad, has_sunfoof, motor, color, disponible, valor_alquiler_semanal, valor_alquiler_diario, descuento) VALUES 
('AB1256',1,'XR-428',4,5,1,'V8-730','Rojo',0,420000,120000, 0),
('AB1257',2,'XR-429',2,2,0,'V8-731','Azul',0,340000,90000, 0),
('AB1258',3,'XR-430',4,4,0,'V8-732','Negro',1,540000,220000, 0),
('AB1259',4,'XR-431',2,5,1,'V8-733','Blanco',0,310000,85000, 0),
('AB1260',5,'XR-432',4,2,0,'V8-734','Plateado',1,280000,65000, 0),
('AB1261',6,'XR-433',2,4,0,'V8-735','Rojo',1,420000,120000, 0),
('AB1262',1,'XR-434',4,5,0,'V8-736','Azul',1,340000,90000, 0),
('AB1263',2,'XR-435',2,2,1,'V8-737','Negro',1,540000,220000, 0),
('AB1264',3,'XR-436',4,4,1,'V8-738','Blanco',1,310000,85000, 0),
('AB1265',4,'XR-437',2,5,0,'V8-739','Plateado',1,280000,65000, 0),
('AB1266',5,'XR-438',4,2,0,'V8-740','Rojo',1,420000,120000, 0),
('AB1267',6,'XR-439',2,4,1,'V8-741','Azul',0,340000,90000, 0),
('AB1268',1,'XR-440',4,5,0,'V8-742','Negro',0,540000,220000, 0),
('AB1269',2,'XR-441',2,2,0,'V8-743','Blanco',1,310000,85000, 0),
('AB1270',3,'XR-442',4,4,0,'V8-744','Plateado',0,280000,65000, 0),
('AB1271',4,'XR-443',2,5,1,'V8-745','Rojo',1,420000,120000, 0),
('AB1272',5,'XR-444',4,2,1,'V8-746','Azul',1,340000,90000, 0),
('AB1273',6,'XR-445',2,4,0,'V8-747','Negro',1,540000,220000, 0),
('AB1274',1,'XR-446',4,5,0,'V8-748','Blanco',1,310000,85000, 0),
('AB1275',2,'XR-447',2,2,1,'V8-749','Plateado',1,280000,65000, 0),
('AB1276',3,'XR-448',4,4,0,'V8-750','Rojo',1,375000,120000, 0),
('AB1277',4,'XR-449',2,5,0,'V8-751','Azul',1,420000,90000, 0),
('AB1278',5,'XR-450',4,2,0,'V8-752','Negro',0,340000,220000, 0),
('AB1279',6,'XR-451',2,4,1,'V8-753','Blanco',0,540000,85000, 0); 
