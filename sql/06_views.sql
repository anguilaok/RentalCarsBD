
USE RENTAL_CARS;

-- 1. Detalle de alquileres
CREATE OR REPLACE VIEW VW_ALQUILERES_DETALLE AS
SELECT
    a.id_alquiler,
    a.fecha_inicio,
    a.fecha_fin,
    cl.nombre AS cliente,
    CONCAT(v.marca, ' ', v.modelo) AS vehiculo,
    e.nombre AS empleado,
    sr.nombre AS sucursal_retiro,
    sd.nombre AS sucursal_devolucion,
    a.total,
    a.estado
FROM ALQUILERES a
INNER JOIN CLIENTES cl ON a.id_cliente = cl.id
INNER JOIN VEHICULOS v ON a.id_vehiculo = v.id
INNER JOIN EMPLEADOS e ON a.id_empleado = e.id
INNER JOIN SUCURSALES sr ON a.id_sucursal_retiro = sr.id
INNER JOIN SUCURSALES sd ON a.id_sucursal_devolucion = sd.id;

-- 2. Cantidad de vehiculos por sucursal
CREATE OR REPLACE VIEW VW_VEHICULOS_POR_SUCURSAL AS
SELECT
    s.id,
    s.nombre AS sucursal,
    s.ciudad,
    COUNT(v.id) AS cantidad_vehiculos
FROM SUCURSALES s
LEFT JOIN VEHICULOS v ON s.id = v.id_sucursal
GROUP BY s.id, s.nombre, s.ciudad;

-- 3. Ingresos por categoria para alquileres finalizados
CREATE OR REPLACE VIEW VW_INGRESOS_POR_CATEGORIA AS
SELECT
    c.nombre AS categoria,
    COUNT(a.id_alquiler) AS cantidad_alquileres,
    COALESCE(SUM(a.total), 0) AS monto_total
FROM CATEGORIAS c
LEFT JOIN VEHICULOS v ON c.id = v.id_categoria
LEFT JOIN ALQUILERES a
    ON v.id = a.id_vehiculo
    AND a.estado = 'finalizado'
GROUP BY c.id, c.nombre;
