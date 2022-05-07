-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: PROYECTO_AULA_BD
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alquileres`
--

DROP TABLE IF EXISTS `alquileres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alquileres` (
  `id_alquiler` int unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` int unsigned NOT NULL,
  `id_empleado` int unsigned NOT NULL,
  `id_vehiculo` int unsigned NOT NULL,
  `id_sucursal_alquiler` int unsigned NOT NULL,
  `id_sucursal_entrega` int unsigned NOT NULL,
  `dias` tinyint unsigned NOT NULL,
  `valor_diario_cotizado` decimal(12,2) NOT NULL COMMENT 'Columna para congelar el valor diario al que el cliente alquiló el vehículo',
  `valor_semanal_cotizado` decimal(12,2) NOT NULL COMMENT 'Column para congelar el valor semanal al que el cliente alquiló el vehículo',
  `valor_cotizado` decimal(12,2) NOT NULL COMMENT 'Columna para congelar el valor total que el cliente cotizó por el vehículo',
  `valor_pagado` decimal(12,2) DEFAULT NULL,
  `fecha_salida` timestamp NOT NULL,
  `fecha_esperada_llegada` timestamp NOT NULL COMMENT 'Fecha esperada de llegada del vehículo a la sucursal destino',
  `fecha_llegada` timestamp NULL DEFAULT NULL COMMENT 'Fecha registrada de llegada del vehículo a la sucursal destino',
  `fecha_recogida` timestamp NULL DEFAULT NULL COMMENT 'Fecha en la que el cliente recoge el vehículo en la sucursal destino',
  `fecha_entrega_pactada` timestamp NULL DEFAULT NULL COMMENT 'Fecha máxima para que el cliente entregue el vehículo',
  `fecha_entrega` timestamp NULL DEFAULT NULL COMMENT 'Fecha en la que el cliente engregó el vehículo',
  `dias_mora` tinyint unsigned DEFAULT NULL COMMENT 'Una vez se entregue el vehículo, se calcula si hubo retrasos',
  PRIMARY KEY (`id_alquiler`),
  KEY `alquileres_id_cliente` (`id_cliente`),
  KEY `alquileres_id_vehiculo` (`id_vehiculo`),
  KEY `fk_alquileres_trabajador` (`id_empleado`),
  KEY `fk_alquileres_sucursal_alquiler` (`id_sucursal_alquiler`),
  KEY `fk_alquileres_sucursal_entrega` (`id_sucursal_entrega`),
  CONSTRAINT `fk_alquileres_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE,
  CONSTRAINT `fk_alquileres_sucursal_alquiler` FOREIGN KEY (`id_sucursal_alquiler`) REFERENCES `sucursales` (`id_sucursal`) ON UPDATE CASCADE,
  CONSTRAINT `fk_alquileres_sucursal_entrega` FOREIGN KEY (`id_sucursal_entrega`) REFERENCES `sucursales` (`id_sucursal`) ON UPDATE CASCADE,
  CONSTRAINT `fk_alquileres_trabajador` FOREIGN KEY (`id_empleado`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE,
  CONSTRAINT `fk_alquileres_vehículo` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehículos` (`id_vehiculo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alquileres`
--

LOCK TABLES `alquileres` WRITE;
/*!40000 ALTER TABLE `alquileres` DISABLE KEYS */;
/*!40000 ALTER TABLE `alquileres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `bills_pretty`
--

DROP TABLE IF EXISTS `bills_pretty`;
/*!50001 DROP VIEW IF EXISTS `bills_pretty`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bills_pretty` AS SELECT 
 1 AS `id_factura`,
 1 AS `Nombre cliente`,
 1 AS `dias_mora`,
 1 AS `totaL_pagar`,
 1 AS `valor_pagado`,
 1 AS `was_paid`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ciudades`
--

DROP TABLE IF EXISTS `ciudades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudades` (
  `id_ciudad` int unsigned NOT NULL AUTO_INCREMENT,
  `id_departamento` int unsigned NOT NULL,
  `ciudad` varchar(255) NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  KEY `fk_ciudad_departamento` (`id_departamento`),
  CONSTRAINT `fk_ciudad_departamento` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudades`
--

LOCK TABLES `ciudades` WRITE;
/*!40000 ALTER TABLE `ciudades` DISABLE KEYS */;
INSERT INTO `ciudades` VALUES (1,30,'Providencia'),(2,30,'San Andrés'),(3,8,'Baranoa'),(4,8,'Barranquilla'),(5,8,'Campo de La Cruz'),(6,8,'Candelaria'),(7,8,'Galapa'),(8,8,'Juan de Acosta'),(9,8,'Luruaco'),(10,8,'Malambo'),(11,8,'Manatí'),(12,8,'Palmar de Varela'),(13,8,'Piojó'),(14,8,'Polonuevo'),(15,8,'Ponedera'),(16,8,'Puerto Colombia'),(17,8,'Repelón'),(18,8,'Sabanagrande'),(19,8,'Sabanalarga'),(20,8,'Santa Lucía'),(21,8,'Santo Tomás'),(22,8,'Soledad'),(23,8,'Suan'),(24,8,'Tubará'),(25,8,'Usiacurí'),(26,9,'Achí'),(27,9,'Altos del Rosario'),(28,9,'Arenal'),(29,9,'Arjona'),(30,9,'Arroyohondo'),(31,9,'Barranco de Loba'),(32,9,'Calamar'),(33,9,'Cantagallo'),(34,9,'Cartagena'),(35,9,'Cicuco'),(36,9,'Clemencia'),(37,9,'Córdoba'),(38,9,'El Carmen de Bolívar'),(39,9,'El Guamo'),(40,9,'El Peñón'),(41,9,'Hatillo de Loba'),(42,9,'Magangué'),(43,9,'Mahates'),(44,9,'Margarita'),(45,9,'María la Baja'),(46,9,'Mompós'),(47,9,'Montecristo'),(48,9,'Morales'),(49,9,'Norosí'),(50,9,'Pinillos'),(51,9,'Regidor'),(52,9,'Río Viejo'),(53,9,'San Cristóbal'),(54,9,'San Estanislao'),(55,9,'San Fernando'),(56,9,'San Jacinto'),(57,9,'San Jacinto del Cauca'),(58,9,'San Juan Nepomuceno'),(59,9,'San Martín de Loba'),(60,9,'San Pablo de Borbur'),(61,9,'Santa Catalina'),(62,9,'Santa Rosa'),(63,9,'Santa Rosa del Sur'),(64,9,'Simití'),(65,9,'Soplaviento'),(66,9,'Talaigua Nuevo'),(67,9,'Tiquisio'),(68,9,'Turbaco'),(69,9,'Turbaná'),(70,9,'Villanueva'),(71,9,'Zambrano'),(72,13,'Aguachica'),(73,13,'Agustín Codazzi'),(74,13,'Astrea'),(75,13,'Becerril'),(76,13,'Bosconia'),(77,13,'Chimichagua'),(78,13,'Chiriguaná'),(79,13,'Curumaní'),(80,13,'El Copey'),(81,13,'El Paso'),(82,13,'Gamarra'),(83,13,'González'),(84,13,'La Gloria'),(85,13,'La Jagua de Ibirico'),(86,13,'La Paz'),(87,13,'Manaure'),(88,13,'Pailitas'),(89,13,'Pelaya'),(90,13,'Pueblo Bello'),(91,13,'Río de Oro'),(92,13,'San Alberto'),(93,13,'San Diego'),(94,13,'San Martín'),(95,13,'Tamalameque'),(96,13,'Valledupar'),(97,3,'Ayapel'),(98,3,'Buenavista'),(99,3,'Canalete'),(100,3,'Cereté'),(101,3,'Chimá'),(102,3,'Chinú'),(103,3,'Ciénaga de Oro'),(104,3,'Cotorra'),(105,3,'La Apartada'),(106,3,'Lorica'),(107,3,'Los Córdobas'),(108,3,'Momil'),(109,3,'Montelíbano'),(110,3,'Montería'),(111,3,'Moñitos'),(112,3,'Planeta Rica'),(113,3,'Pueblo Nuevo'),(114,3,'Puerto Escondido'),(115,3,'Puerto Libertador'),(116,3,'Purísima'),(117,3,'Sahagún'),(118,3,'San Andrés Sotavento'),(119,3,'San Antero'),(120,3,'San Bernardo del Viento'),(121,3,'San Carlos'),(122,3,'San José de Uré'),(123,3,'San Pelayo'),(124,3,'Tierralta'),(125,3,'Tuchín'),(126,3,'Valencia'),(127,16,'Albania'),(128,16,'Barrancas'),(129,16,'Dibula'),(130,16,'Distracción'),(131,16,'El Molino'),(132,16,'Fonseca'),(133,16,'Hatonuevo'),(134,16,'La Jagua del Pilar'),(135,16,'Maicao'),(136,16,'Manaure'),(137,16,'Riohacha'),(138,16,'San Juan del Cesar'),(139,16,'Uribia'),(140,16,'Urumita'),(141,16,'Villanueva'),(142,17,'Algarrobo'),(143,17,'Aracataca'),(144,17,'Ariguaní'),(145,17,'Cerro San Antonio'),(146,17,'Chivolo'),(147,17,'Ciénaga'),(148,17,'Concordia'),(149,17,'El Banco'),(150,17,'El Piñon'),(151,17,'El Retén'),(152,17,'Fundación'),(153,17,'Guamal'),(154,17,'Nueva Granada'),(155,17,'Pedraza'),(156,17,'Pijiño del Carmen'),(157,17,'Pivijay'),(158,17,'Plato'),(159,17,'Pueblo Viejo'),(160,17,'Remolino'),(161,17,'Sabanas de San Angel'),(162,17,'Salamina'),(163,17,'San Sebastián de Buenavista'),(164,17,'San Zenón'),(165,17,'Santa Ana'),(166,17,'Santa Bárbara de Pinto'),(167,17,'Santa Marta'),(168,17,'Sitionuevo'),(169,17,'Tenerife'),(170,17,'Zapayán'),(171,17,'Zona Bananera'),(172,20,'Buenavista'),(173,20,'Caimito'),(174,20,'Chalán'),(175,20,'Coloso'),(176,20,'Corozal'),(177,20,'Coveñas'),(178,20,'El Roble'),(179,20,'Galeras'),(180,20,'Guaranda'),(181,20,'La Unión'),(182,20,'Los Palmitos'),(183,20,'Majagual'),(184,20,'Morroa'),(185,20,'Ovejas'),(186,20,'Palmito'),(187,20,'Sampués'),(188,20,'San Benito Abad'),(189,20,'San Juan de Betulia'),(190,20,'San Luis de Sincé'),(191,20,'San Marcos'),(192,20,'San Onofre'),(193,20,'San Pedro'),(194,20,'Santiago de Tolú'),(195,20,'Sincelejo'),(196,20,'Sucre'),(197,20,'Tolú Viejo'),(198,31,'Bogotá D.C.'),(199,2,'Almeida'),(200,2,'Aquitania'),(201,2,'Arcabuco'),(202,2,'Belén'),(203,2,'Berbeo'),(204,2,'Betéitiva'),(205,2,'Boavita'),(206,2,'Boyacá'),(207,2,'Briceño'),(208,2,'Buena Vista'),(209,2,'Busbanzá'),(210,2,'Caldas'),(211,2,'Campohermoso'),(212,2,'Cerinza'),(213,2,'Chinavita'),(214,2,'Chiquinquirá'),(215,2,'Chíquiza'),(216,2,'Chiscas'),(217,2,'Chita'),(218,2,'Chitaraque'),(219,2,'Chivatá'),(220,2,'Chivor'),(221,2,'Ciénega'),(222,2,'Cómbita'),(223,2,'Coper'),(224,2,'Corrales'),(225,2,'Covarachía'),(226,2,'Cubará'),(227,2,'Cucaita'),(228,2,'Cuítiva'),(229,2,'Duitama'),(230,2,'El Cocuy'),(231,2,'El Espino'),(232,2,'Firavitoba'),(233,2,'Floresta'),(234,2,'Gachantivá'),(235,2,'Gameza'),(236,2,'Garagoa'),(237,2,'Guacamayas'),(238,2,'Guateque'),(239,2,'Guayatá'),(240,2,'Güicán'),(241,2,'Iza'),(242,2,'Jenesano'),(243,2,'Jericó'),(244,2,'La Capilla'),(245,2,'La Uvita'),(246,2,'La Victoria'),(247,2,'Labranzagrande'),(248,2,'Macanal'),(249,2,'Maripí'),(250,2,'Miraflores'),(251,2,'Mongua'),(252,2,'Monguí'),(253,2,'Moniquirá'),(254,2,'Motavita'),(255,2,'Muzo'),(256,2,'Nobsa'),(257,2,'Nuevo Colón'),(258,2,'Oicatá'),(259,2,'Otanche'),(260,2,'Pachavita'),(261,2,'Páez'),(262,2,'Paipa'),(263,2,'Pajarito'),(264,2,'Panqueba'),(265,2,'Pauna'),(266,2,'Paya'),(267,2,'Paz de Río'),(268,2,'Pesca'),(269,2,'Pisba'),(270,2,'Puerto Boyacá'),(271,2,'Quípama'),(272,2,'Ramiriquí'),(273,2,'Ráquira'),(274,2,'Rondón'),(275,2,'Saboyá'),(276,2,'Sáchica'),(277,2,'Samacá'),(278,2,'San Eduardo'),(279,2,'San José de Pare'),(280,2,'San Luis de Gaceno'),(281,2,'San Mateo'),(282,2,'San Miguel de Sema'),(283,2,'San Pablo de Borbur'),(284,2,'Socha'),(285,2,'Santa María'),(286,2,'Santa Rosa de Viterbo'),(287,2,'Santa Sofía'),(288,2,'Santana'),(289,2,'Sativanorte'),(290,2,'Sativasur'),(291,2,'Siachoque'),(292,2,'Soatá'),(293,2,'Socotá'),(294,2,'Sogamoso'),(295,2,'Somondoco'),(296,2,'Sora'),(297,2,'Soracá'),(298,2,'Sotaquirá'),(299,2,'Susacón'),(300,2,'Sutamarchán'),(301,2,'Sutatenza'),(302,2,'Tasco'),(303,2,'Tenza'),(304,2,'Tibaná'),(305,2,'Tibasosa'),(306,2,'Tinjacá'),(307,2,'Tipacoque'),(308,2,'Toca'),(309,2,'Togüí'),(310,2,'Tópaga'),(311,2,'Tota'),(312,2,'Tunja'),(313,2,'Tununguá'),(314,2,'Turmequé'),(315,2,'Tuta'),(316,2,'Tutazá'),(317,2,'Umbita'),(318,2,'Ventaquemada'),(319,2,'Villa de Leyva'),(320,2,'Viracachá'),(321,2,'Zetaquira'),(322,14,'Agua de Dios'),(323,14,'Albán'),(324,14,'Anapoima'),(325,14,'Anolaima'),(326,14,'Apulo'),(327,14,'Arbeláez'),(328,14,'Beltrán'),(329,14,'Bituima'),(330,14,'Bojacá'),(331,14,'Cabrera'),(332,14,'Cachipay'),(333,14,'Cajicá'),(334,14,'Caparrapí'),(335,14,'Caqueza'),(336,14,'Carmen de Carupa'),(337,14,'Chaguaní'),(338,14,'Chía'),(339,14,'Chipaque'),(340,14,'Choachí'),(341,14,'Chocontá'),(342,14,'Cogua'),(343,14,'Cota'),(344,14,'Cucunubá'),(345,14,'El Colegio'),(346,14,'El Peñón'),(347,14,'El Rosal'),(348,14,'Facatativá'),(349,14,'Fomeque'),(350,14,'Fosca'),(351,14,'Funza'),(352,14,'Fúquene'),(353,14,'Fusagasugá'),(354,14,'Gachala'),(355,14,'Gachancipá'),(356,14,'Gachetá'),(357,14,'Gama'),(358,14,'Girardot'),(359,14,'Granada'),(360,14,'Guachetá'),(361,14,'Guaduas'),(362,14,'Guasca'),(363,14,'Guataquí'),(364,14,'Guatavita'),(365,14,'Guayabal de Siquima'),(366,14,'Guayabetal'),(367,14,'Gutiérrez'),(368,14,'Jerusalén'),(369,14,'Junín'),(370,14,'La Calera'),(371,14,'La Mesa'),(372,14,'La Palma'),(373,14,'La Peña'),(374,14,'La Vega'),(375,14,'Lenguazaque'),(376,14,'Macheta'),(377,14,'Madrid'),(378,14,'Manta'),(379,14,'Medina'),(380,14,'Mosquera'),(381,14,'Nariño'),(382,14,'Nemocón'),(383,14,'Nilo'),(384,14,'Nimaima'),(385,14,'Nocaima'),(386,14,'Pacho'),(387,14,'Paime'),(388,14,'Pandi'),(389,14,'Paratebueno'),(390,14,'Pasca'),(391,14,'Puerto Salgar'),(392,14,'Pulí'),(393,14,'Quebradanegra'),(394,14,'Quetame'),(395,14,'Quipile'),(396,14,'Ricaurte'),(397,14,'San Antonio del Tequendama'),(398,14,'San Bernardo'),(399,14,'San Cayetano'),(400,14,'San Francisco'),(401,14,'San Juan de Río Seco'),(402,14,'Sasaima'),(403,14,'Sesquilé'),(404,14,'Sibaté'),(405,14,'Silvania'),(406,14,'Simijaca'),(407,14,'Soacha'),(408,14,'Sopó'),(409,14,'Subachoque'),(410,14,'Suesca'),(411,14,'Supatá'),(412,14,'Susa'),(413,14,'Sutatausa'),(414,14,'Tabio'),(415,14,'Tausa'),(416,14,'Tena'),(417,14,'Tenjo'),(418,14,'Tibacuy'),(419,14,'Tibirita'),(420,14,'Tocaima'),(421,14,'Tocancipá'),(422,14,'Topaipí'),(423,14,'Ubalá'),(424,14,'Ubaque'),(425,14,'Une'),(426,14,'Útica'),(427,14,'Venecia'),(428,14,'Vergara'),(429,14,'Vianí'),(430,14,'Villa de San Diego de Ubate'),(431,14,'Villagómez'),(432,14,'Villapinzón'),(433,14,'Villeta'),(434,14,'Viotá'),(435,14,'Yacopí'),(436,14,'Zipacón'),(437,14,'Zipaquirá'),(438,32,'Abrego'),(439,32,'Arboledas'),(440,32,'Bochalema'),(441,32,'Bucarasica'),(442,32,'Cachirá'),(443,32,'Cácota'),(444,32,'Chinácota'),(445,32,'Chitagá'),(446,32,'Convención'),(447,32,'Cúcuta'),(448,32,'Cucutilla'),(449,32,'Durania'),(450,32,'El Carmen'),(451,32,'El Tarra'),(452,32,'El Zulia'),(453,32,'Gramalote'),(454,32,'Hacarí'),(455,32,'Herrán'),(456,32,'La Esperanza'),(457,32,'La Playa'),(458,32,'Labateca'),(459,32,'Los Patios'),(460,32,'Lourdes'),(461,32,'Mutiscua'),(462,32,'Ocaña'),(463,32,'Pamplona'),(464,32,'Pamplonita'),(465,32,'Puerto Santander'),(466,32,'Ragonvalia'),(467,32,'Salazar'),(468,32,'San Calixto'),(469,32,'San Cayetano'),(470,32,'Santiago'),(471,32,'Sardinata'),(472,32,'Silos'),(473,32,'Teorama'),(474,32,'Tibú'),(475,32,'Toledo'),(476,32,'Villa Caro'),(477,32,'Villa del Rosario'),(478,6,'Aguada'),(479,6,'Albania'),(480,6,'Aratoca'),(481,6,'Barbosa'),(482,6,'Barichara'),(483,6,'Barrancabermeja'),(484,6,'Betulia'),(485,6,'Bolívar'),(486,6,'Bucaramanga'),(487,6,'Cabrera'),(488,6,'California'),(489,6,'Capitanejo'),(490,6,'Carcasí'),(491,6,'Cepitá'),(492,6,'Cerrito'),(493,6,'Charalá'),(494,6,'Charta'),(495,6,'Chimá'),(496,6,'Chipatá'),(497,6,'Cimitarra'),(498,6,'Concepción'),(499,6,'Confines'),(500,6,'Contratación'),(501,6,'Coromoro'),(502,6,'Curití'),(503,6,'El Carmen de Chucurí'),(504,6,'El Guacamayo'),(505,6,'El Peñón'),(506,6,'El Playón'),(507,6,'Encino'),(508,6,'Enciso'),(509,6,'Florián'),(510,6,'Floridablanca'),(511,6,'Galán'),(512,6,'Gambita'),(513,6,'Girón'),(514,6,'Guaca'),(515,6,'Guadalupe'),(516,6,'Guapotá'),(517,6,'Guavatá'),(518,6,'Güepsa'),(519,6,'Hato'),(520,6,'Jesús María'),(521,6,'Jordán'),(522,6,'La Belleza'),(523,6,'La Paz'),(524,6,'Landázuri'),(525,6,'Lebríja'),(526,6,'Los Santos'),(527,6,'Macaravita'),(528,6,'Málaga'),(529,6,'Matanza'),(530,6,'Mogotes'),(531,6,'Molagavita'),(532,6,'Ocamonte'),(533,6,'Oiba'),(534,6,'Onzaga'),(535,6,'Palmar'),(536,6,'Palmas del Socorro'),(537,6,'Páramo'),(538,6,'Piedecuesta'),(539,6,'Pinchote'),(540,6,'Puente Nacional'),(541,6,'Puerto Parra'),(542,6,'Puerto Wilches'),(543,6,'Rionegro'),(544,6,'Sabana de Torres'),(545,6,'San Andrés'),(546,6,'San Benito'),(547,6,'San Gil'),(548,6,'San Joaquín'),(549,6,'San José de Miranda'),(550,6,'San Miguel'),(551,6,'San Vicente de Chucurí'),(552,6,'Santa Bárbara'),(553,6,'Santa Helena del Opón'),(554,6,'Simacota'),(555,6,'Socorro'),(556,6,'Suaita'),(557,6,'Sucre'),(558,6,'Suratá'),(559,6,'Tona'),(560,6,'Valle de San José'),(561,6,'Vélez'),(562,6,'Vetas'),(563,6,'Villanueva'),(564,6,'Zapatoca'),(565,25,'El Encanto'),(566,25,'La Chorrera'),(567,25,'La Pedrera'),(568,25,'La Victoria'),(569,25,'Leticia'),(570,25,'Miriti Paraná'),(571,25,'Puerto Alegría'),(572,25,'Puerto Arica'),(573,25,'Puerto Nariño'),(574,25,'Puerto Santander'),(575,25,'Tarapacá'),(576,11,'Albania'),(577,11,'Belén de Los Andaquies'),(578,11,'Cartagena del Chairá'),(579,11,'Curillo'),(580,11,'El Doncello'),(581,11,'El Paujil'),(582,11,'Florencia'),(583,11,'La Montañita'),(584,11,'Milán'),(585,11,'Morelia'),(586,11,'Puerto Rico'),(587,11,'San José del Fragua'),(588,11,'San Vicente del Caguán'),(589,11,'Solano'),(590,11,'Solita'),(591,11,'Valparaíso'),(592,15,'Acevedo'),(593,15,'Agrado'),(594,15,'Aipe'),(595,15,'Algeciras'),(596,15,'Altamira'),(597,15,'Baraya'),(598,15,'Campoalegre'),(599,15,'Colombia'),(600,15,'Elías'),(601,15,'Garzón'),(602,15,'Gigante'),(603,15,'Guadalupe'),(604,15,'Hobo'),(605,15,'Iquira'),(606,15,'Isnos'),(607,15,'La Argentina'),(608,15,'La Plata'),(609,15,'Nátaga'),(610,15,'Neiva'),(611,15,'Oporapa'),(612,15,'Paicol'),(613,15,'Palermo'),(614,15,'Palestina'),(615,15,'Pital'),(616,15,'Pitalito'),(617,15,'Rivera'),(618,15,'Saladoblanco'),(619,15,'San Agustín'),(620,15,'Santa María'),(621,15,'Suaza'),(622,15,'Tarqui'),(623,15,'Tello'),(624,15,'Teruel'),(625,15,'Tesalia'),(626,15,'Timaná'),(627,15,'Villavieja'),(628,15,'Yaguará'),(629,24,'Colón'),(630,24,'Leguízamo'),(631,24,'Mocoa'),(632,24,'Orito'),(633,24,'Puerto Asís'),(634,24,'Puerto Caicedo'),(635,24,'Puerto Guzmán'),(636,24,'San Francisco'),(637,24,'San Miguel'),(638,24,'Santiago'),(639,24,'Sibundoy'),(640,24,'Valle de Guamez'),(641,24,'Villagarzón'),(642,21,'Alpujarra'),(643,21,'Alvarado'),(644,21,'Ambalema'),(645,21,'Anzoátegui'),(646,21,'Armero'),(647,21,'Ataco'),(648,21,'Cajamarca'),(649,21,'Carmen de Apicala'),(650,21,'Casabianca'),(651,21,'Chaparral'),(652,21,'Coello'),(653,21,'Coyaima'),(654,21,'Cunday'),(655,21,'Dolores'),(656,21,'Espinal'),(657,21,'Falan'),(658,21,'Flandes'),(659,21,'Fresno'),(660,21,'Guamo'),(661,21,'Herveo'),(662,21,'Honda'),(663,21,'Ibagué'),(664,21,'Icononzo'),(665,21,'Lérida'),(666,21,'Líbano'),(667,21,'Mariquita'),(668,21,'Melgar'),(669,21,'Murillo'),(670,21,'Natagaima'),(671,21,'Ortega'),(672,21,'Palocabildo'),(673,21,'Piedras'),(674,21,'Planadas'),(675,21,'Prado'),(676,21,'Purificación'),(677,21,'Rio Blanco'),(678,21,'Roncesvalles'),(679,21,'Rovira'),(680,21,'Saldaña'),(681,21,'San Antonio'),(682,21,'San Luis'),(683,21,'Santa Isabel'),(684,21,'Suárez'),(685,21,'Valle de San Juan'),(686,21,'Venadillo'),(687,21,'Villahermosa'),(688,21,'Villarrica'),(689,1,'Abejorral'),(690,1,'Abriaquí'),(691,1,'Alejandría'),(692,1,'Amagá'),(693,1,'Amalfi'),(694,1,'Andes'),(695,1,'Angelópolis'),(696,1,'Angostura'),(697,1,'Anorí'),(698,1,'Anza'),(699,1,'Apartadó'),(700,1,'Arboletes'),(701,1,'Argelia'),(702,1,'Armenia'),(703,1,'Barbosa'),(704,1,'Bello'),(705,1,'Belmira'),(706,1,'Betania'),(707,1,'Betulia'),(708,1,'Briceño'),(709,1,'Buriticá'),(710,1,'Cáceres'),(711,1,'Caicedo'),(712,1,'Caldas'),(713,1,'Campamento'),(714,1,'Cañasgordas'),(715,1,'Caracolí'),(716,1,'Caramanta'),(717,1,'Carepa'),(718,1,'Carolina'),(719,1,'Caucasia'),(720,1,'Chigorodó'),(721,1,'Cisneros'),(722,1,'Ciudad Bolívar'),(723,1,'Cocorná'),(724,1,'Concepción'),(725,1,'Concordia'),(726,1,'Copacabana'),(727,1,'Dabeiba'),(728,1,'Don Matías'),(729,1,'Ebéjico'),(730,1,'El Bagre'),(731,1,'El Carmen de Viboral'),(732,1,'El Santuario'),(733,1,'Entrerrios'),(734,1,'Envigado'),(735,1,'Fredonia'),(736,1,'Frontino'),(737,1,'Giraldo'),(738,1,'Girardota'),(739,1,'Gómez Plata'),(740,1,'Granada'),(741,1,'Guadalupe'),(742,1,'Guarne'),(743,1,'Guatapé'),(744,1,'Heliconia'),(745,1,'Hispania'),(746,1,'Itagui'),(747,1,'Ituango'),(748,1,'Jardín'),(749,1,'Jericó'),(750,1,'La Ceja'),(751,1,'La Estrella'),(752,1,'La Pintada'),(753,1,'La Unión'),(754,1,'Liborina'),(755,1,'Maceo'),(756,1,'Marinilla'),(757,1,'Medellín'),(758,1,'Montebello'),(759,1,'Murindó'),(760,1,'Mutatá'),(761,1,'Nariño'),(762,1,'Nechí'),(763,1,'Necoclí'),(764,1,'Olaya'),(765,1,'Peñol'),(766,1,'Peque'),(767,1,'Pueblorrico'),(768,1,'Puerto Berrío'),(769,1,'Puerto Nare'),(770,1,'Puerto Triunfo'),(771,1,'Remedios'),(772,1,'Retiro'),(773,1,'Rionegro'),(774,1,'Sabanalarga'),(775,1,'Sabaneta'),(776,1,'Salgar'),(777,1,'San Andrés de Cuerquía'),(778,1,'San Carlos'),(779,1,'San Francisco'),(780,1,'San Jerónimo'),(781,1,'San José de La Montaña'),(782,1,'San Juan de Urabá'),(783,1,'San Luis'),(784,1,'San Pedro'),(785,1,'San Pedro de Uraba'),(786,1,'San Rafael'),(787,1,'San Roque'),(788,1,'San Vicente'),(789,1,'Santa Bárbara'),(790,1,'Santa Rosa de Osos'),(791,1,'Santafé de Antioquia'),(792,1,'Santo Domingo'),(793,1,'Segovia'),(794,1,'Sonsón'),(795,1,'Sopetrán'),(796,1,'Támesis'),(797,1,'Tarazá'),(798,1,'Tarso'),(799,1,'Titiribí'),(800,1,'Toledo'),(801,1,'Turbo'),(802,1,'Uramita'),(803,1,'Urrao'),(804,1,'Valdivia'),(805,1,'Valparaíso'),(806,1,'Vegachí'),(807,1,'Venecia'),(808,1,'Vigía del Fuerte'),(809,1,'Yalí'),(810,1,'Yarumal'),(811,1,'Yolombó'),(812,1,'Yondó'),(813,1,'Zaragoza'),(814,10,'Aguadas'),(815,10,'Anserma'),(816,10,'Aranzazu'),(817,10,'Belalcázar'),(818,10,'Chinchiná'),(819,10,'Filadelfia'),(820,10,'La Dorada'),(821,10,'La Merced'),(822,10,'Manizales'),(823,10,'Manzanares'),(824,10,'Marmato'),(825,10,'Marquetalia'),(826,10,'Marulanda'),(827,10,'Neira'),(828,10,'Norcasia'),(829,10,'Pácora'),(830,10,'Palestina'),(831,10,'Pensilvania'),(832,10,'Riosucio'),(833,10,'Risaralda'),(834,10,'Salamina'),(835,10,'Samaná'),(836,10,'San José'),(837,10,'Supía'),(838,10,'Victoria'),(839,10,'Villamaría'),(840,10,'Viterbo'),(841,18,'Armenia'),(842,18,'Buenavista'),(843,18,'Calarcá'),(844,18,'Circasia'),(845,18,'Córdoba'),(846,18,'Filandia'),(847,18,'Génova'),(848,18,'La Tebaida'),(849,18,'Montenegro'),(850,18,'Pijao'),(851,18,'Quimbaya'),(852,18,'Salento'),(853,19,'Apía'),(854,19,'Balboa'),(855,19,'Belén de Umbría'),(856,19,'Dosquebradas'),(857,19,'Guática'),(858,19,'La Celia'),(859,19,'La Virginia'),(860,19,'Marsella'),(861,19,'Mistrató'),(862,19,'Pereira'),(863,19,'Pueblo Rico'),(864,19,'Quinchía'),(865,19,'Santa Rosa de Cabal'),(866,19,'Santuario'),(867,22,'Arauca'),(868,22,'Arauquita'),(869,22,'Cravo Norte'),(870,22,'Fortul'),(871,22,'Puerto Rondón'),(872,22,'Saravena'),(873,22,'Tame'),(874,23,'Aguazul'),(875,23,'Chámeza'),(876,23,'Hato Corozal'),(877,23,'La Salina'),(878,23,'Maní'),(879,23,'Monterrey'),(880,23,'Nunchía'),(881,23,'Orocué'),(882,23,'Paz de Ariporo'),(883,23,'Pore'),(884,23,'Recetor'),(885,23,'Sabanalarga'),(886,23,'Sácama'),(887,23,'San Luis de Gaceno'),(888,23,'Támara'),(889,23,'Tauramena'),(890,23,'Trinidad'),(891,23,'Villanueva'),(892,23,'Yopal'),(893,26,'Barranco Minas'),(894,26,'Cacahual'),(895,26,'Inírida'),(896,26,'La Guadalupe'),(897,26,'Mapiripana'),(898,26,'Morichal'),(899,26,'Pana Pana'),(900,26,'Puerto Colombia'),(901,26,'San Felipe'),(902,29,'Calamar'),(903,29,'El Retorno'),(904,29,'Miraflores'),(905,29,'San José del Guaviare'),(906,7,'Acacias'),(907,7,'Barranca de Upía'),(908,7,'Cabuyaro'),(909,7,'Castilla la Nueva'),(910,7,'Cubarral'),(911,7,'Cumaral'),(912,7,'El Calvario'),(913,7,'El Castillo'),(914,7,'El Dorado'),(915,7,'Fuente de Oro'),(916,7,'Granada'),(917,7,'Guamal'),(918,7,'La Macarena'),(919,7,'Lejanías'),(920,7,'Mapiripán'),(921,7,'Mesetas'),(922,7,'Puerto Concordia'),(923,7,'Puerto Gaitán'),(924,7,'Puerto Lleras'),(925,7,'Puerto López'),(926,7,'Puerto Rico'),(927,7,'Restrepo'),(928,7,'San Carlos de Guaroa'),(929,7,'San Juan de Arama'),(930,7,'San Juanito'),(931,7,'San Martín'),(932,7,'Uribe'),(933,7,'Villavicencio'),(934,7,'Vista Hermosa'),(935,27,'Caruru'),(936,27,'Mitú'),(937,27,'Pacoa'),(938,27,'Papunaua'),(939,27,'Taraira'),(940,27,'Yavaraté'),(941,28,'Cumaribo'),(942,28,'La Primavera'),(943,28,'Puerto Carreño'),(944,28,'Santa Rosalía'),(945,12,'Almaguer'),(946,12,'Argelia'),(947,12,'Balboa'),(948,12,'Bolívar'),(949,12,'Buenos Aires'),(950,12,'Cajibío'),(951,12,'Caldono'),(952,12,'Caloto'),(953,12,'Corinto'),(954,12,'El Tambo'),(955,12,'Florencia'),(956,12,'Guachené'),(957,12,'Guapi'),(958,12,'Inzá'),(959,12,'Jambaló'),(960,12,'La Sierra'),(961,12,'La Vega'),(962,12,'López'),(963,12,'Mercaderes'),(964,12,'Miranda'),(965,12,'Morales'),(966,12,'Padilla'),(967,12,'Páez'),(968,12,'Patía'),(969,12,'Piamonte'),(970,12,'Piendamó'),(971,12,'Popayán'),(972,12,'Puerto Tejada'),(973,12,'Puracé'),(974,12,'Rosas'),(975,12,'San Sebastián'),(976,12,'Santa Rosa'),(977,12,'Santander de Quilichao'),(978,12,'Silvia'),(979,12,'Sotara'),(980,12,'Suárez'),(981,12,'Sucre'),(982,12,'Timbío'),(983,12,'Timbiquí'),(984,12,'Toribio'),(985,12,'Totoró'),(986,12,'Villa Rica'),(987,4,'Acandí'),(988,4,'Alto Baudo'),(989,4,'Atrato'),(990,4,'Bagadó'),(991,4,'Bahía Solano'),(992,4,'Bajo Baudó'),(993,4,'Belén de Bajira'),(994,4,'Bojaya'),(995,4,'Carmen del Darien'),(996,4,'Cértegui'),(997,4,'Condoto'),(998,4,'El Cantón del San Pablo'),(999,4,'El Carmen de Atrato'),(1000,4,'El Litoral del San Juan'),(1001,4,'Istmina'),(1002,4,'Juradó'),(1003,4,'Lloró'),(1004,4,'Medio Atrato'),(1005,4,'Medio Baudó'),(1006,4,'Medio San Juan'),(1007,4,'Nóvita'),(1008,4,'Nuquí'),(1009,4,'Quibdó'),(1010,4,'Río Iro'),(1011,4,'Río Quito'),(1012,4,'Riosucio'),(1013,4,'San José del Palmar'),(1014,4,'Sipí'),(1015,4,'Tadó'),(1016,4,'Unguía'),(1017,4,'Unión Panamericana'),(1018,5,'Albán'),(1019,5,'Aldana'),(1020,5,'Ancuyá'),(1021,5,'Arboleda'),(1022,5,'Barbacoas'),(1023,5,'Belén'),(1024,5,'Buesaco'),(1025,5,'Chachagüí'),(1026,5,'Colón'),(1027,5,'Consaca'),(1028,5,'Contadero'),(1029,5,'Córdoba'),(1030,5,'Cuaspud'),(1031,5,'Cumbal'),(1032,5,'Cumbitara'),(1033,5,'El Charco'),(1034,5,'El Peñol'),(1035,5,'El Rosario'),(1036,5,'El Tablón de Gómez'),(1037,5,'El Tambo'),(1038,5,'Francisco Pizarro'),(1039,5,'Funes'),(1040,5,'Guachucal'),(1041,5,'Guaitarilla'),(1042,5,'Gualmatán'),(1043,5,'Iles'),(1044,5,'Imués'),(1045,5,'Ipiales'),(1046,5,'La Cruz'),(1047,5,'La Florida'),(1048,5,'La Llanada'),(1049,5,'La Tola'),(1050,5,'La Unión'),(1051,5,'Leiva'),(1052,5,'Linares'),(1053,5,'Los Andes'),(1054,5,'Magüí'),(1055,5,'Mallama'),(1056,5,'Mosquera'),(1057,5,'Nariño'),(1058,5,'Olaya Herrera'),(1059,5,'Ospina'),(1060,5,'Pasto'),(1061,5,'Policarpa'),(1062,5,'Potosí'),(1063,5,'Providencia'),(1064,5,'Puerres'),(1065,5,'Pupiales'),(1066,5,'Ricaurte'),(1067,5,'Roberto Payán'),(1068,5,'Samaniego'),(1069,5,'San Andrés de Tumaco'),(1070,5,'San Bernardo'),(1071,5,'San Lorenzo'),(1072,5,'San Pablo'),(1073,5,'San Pedro de Cartago'),(1074,5,'Sandoná'),(1075,5,'Santa Bárbara'),(1076,5,'Santacruz'),(1077,5,'Sapuyes'),(1078,5,'Taminango'),(1079,5,'Tangua'),(1080,5,'Túquerres'),(1081,5,'Yacuanquer'),(1082,33,'Alcalá'),(1083,33,'Andalucía'),(1084,33,'Ansermanuevo'),(1085,33,'Argelia'),(1086,33,'Bolívar'),(1087,33,'Buenaventura'),(1088,33,'Bugalagrande'),(1089,33,'Caicedonia'),(1090,33,'Cali'),(1091,33,'Calima'),(1092,33,'Candelaria'),(1093,33,'Cartago'),(1094,33,'Dagua'),(1095,33,'El Águila'),(1096,33,'El Cairo'),(1097,33,'El Cerrito'),(1098,33,'El Dovio'),(1099,33,'Florida'),(1100,33,'Ginebra'),(1101,33,'Guacarí'),(1102,33,'Guadalajara de Buga'),(1103,33,'Jamundí'),(1104,33,'La Cumbre'),(1105,33,'La Unión'),(1106,33,'La Victoria'),(1107,33,'Obando'),(1108,33,'Palmira'),(1109,33,'Pradera'),(1110,33,'Restrepo'),(1111,33,'Riofrío'),(1112,33,'Roldanillo'),(1113,33,'San Pedro'),(1114,33,'Sevilla'),(1115,33,'Toro'),(1116,33,'Trujillo'),(1117,33,'Tuluá'),(1118,33,'Ulloa'),(1119,33,'Versalles'),(1120,33,'Vijes'),(1121,33,'Yotoco'),(1122,33,'Yumbo'),(1123,33,'Zarzal');
/*!40000 ALTER TABLE `ciudades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamentos` (
  `id_departamento` int unsigned NOT NULL AUTO_INCREMENT,
  `departamento` varchar(255) NOT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE KEY `departamento` (`departamento`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

LOCK TABLES `departamentos` WRITE;
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
INSERT INTO `departamentos` VALUES (25,'Amazonas'),(1,'Antioquia'),(22,'Arauca'),(30,'Archipiélago de San Andrés, Providencia y Santa Catalina'),(8,'Atlántico'),(31,'Bogotá D.C.'),(9,'Bolívar'),(2,'Boyacá'),(10,'Caldas'),(11,'Caquetá'),(23,'Casanare'),(12,'Cauca'),(13,'Cesar'),(4,'Chocó'),(3,'Córdoba'),(14,'Cundinamarca'),(26,'Guainía'),(29,'Guaviare'),(15,'Huila'),(16,'La Guajira'),(17,'Magdalena'),(7,'Meta'),(5,'Nariño'),(32,'Norte de Santander'),(24,'Putumayo'),(18,'Quindío'),(19,'Risaralda'),(6,'Santander'),(20,'Sucre'),(21,'Tolima'),(33,'Valle del Cauca'),(27,'Vaupés'),(28,'Vichada');
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `id_factura` int unsigned NOT NULL AUTO_INCREMENT,
  `id_alquiler` int unsigned NOT NULL,
  `totaL_pagar` decimal(12,2) NOT NULL,
  `valor_pagado` decimal(12,2) NOT NULL DEFAULT '0.00',
  `was_paid` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_factura`),
  KEY `fk_factura_alquiler` (`id_alquiler`),
  CONSTRAINT `fk_factura_alquiler` FOREIGN KEY (`id_alquiler`) REFERENCES `alquileres` (`id_alquiler`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `internal_users_summary_pretty`
--

DROP TABLE IF EXISTS `internal_users_summary_pretty`;
/*!50001 DROP VIEW IF EXISTS `internal_users_summary_pretty`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `internal_users_summary_pretty` AS SELECT 
 1 AS `id_usuario`,
 1 AS `Nombre completo`,
 1 AS `correo_electronico`,
 1 AS `ciudad`,
 1 AS `tipo_usuario`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rental_data_history_pretty`
--

DROP TABLE IF EXISTS `rental_data_history_pretty`;
/*!50001 DROP VIEW IF EXISTS `rental_data_history_pretty`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rental_data_history_pretty` AS SELECT 
 1 AS `Nombre_cliente`,
 1 AS `Nombre_vendedor`,
 1 AS `modelo`,
 1 AS `matricula`,
 1 AS `Ciudad_alquiler`,
 1 AS `Ciudad_entrega`,
 1 AS `dias`,
 1 AS `valor_cotizado`,
 1 AS `fecha_salida`,
 1 AS `fecha_esperada_llegada`,
 1 AS `fecha_llegada`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `id_sucursal` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ciudad` int unsigned NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono_fijo` varchar(7) NOT NULL,
  `celular` varchar(10) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  PRIMARY KEY (`id_sucursal`),
  UNIQUE KEY `direccion` (`direccion`),
  UNIQUE KEY `telefono_fijo` (`telefono_fijo`),
  UNIQUE KEY `celular` (`celular`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`),
  KEY `fk_sucursal_ciudad` (`id_ciudad`),
  KEY `sucursales_correo_electronico` (`correo_electronico`),
  CONSTRAINT `fk_sucursal_ciudad` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudades` (`id_ciudad`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` VALUES (1,486,'Cra 4 #6-75 San Cristóbal','6550000','3170000000','sucursalbga@gmail.com'),(2,757,'Cra 4 #6-75 San Joaquín','6550001','3170000001','sucursalmedellin@gmail.com'),(3,198,'Cra 4 #6-75 Chapinero','6550002','3170000002','sucursalbgta@gmail.com'),(4,1090,'Cra 4 #6-75 El peñón','6550003','3170000003','sucursalcali@gmail.com'),(5,4,'Cra 4 #6-75 Bella Vista','6550004','3170000004','sucursalbarranquilla@gmail.com');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_motor`
--

DROP TABLE IF EXISTS `tipo_motor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_motor` (
  `codigo_tipo_motor` int unsigned NOT NULL AUTO_INCREMENT,
  `motor` varchar(64) NOT NULL,
  PRIMARY KEY (`codigo_tipo_motor`),
  UNIQUE KEY `motor` (`motor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_motor`
--

LOCK TABLES `tipo_motor` WRITE;
/*!40000 ALTER TABLE `tipo_motor` DISABLE KEYS */;
INSERT INTO `tipo_motor` VALUES (1,'Atmosférico'),(4,'Cilindro opuesto'),(3,'Doble cilíndro'),(2,'Monocilíndrico'),(5,'Multicilíndrico');
/*!40000 ALTER TABLE `tipo_motor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usuario` (
  `codigo_tipo_usuario` int unsigned NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(64) NOT NULL,
  PRIMARY KEY (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla para el manejo de usuarios / roles en el sistema, se incluyen: Administrador, Trabajador y Clientes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` VALUES (1,'Administrador'),(2,'Trabajador'),(3,'Cliente');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_vehiculo`
--

DROP TABLE IF EXISTS `tipo_vehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_vehiculo` (
  `codigo_tipo_vehiculo` int unsigned NOT NULL AUTO_INCREMENT,
  `tipo_vehiculo` varchar(64) NOT NULL,
  PRIMARY KEY (`codigo_tipo_vehiculo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_vehiculo`
--

LOCK TABLES `tipo_vehiculo` WRITE;
/*!40000 ALTER TABLE `tipo_vehiculo` DISABLE KEYS */;
INSERT INTO `tipo_vehiculo` VALUES (1,'Sedán / Berlina'),(2,'Compacto'),(3,'Camioneta platón'),(4,'Camioneta de lujo'),(5,'Deportivo'),(6,'Coupé'),(7,'Familiar'),(8,'Furgoneta'),(9,'Monovolumen'),(10,'Superdeportivo');
/*!40000 ALTER TABLE `tipo_vehiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `users_summary_pretty`
--

DROP TABLE IF EXISTS `users_summary_pretty`;
/*!50001 DROP VIEW IF EXISTS `users_summary_pretty`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `users_summary_pretty` AS SELECT 
 1 AS `id_usuario`,
 1 AS `Nombre completo`,
 1 AS `correo_electronico`,
 1 AS `ciudad`,
 1 AS `tipo_usuario`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int unsigned NOT NULL AUTO_INCREMENT,
  `nombres` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `identificacion` varchar(14) NOT NULL COMMENT 'Cédula del cliente',
  `direccion` varchar(255) NOT NULL,
  `id_ciudad_residencia` int unsigned NOT NULL,
  `celular` varchar(10) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `codigo_tipo_usuario` int unsigned NOT NULL,
  `codigo_sucursal` int unsigned DEFAULT NULL COMMENT 'Columna usada para asociar los trabajadores a la sucursal en la que trabajan',
  `is_active` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `identificacion` (`identificacion`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`),
  KEY `usuarios_id_usuario` (`id_usuario`),
  KEY `usuario_nombres` (`nombres`),
  KEY `usuario_apellidos` (`apellidos`),
  KEY `usuario_correo_electronico` (`correo_electronico`),
  KEY `fk_usuario_tipo_usuario` (`codigo_tipo_usuario`),
  KEY `fk_usuario_sucursal` (`codigo_sucursal`),
  KEY `fk_usuario_ciudad` (`id_ciudad_residencia`),
  CONSTRAINT `fk_usuario_ciudad` FOREIGN KEY (`id_ciudad_residencia`) REFERENCES `ciudades` (`id_ciudad`) ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_sucursal` FOREIGN KEY (`codigo_sucursal`) REFERENCES `sucursales` (`id_sucursal`) ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_tipo_usuario` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tipo_usuario` (`codigo_tipo_usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Violet','Nicolas','37614521','Cra 6002 Vía Ankunding Passage',538,'3145641789','Violet.Nicolas@gmail.com','440b87eb90b816118a29dcdfab0350f095534cc480fdcb68188174136898ab24',3,NULL,1),(2,'Olivia','Heathcote','39090152','Cra 03550 Vía Parker Loop',538,'3146296504','Olivia.Heathcote@gmail.com','d1bebb16f8a9e6f21aa6ac5c644706a71ab62d7dec56d7aa1c9f0f494c2cc9d0',3,NULL,1),(3,'Ted','Wintheiser','40565783','Cra 516 Vía D.Amore Valleys',538,'3146951219','Ted.Wintheiser@gmail.com','7743a6ff0bb07518a9401633370c2f375f5e614a7aedc58746579f3e80e2d4ea',3,NULL,1),(4,'Oliver','Runolfsson','42041414','Cra 7317 Vía Araceli Mall',538,'3147605934','Oliver.Runolfsson@gmail.com','2524338fc7ddba552199637bedc4b7e2541cc366df7892d4d0965aecf1800a13',3,NULL,1),(5,'Clinton','Bosco','43517045','Cra 83324 Vía Kunze Prairie',538,'3148260649','Clinton.Bosco@gmail.com','762a76dc8c44200645073ec858d9ee80e346dfd079c7bd342c1d96b79e57eb14',3,NULL,1),(6,'Louis','Cummerata','44992676','Cra 255 Vía Laron Drives',486,'3148915364','Louis.Cummerata@gmail.com','5950b95f250dea758aa360ff96fcc02adbb6b581267051d7198c3357c006789f',3,NULL,1),(7,'Diane','Smith','46468307','Cra 6091 Vía Darlene Lake',486,'3149570079','Diane.Smith@gmail.com','a7cfdd09eab12c9e8c7e0dd154928354c42e2341e93a49123d05d60c37e9b272',3,NULL,1),(8,'Phyllis','Krajcik','47943938','Cra 011 Vía Ubaldo Shoal',486,'3150224794','Phyllis.Krajcik@gmail.com','3459128867db1429e60aea6404084fbde107abc1837e2e992ce66db80f4e6059',3,NULL,1),(9,'Allison','Corwin','49419569','Cra 8869 Vía Maximillian Throughway',486,'3150879509','Allison.Corwin@gmail.com','08e3f721cd115609e87333ace695d56c981b2e5f985ea8b1b273a2e2c15be169',3,NULL,1),(10,'Angelo','Osinski','50895200','Cra 755 Vía Coty Mount',486,'3151534224','Angelo.Osinski@gmail.com','19c5a4541dc435815e01a3f89132d287b95809734f4b25c5ad072237070a936d',3,NULL,1),(11,'Jimmie','Thompson','52370831','Cra 06365 Vía Green Pike',757,'3152188939','Jimmie.Thompson@gmail.com','51ec7a71e55004ea08ccfa35822437d5d3b28d877c0aa66f2f6a2a73cc46af9c',3,NULL,1),(12,'Mable','Fahey','53846462','Cra 8974 Vía Tromp Squares',757,'3152843654','Mable.Fahey@gmail.com','228d50ceb4426d0a4da39d5be1ca398256cbbf38e0949aa718c1638c8f147242',3,NULL,1),(13,'Matthew','Howell','55322093','Cra 4120 Vía Cormier Walk',757,'3153498369','Matthew.Howell@gmail.com','b41c2f52614053bb5544612f9a3c79a520573b6fcc8f2dd7d5860e84bc1efa00',3,NULL,1),(14,'Mary','White','56797724','Cra 465 Vía Adelbert Islands',757,'3154153084','Mary.White@gmail.com','cb4ec729215695a3de37c5f2e1d388198d4ba60e0b56cd0fcee7db2ce2c82681',3,NULL,1),(15,'Verna','Hessel','58273355','Cra 588 Vía Rempel Island',757,'3154807799','Verna.Hessel@gmail.com','545f0a8e7f2b79844304ab86ecffd632d5d81f87e526438beada042c0c77dadb',3,NULL,1),(16,'Javier','Senger','59748986','Cra 0455 Vía Hammes Avenue',757,'3155462514','Javier.Senger@gmail.com','dea0b45a74a7adc2b7c571eba4f7bd507968794924b61d94119817c8174bbf7a',3,NULL,1),(17,'Betsy','Hahn','61224617','Cra 695 Vía Ottis Grove',757,'3156117229','Betsy.Hahn@gmail.com','c1b42ba1bcda6c9018954749170525a0209e10ad3d1f4d0dd8be3bfaf400c055',3,NULL,1),(18,'Elizabeth','Champlin','62700248','Cra 5366 Vía Gottlieb Point',757,'3156771944','Elizabeth.Champlin@gmail.com','a567dc290513361285ae1600af06f86bf5780aff41aeb216644d5dcdb068e308',3,NULL,1),(19,'Bertha','Corwin','64175879','Cra 4300 Vía Hellen Locks',757,'3157426659','Bertha.Corwin@gmail.com','d6921ec773373cd8e6b90175ff8fc6258cb6d6aef066d26a4c603b923bd86eea',3,NULL,1),(20,'Jean','Ratke','65651510','Cra 6511 Vía Domenick Parks',757,'3158081374','Jean.Ratke@gmail.com','483cf5cc8bd2f6135fe32dc2bf0f5322c7b18298d4d4a2b12c015b288453f97e',3,NULL,1),(21,'Brent','Cruickshank','67127141','Cra 4453 Vía Fadel Drive',198,'3158736089','Brent.Cruickshank@gmail.com','105dca0b5ee417384d18c57f52aa33542e7a5ed7e3e7a88326ebd781043542ed',3,NULL,1),(22,'Brandi','Lowe','68602772','Cra 041 Vía Camden Forges',198,'3159390804','Brandi.Lowe@gmail.com','087826ddddac4f499b5306dc4fd06a6c31128de87775369231ede5a9ed1fdc6d',3,NULL,1),(23,'Moses','Lubowitz','70078403','Cra 24629 Vía Goyette Inlet',198,'3160045519','Moses.Lubowitz@gmail.com','f5b6ea8bb1040f09be70960619812148ae806683920f0a51fa83a104f22732d9',3,NULL,1),(24,'Jonathon','Macejkovic','71554034','Cra 498 Vía Von Estates',198,'3160700234','Jonathon.Macejkovic@gmail.com','8bf528180d3006ad0b4b7cf396cabce4e4d332a2197cc01082dfd3c247e8b1b5',3,NULL,1),(25,'Nina','Welch','73029665','Cra 1981 Vía Victor Isle',198,'3161354949','Nina.Welch@gmail.com','6aa789aad2c55db4a556c40032b3f6a96497ea95090f1f43bb9aff746e1597ff',3,NULL,1),(26,'Hector','Braun','74505296','Cra 12182 Vía Brayan Landing',198,'3162009664','Hector.Braun@gmail.com','cf5097f9779b79c3e25a3f2c0e888a99112c1aa8fee36f27799fa5b0366c9450',3,NULL,1),(27,'Cedric','Schuster','75980927','Cra 23374 Vía Larson Drives',198,'3162664379','Cedric.Schuster@gmail.com','b78c1b0dbea6e55a431350530e03cd88db0fd7446fca142e3030c39fb901d25f',3,NULL,1),(28,'Isaac','Ankunding','77456558','Cra 6472 Vía Alycia Knolls',198,'3163319094','Isaac.Ankunding@gmail.com','43a46de507aa9f840bbd30b4a1c0d39ef4407591b62f672752ad72fb8932c2b2',3,NULL,1),(29,'Stella','Raynor','78932189','Cra 2868 Vía Skyla Stravenue',198,'3163973809','Stella.Raynor@gmail.com','165ecb2b076de96d237b4d5c2ae6992bfe865b0331de2deb0ed07fa61c29de3b',3,NULL,1),(30,'Faith','Doyle','80407820','Cra 797 Vía Estella Track',198,'3164628524','Faith.Doyle@gmail.com','8eebbd898c1591c0cce9a272ded137c8522002931a5cd5d0f505108cc69ecf01',3,NULL,1),(31,'Jonathon','Yost','81883451','Cra 45757 Vía Farrell Club',1090,'3165283239','Jonathon.Yost@gmail.com','936ad1395b71fad9c7310154a3901a8840eb78c0f517ac397a681cf5c68d4e8f',3,NULL,1),(32,'Emilio','Bartell','83359082','Cra 62492 Vía Anabelle Causeway',1090,'3165937954','Emilio.Bartell@gmail.com','ec27e6b1e1a4cb13961b383f1431e032d1c427cb82c5e195036681ec035cf5da',3,NULL,1),(33,'Adrian','Zulauf','84834713','Cra 122 Vía Denesik Tunnel',1090,'3166592669','Adrian.Zulauf@gmail.com','b146985dfe939e73840bed0e9020027714c9d51d78dd181e02af5d6abcf8d93e',3,NULL,1),(34,'Dale','Harris','86310344','Cra 1774 Vía Schowalter Parkways',1090,'3167247384','Dale.Harris@gmail.com','32e32a97025fc1ca10366378586a654d40eba0760b1b8b0fb29e8c9d38001eeb',3,NULL,1),(35,'Jean','Kreiger','87785975','Cra 8120 Vía Kertzmann Skyway',1090,'3167902099','Jean.Kreiger@gmail.com','75994d1eda33ecb4883a5ed71356115be7cdf2aeb43fa83c9273b6e0925440bf',3,NULL,1),(36,'Delbert','Schamberger','89261606','Cra 783 Vía Karlee Tunnel',1090,'3168556814','Delbert.Schamberger@gmail.com','c112b343137af618d500bc5b1d64a67b7667b30a88529a58462c78f32d91b8f5',3,NULL,1),(37,'Clyde','O','90737237','Cra 738 Vía Amara Streets',1090,'3169211529','Clyde.O@gmail.com','bf92be1e11da76af29fe2caa4ce2a2d59a12c2911528a0c52c96128560d18b45',3,NULL,1),(38,'Jody','Romaguera','92212868','Cra 0514 Vía Goyette Throughway',1090,'3169866244','Jody.Romaguera@gmail.com','0d07d5b2c876440341d6b70a4ebdc05c709e456248e305692d80c64ae511b859',3,NULL,1),(39,'Gerardo','McLaughlin','93688499','Cra 0410 Vía Solon Ville',1090,'3170520959','Gerardo.McLaughlin@gmail.com','009d4575b5493d24236d9de4a764c2daf8aeee2a817f1085aa981176089463d6',3,NULL,1),(40,'Mona','Heathcote','95164130','Cra 2906 Vía Doyle Prairie',1090,'3171175674','Mona.Heathcote@gmail.com','4de837f1dfd7a29bbdeb5e72da933f8a0e85c51f0721ccd8821513ccb555a533',3,NULL,1),(41,'Joanne','Buckridge','96639761','Cra 38659 Vía Mosciski Fords',4,'3171830389','Joanne.Buckridge@gmail.com','cf40e3de040a0b78473d6ba6b3a8b57a7da4b14186405baf2cb55dc6e3314a51',3,NULL,1),(42,'Jan','Boehm','98115392','Cra 481 Vía Rippin Ranch',4,'3172485104','Jan.Boehm@gmail.com','a686778451bebc821f593603441aa2246360445465f521fd1da5735c67a797d1',3,NULL,1),(43,'Deborah','Nicolas','99591023','Cra 46593 Vía Zoila Spring',4,'3173139819','Deborah.Nicolas@gmail.com','dd66884427dba18a46425304191f2e05ac4530830cf17e5d77d0ed5f2129bb65',3,NULL,1),(44,'Maria','Feil','101066654','Cra 47586 Vía Issac Avenue',4,'3173794534','Maria.Feil@gmail.com','5a3cc860eddb3244eb42e0a962350fe345e6c384185aba663cfb427646c12468',3,NULL,1),(45,'Rachel','Zboncak','102542285','Cra 1946 Vía Ruecker Rapids',4,'3174449249','Rachel.Zboncak@gmail.com','e770115248d2fd1f2ad7a607ee5640e29b754abb563e55c7acd3df24a5cd78ac',3,NULL,1),(46,'Rebecca','Morissette','104017916','Cra 4367 Vía Schmidt Pass',4,'3175103964','Rebecca.Morissette@gmail.com','776f795572341b4d9873691d060546cd58b6308531ddf5544e4de56f5d62e7d1',3,NULL,1),(47,'Kelli','Zemlak','105493547','Cra 7946 Vía Robel Mill',4,'3175758679','Kelli.Zemlak@gmail.com','fd06602dfee03200d42c82267b5258b7d65b1330e71e5246369e004f5c8450d3',3,NULL,1),(48,'Kellie','Kunde','106969178','Cra 909 Vía Ofelia Crossroad',4,'3176413394','Kellie.Kunde@gmail.com','84998f80260243ee6dd6995a1d332c32135b51057775d3df86b9db21a138c860',3,NULL,1),(49,'Debra','McGlynn','108444809','Cra 285 Vía McGlynn Garden',4,'3177068109','Debra.McGlynn@gmail.com','e85dd8051f5dd52efffc3e8226e805140efbb635778903bea2362ef9d691a04c',3,NULL,1),(50,'Johanna','Halvorson','109920440','Cra 967 Vía Connelly Loop',4,'3177722824','Johanna.Halvorson@gmail.com','4c56127abfd8b61660c8b9f931f97e464b74b7b27df78c1698ffa3c8adcfc813',3,NULL,1),(51,'Carlos','Laferte','36616203','Cra 5ta #6-70 La Rioja',538,'3117156320','carloslaferte@outlook.com','Carlos.Laferte2021*/',1,1,1),(52,'Alejandra','Hernández','1004152789','Cra 6ta #20-50 El Prado',757,'3147895201','alejandrahdez@gmail.com','Alejandra.Hernandez2021*/',1,2,1),(53,'Juan Sebastián','Urán','1004789522','Cll 5C #782-740 Kennedy',198,'3168952200','juanuran@outlook.com','Juan.Uran2021*/',1,3,1),(54,'Maria','Vargas','37895620','Cll 7D #20-35 La Merced',1090,'3187452033','mariavargas@gmail.com','Maria.Vargas2021*/',1,4,1),(55,'Breiner','Aguilar','1002156321','Cra 7 #20-35 Barlovento',4,'3174552217','breineraguilar@outlook.com','Breiner.Aguilar2021*/',1,5,1),(56,'Eva','Batz','36781299','Cra 155 Bechtelar Street',538,'3167852239','Eva.Batz@gmail.com','Eva.Batz2021*/',2,1,1),(57,'Brett','Abshire','36860203','Cra 73254 Padberg Cliff',538,'3167932080','Brett.Abshire@gmail.com','Brett.Abshire2021*/',2,1,1),(58,'Suzanne','Toy','36939107','Cra 89576 Maggio Meadows',757,'3168011921','Suzanne.Toy@gmail.com','Suzanne.Toy2021*/',2,2,1),(59,'Jennifer','Morar','37018011','Cra 750 Stella Brook',757,'3168091762','Jennifer.Morar@gmail.com','Jennifer.Morar2021*/',2,2,1),(60,'Salvatore','Douglas','37096915','Cra 6624 OConnell Well',198,'3168171603','Salvatore.Douglas@gmail.com','Salvatore.Douglas2021*/',2,3,1),(61,'Emilio','Welch','37175819','Cra 26737 Quigley Mission',198,'3168251444','Emilio.Welch@gmail.com','Emilio.Welch2021*/',2,3,1),(62,'Karl','Ziemann','37254723','Cra 3161 Hermiston Flat',1090,'3168331285','Karl.Ziemann@gmail.com','Karl.Ziemann2021*/',2,4,1),(63,'Kellie','Dietrich','37333627','Cra 84537 Jana Centers',1090,'3168411126','Kellie.Dietrich@gmail.com','Kellie.Dietrich2021*/',2,4,1),(64,'Wilbur','Grimes','37412531','Cra 1758 Wilderman Ways',4,'3168490967','Wilbur.Grimes@gmail.com','Wilbur.Grimes2021*/',2,5,1),(65,'Roman','Hoeger','37491435','Cra 31737 Hanna Viaduct',4,'3168570808','Roman.Hoeger@gmail.com','Roman.Hoeger2021*/',2,5,1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vehicles_information_pretty`
--

DROP TABLE IF EXISTS `vehicles_information_pretty`;
/*!50001 DROP VIEW IF EXISTS `vehicles_information_pretty`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vehicles_information_pretty` AS SELECT 
 1 AS `id_vehiculo`,
 1 AS `matricula`,
 1 AS `tipo_vehiculo`,
 1 AS `modelo`,
 1 AS `numero_puertas`,
 1 AS `capacidad`,
 1 AS `has_sunroof`,
 1 AS `motor`,
 1 AS `color`,
 1 AS `descuento`,
 1 AS `valor_alquiler_semanal`,
 1 AS `valor_alquiler_diario`,
 1 AS `disponible`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vehículos`
--

DROP TABLE IF EXISTS `vehículos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehículos` (
  `id_vehiculo` int unsigned NOT NULL AUTO_INCREMENT,
  `matricula` varchar(6) NOT NULL,
  `codigo_tipo_vehiculo` int unsigned NOT NULL,
  `modelo` varchar(64) NOT NULL,
  `numero_puertas` tinyint unsigned NOT NULL,
  `capacidad` tinyint unsigned NOT NULL,
  `has_sunroof` tinyint unsigned NOT NULL,
  `codigo_tipo_motor` int unsigned NOT NULL,
  `color` varchar(64) NOT NULL,
  `disponible` tinyint unsigned NOT NULL,
  `valor_alquiler_semanal` decimal(12,2) NOT NULL,
  `valor_alquiler_diario` decimal(12,2) NOT NULL,
  `descuento` decimal(3,1) NOT NULL,
  `veces_alquilado` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_vehiculo`),
  UNIQUE KEY `matricula` (`matricula`),
  KEY `vehiculo_matricula` (`matricula`),
  KEY `vehiculo_modelo` (`modelo`),
  KEY `vehiculo_disponible` (`disponible`),
  KEY `vehiculo_tipo_vehiculo` (`codigo_tipo_vehiculo`),
  KEY `vehiculo_descuento` (`descuento`),
  KEY `fk_vehiculo_tipo_motor` (`codigo_tipo_motor`),
  CONSTRAINT `fk_vehiculo_tipo_motor` FOREIGN KEY (`codigo_tipo_motor`) REFERENCES `tipo_motor` (`codigo_tipo_motor`) ON UPDATE CASCADE,
  CONSTRAINT `fk_vehiculo_tipo_vehiculo` FOREIGN KEY (`codigo_tipo_vehiculo`) REFERENCES `tipo_vehiculo` (`codigo_tipo_vehiculo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehículos`
--

LOCK TABLES `vehículos` WRITE;
/*!40000 ALTER TABLE `vehículos` DISABLE KEYS */;
INSERT INTO `vehículos` VALUES (1,'GOA001',1,'Onix',4,5,1,2,'Negro',1,460000.00,55857.00,0.0,0),(2,'GOA002',1,'Logan',4,5,0,3,'Blanco',1,470000.00,57071.00,0.0,0),(3,'GOA003',1,'Beat',4,5,1,4,'Azul',1,480000.00,58285.00,0.0,0),(4,'GOA004',1,'Versa',4,5,0,5,'Rojo',1,490000.00,59500.00,0.0,0),(5,'GOA005',1,'Joy',4,5,1,2,'Gris',1,440000.00,53428.00,0.0,0),(6,'GOA006',2,'Sandero',4,4,1,3,'Negro',1,575000.00,69821.00,0.0,0),(7,'GOA007',2,'Twingo',2,4,0,4,'Blanco',1,540000.00,65571.00,0.0,0),(8,'GOA008',2,'Picanto',4,4,1,5,'Azul',1,580000.00,70428.00,0.0,0),(9,'GOA009',2,'Gravity',4,4,0,2,'Rojo',1,575000.00,69821.00,0.0,0),(10,'GOA010',2,'Ibiza',2,4,1,3,'Gris',1,540000.00,65571.00,0.0,0),(11,'GOA011',3,'Amarok',4,5,0,4,'Negro',1,640000.00,77714.00,0.0,0),(12,'GOA012',3,'Saveiro',4,5,0,5,'Blanco',1,655000.00,79535.00,0.0,0),(13,'GOA013',3,'Ranger',4,5,0,2,'Azul',1,665000.00,80750.00,0.0,0),(14,'GOA014',3,'Raptor',4,5,0,3,'Rojo',1,670000.00,81357.00,0.0,0),(15,'GOA015',3,'F-150',4,5,0,4,'Gris',1,620000.00,75285.00,0.0,0),(16,'GOA016',4,'Evoque ',4,5,0,5,'Negro',1,575000.00,69821.00,0.0,0),(17,'GOA017',4,'Acadia',4,5,0,2,'Blanco',1,540000.00,65571.00,0.0,0),(18,'GOA018',4,'Navigator',4,5,0,3,'Azul',1,580000.00,70428.00,0.0,0),(19,'GOA019',4,'QX80 Infiniti',4,5,0,4,'Rojo',1,575000.00,69821.00,0.0,0),(20,'GOA020',4,'Cayenne',4,5,0,5,'Gris',1,540000.00,65571.00,0.0,0),(21,'GOA021',5,'Supra',2,2,0,2,'Negro',1,740000.00,89857.00,0.0,0),(22,'GOA022',5,'DB11',4,4,0,3,'Blanco',1,720000.00,87428.00,0.0,0),(23,'GOA023',5,'Subaru',4,4,1,4,'Azul',1,695000.00,84392.00,0.0,0),(24,'GOA024',5,'M5',2,2,0,5,'Rojo',1,710000.00,86214.00,0.0,0),(25,'GOA025',5,'MX-5 RF',2,2,0,2,'Gris',1,765000.00,92892.00,0.0,0),(26,'GOA026',6,'e-tron GT',4,4,1,3,'Negro',1,575000.00,69821.00,0.0,0),(27,'GOA027',6,'Camaro',4,4,1,4,'Blanco',1,540000.00,65571.00,0.0,0),(28,'GOA028',6,'Mustang',4,4,1,5,'Azul',1,580000.00,70428.00,0.0,0),(29,'GOA029',6,'Shelby',4,4,1,2,'Rojo',1,575000.00,69821.00,0.0,0),(30,'GOA030',6,'F-Type',4,4,1,3,'Gris',1,540000.00,65571.00,0.0,0),(31,'GOA031',7,'Qashqai',4,5,0,4,'Negro',1,460000.00,55857.00,0.0,0),(32,'GOA032',7,'Compass',4,5,0,5,'Blanco',1,470000.00,57071.00,0.0,0),(33,'GOA033',7,'Odyssey',4,5,0,2,'Azul',1,480000.00,58285.00,0.0,0),(34,'GOA034',7,'Jetta',4,5,0,3,'Rojo',1,490000.00,59500.00,0.0,0),(35,'GOA035',7,'Accent',4,5,0,4,'Gris',1,440000.00,53428.00,0.0,0),(36,'GOA036',8,'Dokker',4,7,0,5,'Negro',1,640000.00,77714.00,0.0,0),(37,'GOA037',8,'Kangoo',2,9,0,2,'Blanco',1,655000.00,79535.00,0.0,0),(38,'GOA038',8,'Dobló',4,7,0,3,'Azul',1,665000.00,80750.00,0.0,0),(39,'GOA039',8,'Proace City',2,9,0,4,'Rojo',1,670000.00,81357.00,0.0,0),(40,'GOA040',8,'Rifter',4,7,0,5,'Gris',1,620000.00,75285.00,0.0,0),(41,'GOA041',9,'Active Tourer',4,5,0,2,'Negro',1,460000.00,55857.00,0.0,0),(42,'GOA042',9,'Jazz',4,5,0,3,'Blanco',1,470000.00,57071.00,0.0,0),(43,'GOA043',9,'E-Rifter',4,5,0,4,'Azul',1,480000.00,58285.00,0.0,0),(44,'GOA044',9,'E-Berlingo',2,5,0,5,'Rojo',1,490000.00,59500.00,0.0,0),(45,'GOA045',9,'Space Tourer',2,5,0,2,'Gris',1,440000.00,53428.00,0.0,0),(46,'GOA046',10,'AUV',2,2,1,1,'Negro',1,2200000.00,267142.00,0.0,0),(47,'GOA047',10,'R8',4,2,1,1,'Blanco',1,1850000.00,224642.00,0.0,0),(48,'GOA048',10,'Sián',2,2,1,1,'Azul',1,1950000.00,236785.00,0.0,0),(49,'GOA049',10,'Spyder',2,2,1,1,'Rojo',1,1850000.00,224642.00,0.0,0),(50,'GOA050',10,'Gemera',2,2,1,1,'Gris',1,1850000.00,224642.00,0.0,0);
/*!40000 ALTER TABLE `vehículos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'PROYECTO_AULA_BD'
--
/*!50003 DROP PROCEDURE IF EXISTS `ADD_CITY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_CITY`(
	IN depto VARCHAR(255), 
	IN mun VARCHAR(255)
)
BEGIN
	
	SELECT id_departamento INTO @id_depto FROM departamentos 
		WHERE departamentos.departamento = depto; 
	
	INSERT INTO ciudades(id_departamento, ciudad) VALUES(@id_depto, mun); 
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consult_bill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consult_bill`(
	id_alquiler INT UNSIGNED
)
BEGIN
	SELECT *
	FROM factura AS f
	WHERE f.id_alquiler = id_alquiler; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_bill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_bill`(
	id_alquiler INT UNSIGNED
)
BEGIN SET @recargo = 0; 
	
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `disable_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `disable_user`(
	IN id_usuario INT UNSIGNED
)
BEGIN
	UPDATE usuarios SET is_active = 0
	WHERE usuarios.id_usuario = id_usuario; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `disable_vehicle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `disable_vehicle`(
	IN id_vehiculo INT UNSIGNED
)
BEGIN
	UPDATE VEHICULOS SET disponible = 0
	WHERE VEHICULOS.`id_vehiculo` = id_vehiculo; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_available_vehicles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_available_vehicles`()
BEGIN
	SELECT *
	FROM VEHICLES_INFORMATION_PRETTY
	WHERE disponible = 1; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_available_vehicles_filter_by_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_available_vehicles_filter_by_price`(
	IN min_price DECIMAL(12,2), 
	IN max_price DECIMAL(12,2)
)
BEGIN
	SELECT *
	FROM VEHICLES_INFORMATION_PRETTY
	WHERE 
		disponible = 1 AND
		VEHICLES_INFORMATION_PRETTY.valor_alquiler_semanal >= min_price AND
		VEHICLES_INFORMATION_PRETTY.valor_alquiler_semanal <= max_price; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_available_vehicles_filter_by_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_available_vehicles_filter_by_type`(
	IN tipo_vehiculo VARCHAR(255) 
)
BEGIN
	SELECT *
	FROM VEHICLES_INFORMATION_PRETTY
	WHERE 
		disponible = 1 AND
		VEHICLES_INFORMATION_PRETTY.tipo_vehiculo = tipo_vehiculo; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_rental_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_rental_history`()
BEGIN
	SELECT *
	FROM rental_data_history_pretty; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_new_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_new_client`(
	IN nombres VARCHAR(255), 
	IN apellidos VARCHAR(255), 
	IN identificacion VARCHAR(14), 
	IN direccion VARCHAR(255), 
	IN id_ciudad_residencia INT UNSIGNED, 
	IN celular VARCHAR(10), 
	IN correo_electronico VARCHAR(255), 
	IN user_password VARCHAR(255) 
)
BEGIN 

	/*Encriptar la user_password*/ 
	SET @hashed = SHA2(user_password, 256);

	INSERT INTO 
	usuarios(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electronico, 
		user_password, 
		codigo_tipo_usuario
	) VALUES(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electronico, 
		@hashed, 
		3
); END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_new_internal_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_new_internal_user`(
	IN nombres VARCHAR(255), 
	IN apellidos VARCHAR(255), 
	IN identificacion VARCHAR(14), 
	IN direccion VARCHAR(255), 
	IN id_ciudad_residencia INT UNSIGNED, 
	IN celular VARCHAR(10), 
	IN correo_electronico VARCHAR(255), 
	IN user_password VARCHAR(255), 
	IN codigo_tipo_usuario INT UNSIGNED, 
	IN codigo_sucursal INT UNSIGNED
)
BEGIN
INSERT INTO usuarios(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electronico, 
		user_password, 
		codigo_tipo_usuario, 
		codigo_sucursal
	) VALUES(
		nombres, 
		apellidos, 
		identificacion, 
		direccion, 
		id_ciudad_residencia, 
		celular, 
		correo_electronico, 
		user_password, 
		codigo_tipo_usuario, 
		codigo_sucursal
	); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_payment`(
 IN id_factura INT UNSIGNED
)
BEGIN 

	/*Cambia la columna de estado was_paid*/
	UPDATE factura SET 
			factura.was_paid = 1,
			factura.valor_pagado = factura.totaL_pagar
	WHERE factura.id_factura = id_factura; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_vehicle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_vehicle`(
	IN matricula VARCHAR(6), 
	IN codigo_tipo_vehiculo INT UNSIGNED, 
	IN modelo VARCHAR(64), 
	IN número_puertas TINYINT(2) UNSIGNED, 
	IN capacidad TINYINT(2) UNSIGNED,
	IN has_sunroof TINYINT(1) UNSIGNED, 
	IN codigo_tipo_motor INT UNSIGNED, 
	IN color VARCHAR(64), 
	IN disponible TINYINT(1) UNSIGNED, 
	IN valor_alquiler_semanal DECIMAL(12,2), 
	IN valor_alquiler_diario DECIMAL(12,2),
	IN descuento DECIMAL(3,1) 
)
BEGIN
INSERT INTO VEHICULOS(
		matricula, 
		codigo_tipo_vehiculo, 
		modelo, 
		número_puertas, 
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
		número_puertas, 
		capacidad, 
		has_sunroof, 
		codigo_tipo_motor, 
		color, 
		disponible, 
		valor_alquiler_semanal, 
		valor_alquiler_diario, 
		descuento
	); END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_vehicle_arrival` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_vehicle_arrival`(
	id_alquiler INT UNSIGNED
)
BEGIN 

	/*Se actualiza la fecha de llegada*/
	UPDATE alquileres SET alquileres.fecha_llegada = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_vehicle_pickup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_vehicle_pickup`(
	id_alquiler INT UNSIGNED
)
BEGIN 

	/*Se actualiza la fecha de recogida*/
	UPDATE alquileres SET alquileres.fecha_recogida = CURRENT_TIMESTAMP
	WHERE alquileres.id_alquiler = id_alquiler; 
		
		/*Se actualiza la fecha máxima de entrega a partir de los días del alquiler y la fecha de recogida*/
	UPDATE alquileres SET alquileres.fecha_entrega_pactada = ADDDATE(alquileres.fecha_recogida, alquileres.dias)
	WHERE alquileres.id_alquiler = id_alquiler;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_vehicle_rental` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_vehicle_rental`(
	IN id_cliente INT UNSIGNED, 
	IN id_empleado INT UNSIGNED, 
	IN id_vehiculo INT UNSIGNED, 
	IN id_sucursal_alquiler INT UNSIGNED,
	IN id_sucursal_entrega INT UNSIGNED, 
	IN fecha_salida TIMESTAMP, 
	IN fecha_esperada_llegada TIMESTAMP, 
	IN dias TINYINT UNSIGNED
)
BEGIN 

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
			Dentro del registro del alquiler, debeinsertar el precio de alquiler diario y semanal del vehículo al momento
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
				valor_cotizado) VALUES (
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
			); SET @success = 1; 
			
		END IF;
		
	SELECT @success; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_vehicle_return` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_vehicle_return`(
	id_alquiler INT UNSIGNED
)
BEGIN 

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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_disccount_to_vehicle_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_disccount_to_vehicle_type`(
	IN tipo_vehiculo INT UNSIGNED, 
	IN descuento DECIMAL(3,1)
)
BEGIN
	UPDATE VEHICULOS SET VEHICULOS.descuento = descuento
	WHERE VEHICULOS.`codigo_tipo_vehiculo` = tipo_vehiculo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(
	IN id_usuario INT UNSIGNED, 
	IN direccion VARCHAR(255), 
	IN id_ciudad_residencia INT UNSIGNED, 
	IN celular VARCHAR(10), 
	IN correo_electronico VARCHAR(255),
	IN user_password_actual VARCHAR(255)
)
BEGIN 

	SET @success = 0; 

	/*Encriptar la user_password*/ 
	SET @hashed = SHA2(user_password_actual, 256); 
	
	/*Obtener la user_password actual*/
	SELECT usuarios.user_password INTO @saved_password
	FROM usuarios
	WHERE usuarios.id_usuario = id_usuario; 
	
	IF @hashed = @saved_password THEN
		UPDATE usuarios SET
			usuarios.direccion = direccion, 
			usuarios.id_ciudad_residencia = id_ciudad_residencia, 
			usuarios.celular = celular, 
			usuarios.`correo_electronico` = correo_electronico
		WHERE usuarios.id_usuario = id_usuario; 
		
		SET @success = 1; 
	END IF;

	SELECT @success;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_vehicle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_vehicle`(
	IN id_vehiculo INT UNSIGNED,
	IN matricula VARCHAR(6), 
	IN has_sunroof TINYINT(1) UNSIGNED, 
	IN codigo_tipo_motor INT UNSIGNED, 
	IN color VARCHAR(64), 
	IN disponible TINYINT(1) UNSIGNED, 
	IN valor_alquiler_semanal DECIMAL(12,2), 
	IN valor_alquiler_diario DECIMAL(12,2),
	IN descuento DECIMAL(3,1) 
)
BEGIN
UPDATE VEHICULOS SET
		VEHICULOS.`matricula` = matricula, 
		VEHICULOS.has_sunroof = has_sunroof, 
		VEHICULOS.`codigo_tipo_motor` = codigo_tipo_motor, 
		VEHICULOS.color = color, 
		VEHICULOS.disponible = disponible, 
		VEHICULOS.valor_alquiler_semanal = valor_alquiler_semanal, 
		VEHICULOS.valor_alquiler_diario = valor_alquiler_diario, 
		VEHICULOS.descuento = descuento
