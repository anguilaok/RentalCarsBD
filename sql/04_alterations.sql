
USE RENTAL_CARS;

-- Validar que el precio diario no sea negativo
ALTER TABLE VEHICULOS
ADD CONSTRAINT chk_vehiculos_precio
CHECK (precio_dia > 0);

-- Validar que el salario no sea negativo
ALTER TABLE EMPLEADOS
ADD CONSTRAINT chk_empleados_salario
CHECK (salario >= 0);

-- Validar que la fecha final sea posterior a la inicial
ALTER TABLE ALQUILERES
ADD CONSTRAINT chk_alquileres_fechas
CHECK (fecha_fin > fecha_inicio);

-- Validar que el monto de una multa sea positivo
ALTER TABLE MULTAS
ADD CONSTRAINT chk_multas_monto
CHECK (monto > 0);
