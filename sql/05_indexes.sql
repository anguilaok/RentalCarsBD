
USE RENTAL_CARS;

-- Buscar vehiculos por marca y modelo
CREATE INDEX idx_vehiculos_marca_modelo
ON VEHICULOS (marca, modelo);

-- Buscar alquileres por cliente
CREATE INDEX idx_alquileres_cliente
ON ALQUILERES (id_cliente);

-- Buscar alquileres por vehiculo
CREATE INDEX idx_alquileres_vehiculo
ON ALQUILERES (id_vehiculo);

-- Buscar alquileres por fecha de inicio
CREATE INDEX idx_alquileres_fecha_inicio
ON ALQUILERES (fecha_inicio);

-- Buscar multas por estado de pago
CREATE INDEX idx_multas_pagada
ON MULTAS (pagada);

-- Buscar pagos por fecha
CREATE INDEX idx_pagos_fecha
ON PAGOS (fecha_pago);
