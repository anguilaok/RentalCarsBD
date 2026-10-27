
USE RENTAL_CARS;

DROP PROCEDURE IF EXISTS SP_REGISTRAR_ALQUILER;
DROP PROCEDURE IF EXISTS SP_CALCULAR_MULTA;

DELIMITER $$

-- Procedimiento para registrar un alquiler
CREATE PROCEDURE SP_REGISTRAR_ALQUILER(
    IN p_id_cliente INT,
    IN p_id_vehiculo INT,
    IN p_id_empleado INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    DECLARE v_estado TINYINT;
    DECLARE v_precio_dia DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_id_sucursal INT;

    -- Verificar que el cliente exista
    IF NOT EXISTS (
        SELECT 1 FROM CLIENTES WHERE id = p_id_cliente
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no existe';
    END IF;

    -- Verificar que el empleado exista
    IF NOT EXISTS (
        SELECT 1 FROM EMPLEADOS WHERE id = p_id_empleado
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El empleado no existe';
    END IF;

    -- Verificar que las fechas sean validas
    IF p_fecha_inicio IS NULL
       OR p_fecha_fin IS NULL
       OR p_fecha_fin <= p_fecha_inicio THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Las fechas del alquiler no son validas';
    END IF;

    -- Obtener el estado, el precio y la sucursal del vehiculo
    SELECT estado, precio_dia, id_sucursal
    INTO v_estado, v_precio_dia, v_id_sucursal
    FROM VEHICULOS
    WHERE id = p_id_vehiculo;

    -- Verificar disponibilidad
    IF v_estado IS NULL OR v_estado = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El vehiculo no esta disponible';
    END IF;

    -- Calcular el total por cantidad de dias
    SET v_total = DATEDIFF(p_fecha_fin, p_fecha_inicio) * v_precio_dia;

    -- Registrar el alquiler
    INSERT INTO ALQUILERES (
        id_cliente,
        id_vehiculo,
        fecha_inicio,
        fecha_fin,
        total,
        id_empleado,
        id_sucursal_retiro,
        id_sucursal_devolucion,
        estado
    )
    VALUES (
        p_id_cliente,
        p_id_vehiculo,
        p_fecha_inicio,
        p_fecha_fin,
        v_total,
        p_id_empleado,
        v_id_sucursal,
        v_id_sucursal,
        'activo'
    );

    SELECT 'Alquiler registrado correctamente' AS mensaje,
           LAST_INSERT_ID() AS id_alquiler,
           v_total AS total;
END$$

-- Procedimiento para registrar una multa
CREATE PROCEDURE SP_CALCULAR_MULTA(
    IN p_id_alquiler INT,
    IN p_motivo VARCHAR(120),
    IN p_monto DECIMAL(9,2)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM ALQUILERES
        WHERE id_alquiler = p_id_alquiler
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El alquiler no existe';
    END IF;

    IF p_motivo IS NULL OR TRIM(p_motivo) = ''
       OR p_monto IS NULL OR p_monto <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El motivo o el monto de la multa no son validos';
    END IF;

    INSERT INTO MULTAS (
        id_alquiler,
        fecha,
        motivo,
        monto,
        pagada
    )
    VALUES (
        p_id_alquiler,
        CURRENT_DATE,
        p_motivo,
        p_monto,
        FALSE
    );

    SELECT 'Multa registrada correctamente' AS mensaje,
           LAST_INSERT_ID() AS id_multa;
END$$

DELIMITER ;
