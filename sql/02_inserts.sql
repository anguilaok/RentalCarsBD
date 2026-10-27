
USE RENTAL_CARS;

-- 1. CATEGORIAS
INSERT INTO CATEGORIAS (nombre, descripcion) VALUES
('Economico', 'Vehiculos economicos'),
('SUV', 'Vehiculos utilitarios deportivos'),
('Sedan', 'Vehiculos sedan'),
('Pickup', 'Vehiculos pickup');

-- 2. SUCURSALES
INSERT INTO SUCURSALES (nombre, direccion, ciudad, telefono) VALUES
('Centro', 'Av. San Martin 100', 'San Juan', '2644001001'),
('Norte', 'Av. Libertador 500', 'San Juan', '2644001002'),
('Cordoba', 'Av. Colon 200', 'Cordoba', '3514001003');

-- 3. CLIENTES
INSERT INTO CLIENTES (nombre, email, telefono, ciudad, fecha_registro, licencia_conducir) VALUES
('Lucas Perez', 'lucas@example.com', '2645001001', 'San Juan', '2026-09-10', 'LIC1001'),
('Maria Gomez', 'maria@example.com', '2645001002', 'San Juan', '2026-09-15', 'LIC1002'),
('Juan Torres', 'juan@example.com', '3515001003', 'Cordoba', '2026-08-20', 'LIC1003'),
('Laura Diaz', 'laura@example.com', '2645001004', 'Mendoza', '2026-10-05', 'LIC1004'),
('Pedro Ruiz', 'pedro@example.com', '3515001005', 'Cordoba', '2025-12-01', 'LIC1005');

-- 4. EMPLEADOS
INSERT INTO EMPLEADOS (nombre, cargo, id_sucursal, fecha_ingreso, salario) VALUES
('Luis Fernandez', 'Vendedor', 1, '2020-05-10', 180000.00),
('Lucia Morales', 'Vendedora', 2, '2019-03-15', 175000.00),
('Carlos Romero', 'Gerente', 1, '2018-01-20', 250000.00),
('Laura Sanchez', 'Administrativa', 3, '2022-06-01', 190000.00);

-- 5. VEHICULOS
INSERT INTO VEHICULOS
(marca, modelo, anio, precio_dia, estado, id_categoria, id_sucursal, patente, km_actual)
VALUES
('Fiat', 'Cronos', 2020, 35000.00, 1, 3, 1, 'AA100AA', 45000),
('Toyota', 'Corolla', 2023, 50000.00, 1, 3, 1, 'AB200AB', 18000),
('Renault', 'Kwid', 2019, 25000.00, 1, 1, 2, 'AC300AC', 60000),
('Ford', 'EcoSport', 2022, 60000.00, 1, 2, 2, 'AD400AD', 25000),
('Volkswagen', 'Amarok', 2021, 75000.00, 1, 4, 3, 'AE500AE', 35000),
('Chevrolet', 'Onix', 2018, 22000.00, 1, 1, 3, 'AF600AF', 80000),
('Honda', 'HR-V', 2024, 85000.00, 1, 2, 1, 'AG700AG', 10000),
('Nissan', 'Versa', 2025, 55000.00, 1, 3, 2, 'AH800AH', 5000);

-- 6. ALQUILERES
INSERT INTO ALQUILERES
(id_cliente, id_vehiculo, fecha_inicio, fecha_fin, total, id_empleado,
 id_sucursal_retiro, id_sucursal_devolucion, estado)
VALUES
(1, 1, '2024-10-05', '2024-10-10', 175000.00, 1, 1, 1, 'finalizado'),
(2, 2, '2024-10-12', '2024-10-15', 150000.00, 2, 1, 2, 'activo'),
(1, 3, '2026-09-20', '2026-09-23', 75000.00, 1, 2, 2, 'finalizado'),
(3, 4, '2026-09-25', '2026-09-28', 180000.00, 3, 2, 3, 'finalizado'),
(4, 5, '2026-10-01', '2026-10-04', 225000.00, 4, 3, 3, 'activo');

-- 7. RESERVAS
INSERT INTO RESERVAS
(id_cliente, id_vehiculo, fecha_reserva, fecha_inicio, fecha_fin, estado)
VALUES
(5, 6, '2026-09-20', '2026-11-01', '2026-11-04', 'confirmada'),
(2, 7, '2026-09-25', '2026-11-10', '2026-11-12', 'confirmada');

-- 8. PAGOS
INSERT INTO PAGOS (id_alquiler, fecha_pago, monto) VALUES
(1, '2024-10-10', 175000.00),
(2, '2024-10-15', 150000.00),
(3, '2026-09-23', 75000.00),
(4, '2026-09-28', 180000.00);

-- 9. SEGUROS
INSERT INTO SEGUROS (id_alquiler, compania, numero_poliza, cobertura, costo) VALUES
(1, 'Seguro SA', 'POL1001', 'Cobertura total', 15000.00),
(2, 'Proteccion SA', 'POL1002', 'Responsabilidad civil', 10000.00);

-- 10. MULTAS
INSERT INTO MULTAS (id_alquiler, fecha, motivo, monto, pagada) VALUES
(1, '2024-10-09', 'Exceso de velocidad', 25000.00, 1),
(3, '2026-09-22', 'Estacionamiento indebido', 12000.00, 1),
(4, '2026-09-27', 'Devolucion tardia', 18000.00, 0);

-- 11. MANTENIMIENTOS
INSERT INTO MANTENIMIENTOS (id_vehiculo, fecha, tipo, costo, observaciones) VALUES
(1, '2026-01-10', 'Service', 80000.00, 'Cambio de aceite'),
(2, '2026-03-15', 'Frenos', 120000.00, 'Cambio de pastillas'),
(4, '2026-05-20', 'Neumaticos', 200000.00, 'Cambio de neumaticos');

-- 12. CHECK_ALQUILER
INSERT INTO CHECK_ALQUILER
(id_alquiler, tipo, fecha, km, nivel_combustible)
VALUES
(1, 'salida', '2024-10-05 09:00:00', 45000, 100),
(1, 'entrada', '2024-10-10 17:00:00', 45500, 75),
(2, 'salida', '2024-10-12 10:00:00', 18000, 100);
