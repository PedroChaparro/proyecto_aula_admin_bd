# PROYECTO DE AULA ADMINISTRACIÓN DE BASES DE DATOS

Repositorio para el manejo de control de versiones del proyecto de aula de la asignatura administración de bases de datos 2022-01. 

## Requerimientos mínimos

- [x] Registro de 5 sucursales.
- [x] Alquiler vehículo en una sucursal y entregarlo en otra.  
- [x] Descuentos a diferentes tipos de vehículos.
- [x] Diferentes tipos de vehículos (Sedan, compacto, camioneta, deportivo).
- [x] Los valores del alquiler se cobran por dias y/o semanas.
- [x] Se cobra un 8% de interes por entregas tardías.
- [x] Registro e inicio de sesión de usuarios.
- [x] Consulta de disponibilidad de vehiculos a partir de tipo de vehículo, rango de precios y fechas.
- [x] Consulta de historial de alquileres. 
- [x] Cuentas con permisos gestionados para los aplicativos de software.

## Respuestas comúnes

### Módulo de usuarios

- En el registro de usuarios, se responderá con un estado `201` si el usuaruio fue creado con éxito, o un estado `-400`en caso de que el documento o correo electrónico ya existan en la base de datos. 

`{"code": -400, "error": "La entrada para el documento o el correo es duplicada"}`

- En la actualización de usuaruios, se responderá con un estado `200` si el usuario fue actualizado con éxit o un estado `-401` si la contraseña actual del usuario no es correcta. 

`{"code": -401, "error": "No está autorizado para realizar la modificación"}`

- En el Login, se responderá con un estado `200` si todo es correcto, además de regresar datos para la sesión del usuario: 

`{"id": 44, "code": 200, "mail": "Maria.Feil@gmail.com", "error": null, "firstName": "Maria", "lastNames": "Feil"}`

Si la contraseña es incorrecta, se responderá con un estado `-401`. 

Si el correo ingresado no existe, se responderá con un estado `-404`.

### Módulo de vehículos

- En el registro de un nuevo vehículo, se responderá con un estado `201` si se registró correctamente o con un estado `-400` en caso de que la matrícula del vehículo sea duplicada. 
- En la actualización de un vehículo, se regresa un código `200` si la actualización fue satisfactoria, o un código `-400` si el vehículo especificado no fue encontrado. 

### Módulo de lógica de negocio

- Se responde con un estado `201` si el alquiler se pudo realizar satisfactoriamente, un código `-400` Si el vehículo no se encuentra disponible y no se pudo realizar el alquiler o un código `-500` si ocurrió un error manejado por el handler de `SQLEXCEPTION`.