WHERE VEHICULOS.`id_vehiculo` = `id_vehiculo`; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_login`(
	IN correo_electronico VARCHAR(255), 
	IN user_password VARCHAR(255) 
)
BEGIN 

	SET @success = 0;
	SELECT COUNT(correo_electronico) 'exists' INTO @user_exists
	FROM usuarios
	WHERE usuarios.correo_electronico = correo_electronico; 
	
	/*Si el usuario existe verifica que la user_password sea correcta*/
	IF @user_exists = 1 THEN 
		
		/*Encripta la user_password para compararla con la que está en la base de datos*/ 
		SET @hashed = SHA2(user_password, 256);

		SELECT usuarios.user_password INTO @saved_password
		FROM usuarios
		WHERE usuarios.correo_electronico = correo_electronico; 
		
		IF @saved_password = @hashed THEN 
        
			-- Si la user_password es correcta, regresa algunos datos del usuario para la sesión
			SELECT id_usuario, CONCAT(nombres, ' ',apellidos) 'NAME', `correo_electronico` 'MAIL' 
            FROM USUARIOS
            WHERE USUARIOS.`correo_electronico` = correo_electronico;
            
		END IF; 
	
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `bills_pretty`
--

/*!50001 DROP VIEW IF EXISTS `bills_pretty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bills_pretty` AS select `f`.`id_factura` AS `id_factura`,concat(`u`.`nombres`,' ',`u`.`apellidos`) AS `Nombre cliente`,`a1`.`dias_mora` AS `dias_mora`,`f`.`totaL_pagar` AS `totaL_pagar`,`f`.`valor_pagado` AS `valor_pagado`,`f`.`was_paid` AS `was_paid` from (((`factura` `f` join `usuarios` `u`) join `alquileres` `a`) left join `alquileres` `a1` on((`a1`.`id_alquiler` = `f`.`id_alquiler`))) where ((`f`.`id_alquiler` = `a`.`id_alquiler`) and (`a`.`id_cliente` = `u`.`id_usuario`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `internal_users_summary_pretty`
--

/*!50001 DROP VIEW IF EXISTS `internal_users_summary_pretty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `internal_users_summary_pretty` AS select `usuarios`.`id_usuario` AS `id_usuario`,concat(`usuarios`.`nombres`,' ',`usuarios`.`apellidos`) AS `Nombre completo`,`usuarios`.`correo_electronico` AS `correo_electronico`,`c`.`ciudad` AS `ciudad`,`tu`.`tipo_usuario` AS `tipo_usuario` from (((`usuarios` join `tipo_usuario` `tu`) join `sucursales` `s`) join `ciudades` `c`) where ((`usuarios`.`codigo_tipo_usuario` = `tu`.`codigo_tipo_usuario`) and (`usuarios`.`codigo_sucursal` = `s`.`id_sucursal`) and (`s`.`id_ciudad` = `c`.`id_ciudad`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rental_data_history_pretty`
--

/*!50001 DROP VIEW IF EXISTS `rental_data_history_pretty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rental_data_history_pretty` AS select concat(`u1`.`nombres`,' ',`u1`.`apellidos`) AS `Nombre_cliente`,concat(`u2`.`nombres`,' ',`u2`.`apellidos`) AS `Nombre_vendedor`,`v`.`modelo` AS `modelo`,`v`.`matricula` AS `matricula`,`c1`.`ciudad` AS `Ciudad_alquiler`,`c2`.`ciudad` AS `Ciudad_entrega`,`a`.`dias` AS `dias`,`a`.`valor_cotizado` AS `valor_cotizado`,`a`.`fecha_salida` AS `fecha_salida`,`a`.`fecha_esperada_llegada` AS `fecha_esperada_llegada`,`a`.`fecha_llegada` AS `fecha_llegada` from (`vehículos` `v` join ((((((`alquileres` `a` left join `usuarios` `u1` on((`u1`.`id_usuario` = `a`.`id_cliente`))) left join `usuarios` `u2` on((`u2`.`id_usuario` = `a`.`id_empleado`))) left join `sucursales` `s1` on((`s1`.`id_sucursal` = `a`.`id_sucursal_alquiler`))) left join `ciudades` `c1` on((`c1`.`id_ciudad` = `s1`.`id_ciudad`))) left join `sucursales` `s2` on((`s2`.`id_sucursal` = `a`.`id_sucursal_entrega`))) left join `ciudades` `c2` on((`c2`.`id_ciudad` = `s2`.`id_ciudad`)))) where (`v`.`id_vehiculo` = `a`.`id_vehiculo`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `users_summary_pretty`
--

/*!50001 DROP VIEW IF EXISTS `users_summary_pretty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `users_summary_pretty` AS select `usuarios`.`id_usuario` AS `id_usuario`,concat(`usuarios`.`nombres`,' ',`usuarios`.`apellidos`) AS `Nombre completo`,`usuarios`.`correo_electronico` AS `correo_electronico`,`c`.`ciudad` AS `ciudad`,`tu`.`tipo_usuario` AS `tipo_usuario` from ((`usuarios` join `ciudades` `c`) join `tipo_usuario` `tu`) where ((`usuarios`.`id_ciudad_residencia` = `c`.`id_ciudad`) and (`usuarios`.`codigo_tipo_usuario` = `tu`.`codigo_tipo_usuario`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vehicles_information_pretty`
--

/*!50001 DROP VIEW IF EXISTS `vehicles_information_pretty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vehicles_information_pretty` AS select `v`.`id_vehiculo` AS `id_vehiculo`,`v`.`matricula` AS `matricula`,`tv`.`tipo_vehiculo` AS `tipo_vehiculo`,`v`.`modelo` AS `modelo`,`v`.`numero_puertas` AS `numero_puertas`,`v`.`capacidad` AS `capacidad`,`v`.`has_sunroof` AS `has_sunroof`,`tm`.`motor` AS `motor`,`v`.`color` AS `color`,`v`.`descuento` AS `descuento`,`v`.`valor_alquiler_semanal` AS `valor_alquiler_semanal`,`v`.`valor_alquiler_diario` AS `valor_alquiler_diario`,`v`.`disponible` AS `disponible` from ((`vehículos` `v` join `tipo_vehiculo` `tv`) join `tipo_motor` `tm`) where ((`v`.`codigo_tipo_vehiculo` = `tv`.`codigo_tipo_vehiculo`) and (`v`.`codigo_tipo_motor` = `tm`.`codigo_tipo_motor`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-05 11:24:06
