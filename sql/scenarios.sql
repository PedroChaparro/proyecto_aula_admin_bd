/* ############## */
/*Escenarios para probar los procedures*/

/*
ESCENARIO 1 (SIN RECARGO) 
La persona con id_usuario = 1 (Violet Nicolas) alquila el vehíhculo con id = 1 teniendo en cuenta:
- El alquiler se realiza el día 10-enero-2022
- El vehículo se alquila en la sucursal de Bucaramanga (1) y se entrega en la sucursal de Bogotá (3)
- El vehículo se alquila durante 15 días
- La venta se lleva a cabo por el trabajador con id_usuario = 57 (Brett Abshire)
- La fecha estimada de salida es el 10-enero-2022
- La fecha estimada de llegada es el 15-enero-2022
- El vehículo es recogido el 15-enero-2022
- El vehículo es entregado el 30-enero-2022 (Por tanto no se debería generar recargo). 

El vehículo con id = 1 tiene un valor de alquiler semanal de 460.000 y alquiler diario de 55.857, por tanto,
la persona debería pagar 460.000x2 + 55857 = 975.857
*/

/*Realizacion de la renta*/
SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-10');

/* 
	arg id_cliente
	arg id_empleado 
	arg id_vehículo 
	arg id_sucursal_alquiler
	arg id_sucursal_entrega 
	arg fecha_salida
	arg fecha_esperada_llegada 
	arg dias
*/ CALL register_vehicle_rental(
	1, 
	57, 
	1, 
	1, 
	3, 
	(
SELECT NOW()),
	'2022-01-15', 
	15
); 


/*Registrar la llegada del vehículo a la sucursal destino*/ SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-15');
/* 
arg id_orden
*/ CALL register_vehicle_arrival(1); 

/*Registrar la recogida del vehículo*/ SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-15 8:00');
/* 
arg id_orden
*/ CALL register_vehicle_pickup(1); 

/*Registrar la devolución del vehículo al finalizar los 30 días*/ SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-30 8:00');
/* 
arg id_orden
*/ CALL register_vehicle_return(1); 

/*Generar la factura*/
/* 
arg id_orden
*/ CALL create_bill(1); 

/*Mostrar la factura*/
/* 
arg id_factura
*/ CALL consult_bill(1); 

/* 
arg id_factura
*/ CALL register_payment(1); 

/*
ESCENARIO 2 (CON RECARGO) 
La persona con id_usuario = 2 (Olivia Heathcote) alquila el vehíhculo con id = 23 teniendo en cuenta:
- El alquiler se realiza el día 05-febrero-2022
- El vehículo se alquila en la sucursal de Medellín (2) y se entrega en la sucursal de cali (4)
- El vehículo se alquila durante 30 días
- La venta se lleva a cabo por el trabajador con id_usuario = 59 (Jennifer Morar)
- La fecha estimada de salida es el 05-febrero-2022
- La fecha estimada de llegada es el 15-febrero-2022
- El vehículo es recogido el 16-febrero-2022
- El vehículo es entregado el 25-mayo-2022 (Por tanto sí se debería generar recargo). 

El vehículo con id = 23 tiene un valor de alquiler semanal de 695.000 y alquiler diario de 84.392, por tanto,
la persona debería pagar 695.000x4 + 84.392x2 = 2.948.784 
A lo anterior se suman los 7 días de retraso 84.392x7 = 590744 + (84.392x7)*0.08 = 638003.52
Por tanto, el valor final a pagar es de: $3.586.787.52
*/
SELECT *
FROM VEHÍCULOS; 

/*Realizacion de la renta*/ SET TIMESTAMP = UNIX_TIMESTAMP('2022-01-10');

/* 
	arg id_cliente
	arg id_empleado 
	arg id_vehículo 
	arg id_sucursal_alquiler
	arg id_sucursal_entrega 
	arg fecha_salida
	arg fecha_esperada_llegada 
	arg dias
*/ CALL register_vehicle_rental(
	2, 
	59, 
	23, 
	2, 
	4, 
	(
SELECT NOW()),
	'2022-02-15', 
	30
); 

/*Registrar la llegada del vehículo a la sucursal destino*/ SET TIMESTAMP = UNIX_TIMESTAMP('2022-02-15 8:00');
/* 
arg id_orden
*/ CALL register_vehicle_arrival(2); 

/*Registrar la recogida del vehículo*/ SET TIMESTAMP = UNIX_TIMESTAMP('2022-02-16 8:00');
/* 
arg id_orden
*/ CALL register_vehicle_pickup(2); 

/*Registrar la devolución del vehículo al finalizar los 30 días*/ SET TIMESTAMP = UNIX_TIMESTAMP('2022-03-25 8:00');
/* 
arg id_orden
*/ CALL register_vehicle_return(2); 

/*Generar la factura*/
/* 
arg id_orden
*/ CALL create_bill(2); 

/*Mostrar la factura*/
/* 
arg id_factura
*/ CALL consult_bill(2);

/*Registrar el pago*/
/* 
arg id_factura
*/ CALL register_payment(2); 