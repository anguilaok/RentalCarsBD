# TP2 - Rental Cars
## Descripcion del modelo de datos

### 1. Descripcion general

La base de datos RENTAL_CARS permite administrar la informacion de una empresa de alquiler de vehiculos. Almacena datos de clientes, empleados, sucursales, categorias, vehiculos, alquileres, reservas, pagos, seguros, multas, mantenimientos y controles de entrega y devolucion.

### 2. Entidades principales

- **CATEGORIAS:** almacena las categorias a las que pertenecen los vehiculos.
- **SUCURSALES:** registra el nombre, la direccion, la ciudad y el telefono de cada sucursal.
- **CLIENTES:** contiene los datos personales y de contacto de los clientes.
- **EMPLEADOS:** almacena los datos de los empleados, su cargo, salario, fecha de ingreso y sucursal.
- **VEHICULOS:** registra marca, modelo, anio, precio diario, estado, patente, kilometraje, categoria y sucursal.
- **ALQUILERES:** registra los alquileres, las fechas, el cliente, el vehiculo, el empleado, las sucursales de retiro y devolucion, el total y el estado.
- **RESERVAS:** almacena las reservas realizadas por los clientes.
- **PAGOS:** registra los pagos asociados a los alquileres.
- **SEGUROS:** almacena los datos de los seguros contratados para los alquileres.
- **MULTAS:** registra las multas, su motivo, monto y estado de pago.
- **MANTENIMIENTOS:** almacena los mantenimientos realizados a los vehiculos.
- **CHECK_ALQUILER:** registra los controles de salida y entrada de los vehiculos.
- **AUDITORIA_ALQUILERES:** registra los nuevos alquileres mediante un trigger, guardando sus identificadores, la fecha y la accion realizada.

### 3. Relaciones entre entidades

- Una categoria puede tener muchos vehiculos. Cada vehiculo pertenece a una categoria.
- Una sucursal puede tener muchos empleados. Cada empleado pertenece a una sucursal.
- Una sucursal puede tener muchos vehiculos. Cada vehiculo esta asignado a una sucursal.
- Un cliente puede tener muchos alquileres. Cada alquiler pertenece a un cliente.
- Un vehiculo puede aparecer en muchos alquileres a lo largo del tiempo. Cada alquiler corresponde a un vehiculo.
- Un empleado puede registrar muchos alquileres. Cada alquiler tiene un empleado asociado.
- Cada alquiler referencia una sucursal de retiro y una sucursal de devolucion.
- Un cliente puede realizar muchas reservas y cada reserva corresponde a un cliente y un vehiculo.
- Un alquiler puede tener pagos, seguros, multas y controles de entrada o salida asociados.

### 4. Requisitos funcionales

El sistema debe permitir:

1. Registrar y consultar clientes, empleados, sucursales, categorias y vehiculos.
2. Registrar alquileres y reservas relacionados con clientes y vehiculos.
3. Consultar los alquileres con informacion del cliente, vehiculo, empleado y sucursales.
4. Registrar pagos, seguros y multas asociados a los alquileres.
5. Registrar mantenimientos y controles de salida y entrada de vehiculos.
6. Consultar cantidades de vehiculos, alquileres e ingresos mediante consultas y vistas.
7. Registrar automaticamente una auditoria cuando se inserta un nuevo alquiler.
8. Cambiar el estado de un vehiculo a no disponible cuando se registra un alquiler activo.
9. Utilizar procedimientos almacenados para registrar alquileres y multas.
10. Administrar usuarios con diferentes permisos de acceso a la base de datos.

### 5. Requisitos no funcionales

- **Integridad:** utilizar claves primarias, claves foraneas y restricciones para mantener la consistencia de los datos.
- **Seguridad:** limitar las operaciones de cada usuario mediante permisos.
- **Organizacion:** separar la informacion en tablas relacionadas para reducir la duplicacion.
- **Mantenibilidad:** organizar las instrucciones SQL en archivos separados por funcion.
- **Trazabilidad:** registrar los nuevos alquileres en una tabla de auditoria.
- **Rendimiento:** utilizar indices en columnas que se consultan o relacionan frecuentemente.

### 6. Reglas de negocio

- Un alquiler debe estar asociado a un cliente, un vehiculo y un empleado existentes.
- La fecha de finalizacion debe ser posterior a la fecha de inicio.
- El precio diario de un vehiculo debe ser positivo.
- El monto de una multa debe ser positivo.
- Un vehiculo debe estar disponible para poder registrar un nuevo alquiler mediante el procedimiento almacenado.
- Cuando se registra un alquiler activo, el trigger cambia el estado del vehiculo a no disponible.
- El vendedor no puede eliminar alquileres, mientras que el administrador dispone de todos los privilegios sobre la base RENTAL_CARS.
