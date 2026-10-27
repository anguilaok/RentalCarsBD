# TP2 - Rental Cars
## Preguntas teoricas

### 1. ¿Por que la tabla ALQUILERES tiene dos claves foraneas hacia SUCURSALES? ¿Que tipo de relacion representan?

La tabla ALQUILERES tiene dos claves foraneas hacia SUCURSALES porque un alquiler puede comenzar en una sucursal y finalizar en otra. La clave `id_sucursal_retiro` identifica la sucursal donde el cliente retira el vehiculo, mientras que `id_sucursal_devolucion` identifica donde lo devuelve.

Cada clave foranea representa una relacion de muchos a uno desde ALQUILERES hacia SUCURSALES. Una sucursal puede estar asociada a muchos alquileres como lugar de retiro y tambien a muchos alquileres como lugar de devolucion.

### 2. ¿Que sucede si intentamos eliminar una categoria que tiene vehiculos asociados? Comparar RESTRICT, CASCADE y SET NULL. ¿Cual recomendarias?

Si intentamos eliminar una categoria que tiene vehiculos asociados, la operacion puede ser rechazada por la restriccion de clave foranea.

- **RESTRICT:** impide eliminar la categoria mientras existan vehiculos asociados.
- **CASCADE:** elimina automaticamente los vehiculos relacionados con esa categoria.
- **SET NULL:** establece en NULL la clave foranea de los vehiculos relacionados. Para utilizar esta opcion, la columna debe permitir valores NULL.

Recomendaria RESTRICT porque evita eliminar accidentalmente vehiculos que todavia pertenecen a una categoria. De esta manera se conserva la integridad de los datos.

### 3. ¿Por que se utiliza una tabla CATEGORIAS separada en lugar de guardar la categoria como texto en VEHICULOS?

Se utiliza una tabla CATEGORIAS separada para evitar repetir los nombres de las categorias en cada vehiculo. La tabla VEHICULOS guarda el identificador de la categoria mediante una clave foranea.

Esta organizacion reduce la duplicacion de datos, facilita las modificaciones y ayuda a mantener la integridad referencial. Por ejemplo, si cambia la descripcion de una categoria, se modifica una sola vez en CATEGORIAS.

### 4. ¿Que relacion existe entre SUCURSALES y EMPLEADOS?

Existe una relacion de uno a muchos. Una sucursal puede tener varios empleados, pero cada empleado pertenece a una sola sucursal.

Esta relacion se representa mediante la clave foranea `id_sucursal` de la tabla EMPLEADOS, que referencia la clave primaria `id` de SUCURSALES.

### 5. ¿Por que CHECK_ALQUILER utiliza un campo tipo con los valores salida y entrada en lugar de crear dos tablas separadas?

La tabla CHECK_ALQUILER utiliza el campo `tipo` para diferenciar los controles realizados al retirar y al devolver un vehiculo.

De esta manera, ambos registros comparten la misma estructura y se almacenan en una unica tabla. Esto evita duplicar tablas y permite relacionar cada control con su alquiler mediante `id_alquiler`. La restriccion CHECK limita el campo `tipo` a los valores `salida` y `entrada`.
