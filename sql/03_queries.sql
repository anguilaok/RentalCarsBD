
USE RENTAL_CARS;

-- 1. Vehiculos ordenados del mas antiguo al mas nuevo
SELECT marca, modelo, anio
FROM VEHICULOS
ORDER BY anio ASC;

-- 2. Clientes registrados el mes anterior
SELECT nombre, email, ciudad
FROM CLIENTES
WHERE fecha_registro >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01')
  AND fecha_registro < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

-- 3. Vehiculos de la categoria con id = 2
SELECT marca, modelo, precio_dia
FROM VEHICULOS
WHERE id_categoria = 2;

-- 4. Empleados cuyo nombre comienza con L
SELECT *
FROM EMPLEADOS
WHERE nombre LIKE 'L%';

-- 5. Empleados con salario distinto de 180000
SELECT nombre, cargo
FROM EMPLEADOS
WHERE salario <> 180000.00;

-- 6. Vehiculo y nombre de su categoria
SELECT v.marca, v.modelo, c.nombre AS categoria
FROM VEHICULOS v
INNER JOIN CATEGORIAS c ON v.id_categoria = c.id;

-- 7. Fecha, cliente, vehiculo y empleado del alquiler
SELECT
    a.fecha_inicio,
    cl.nombre AS cliente,
    CONCAT(v.marca, ' ', v.modelo) AS vehiculo,
    e.nombre AS empleado
FROM ALQUILERES a
INNER JOIN CLIENTES cl ON a.id_cliente = cl.id
INNER JOIN VEHICULOS v ON a.id_vehiculo = v.id
INNER JOIN EMPLEADOS e ON a.id_empleado = e.id;

-- 8. Cliente, ciudad y fecha de registro
SELECT nombre, ciudad, fecha_registro
FROM CLIENTES;

-- 9. Vehiculo, sucursal y ciudad
SELECT v.marca, v.modelo, s.nombre AS sucursal, s.ciudad
FROM VEHICULOS v
INNER JOIN SUCURSALES s ON v.id_sucursal = s.id;

-- 10. Alquiler con sucursal de retiro y devolucion
SELECT
    a.id_alquiler,
    CONCAT(v.marca, ' ', v.modelo) AS vehiculo,
    sr.nombre AS sucursal_retiro,
    sd.nombre AS sucursal_devolucion
FROM ALQUILERES a
INNER JOIN VEHICULOS v ON a.id_vehiculo = v.id
INNER JOIN SUCURSALES sr ON a.id_sucursal_retiro = sr.id
INNER JOIN SUCURSALES sd ON a.id_sucursal_devolucion = sd.id;

-- 11. Cantidad de vehiculos por categoria
SELECT c.nombre AS categoria, COUNT(v.id) AS cantidad_vehiculos
FROM CATEGORIAS c
LEFT JOIN VEHICULOS v ON c.id = v.id_categoria
GROUP BY c.id, c.nombre;

-- 12. Precio promedio por dia por categoria
SELECT c.nombre AS categoria, AVG(v.precio_dia) AS precio_promedio
FROM CATEGORIAS c
LEFT JOIN VEHICULOS v ON c.id = v.id_categoria
GROUP BY c.id, c.nombre;

-- 13. Cantidad de alquileres gestionados por empleado
SELECT e.nombre, COUNT(a.id_alquiler) AS total_alquileres
FROM EMPLEADOS e
LEFT JOIN ALQUILERES a ON e.id = a.id_empleado
GROUP BY e.id, e.nombre
ORDER BY total_alquileres DESC;

-- 14. Clientes con mas de un alquiler
SELECT cl.id, cl.nombre, COUNT(a.id_alquiler) AS total_alquileres
FROM CLIENTES cl
INNER JOIN ALQUILERES a ON cl.id = a.id_cliente
GROUP BY cl.id, cl.nombre
HAVING COUNT(a.id_alquiler) > 1;

-- 15. Cantidad de sucursales por ciudad
SELECT ciudad, COUNT(*) AS cantidad_sucursales
FROM SUCURSALES
GROUP BY ciudad;

-- 16. Vehiculo mas antiguo
SELECT marca, modelo, anio
FROM VEHICULOS
WHERE anio = (SELECT MIN(anio) FROM VEHICULOS);

-- 17. Vehiculos que nunca fueron alquilados
SELECT v.*
FROM VEHICULOS v
LEFT JOIN ALQUILERES a ON v.id = a.id_vehiculo
WHERE a.id_alquiler IS NULL;

-- 18. Alquileres activos que comenzaron en octubre de 2024
SELECT *
FROM ALQUILERES
WHERE estado = 'activo'
  AND fecha_inicio >= '2024-10-01'
  AND fecha_inicio < '2024-11-01';

-- 19. Los tres vehiculos con mayor precio por dia
SELECT marca, modelo, precio_dia
FROM VEHICULOS
ORDER BY precio_dia DESC
LIMIT 3;

-- 20. Cantidad y monto total de multas pagadas
SELECT
    COUNT(*) AS cantidad_multas_pagadas,
    COALESCE(SUM(monto), 0) AS total_recaudado
FROM MULTAS
WHERE pagada = 1;
