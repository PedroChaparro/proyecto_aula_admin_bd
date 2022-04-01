/* ############## */
/*Escenarios para probar los procedures*/

/*
ESCENARIO 1
La persona con id_usuario = 1 (Violet Nicolas) alquila el vehíhculo con id = 1 teniendo en cuenta:
- El alquiler se realiza el día 10-enero-2022
- El vehículo se alquila en la sucursal de Bucaramanga (1) y se entrega en la sucursal de Bogotá (3)
- El vehículo se alquila durante 15 días
- La venta se lleva a cabo por el trabajador con id_usuario = 58 (Brett Abshire)
- La fecha estimada de salida es el 10-enero-2022
- La fecha estimada de llegada es el 15-enero-2022
- El vehículo es recogido el 15-enero-2022
- El vehículo es entregado el 30-enero-2022 (Por tanto no se debería generar recargo). 
*/

/*Realizacion de la renta*/
SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-10');

CALL register_vehicle_rental(
	1, 
	58, 
	1, 
	1, 
	3, 
	(SELECT NOW()),
	'2022-01-15', 
	15
); 


/*Registrar la llegada del vehículo a la sucursal destino*/
SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-15');
CALL register_vehicle_arrival(2); 

/*Registrar la recogida del vehículo*/
SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-15 8:00');
CALL register_vehicle_pickup(2); 

/*Registrar la devolución del vehículo al finalizar los 30 días*/
SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-30 8:00');
CALL register_vehicle_return(2); 

/*Generar la factura*/
CALL create_bill(2); 

/*Mostrar la factura*/
CALL consult_bill(2); 

/*Registrar el pago*/
CALL register_payment(1); 


