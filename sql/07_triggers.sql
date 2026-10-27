
USE RENTAL_CARS;

-- Tabla de auditoria de alquileres
CREATE TABLE IF NOT EXISTS AUDITORIA_ALQUILERES (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT NOT NULL,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(50) NOT NULL
);

DELIMITER $$

-- Trigger 1: registrar cada nuevo alquiler en la auditoria
CREATE TRIGGER TR_AUDITAR_ALQUILER
AFTER INSERT ON ALQUILERES
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_ALQUILERES (
        id_alquiler,
        id_cliente,
        id_vehiculo,
        fecha_registro,
        accion
    )
    VALUES (
        NEW.id_alquiler,
        NEW.id_cliente,
        NEW.id_vehiculo,
        CURRENT_TIMESTAMP,
        'NUEVO ALQUILER'
    );
END$$

-- Trigger 2: marcar el vehiculo como no disponible
CREATE TRIGGER TR_ACTUALIZAR_ESTADO_VEHICULO
AFTER INSERT ON ALQUILERES
FOR EACH ROW
BEGIN
    IF NEW.estado = 'activo' THEN
        UPDATE VEHICULOS
        SET estado = FALSE
        WHERE id = NEW.id_vehiculo;
    END IF;
END$$

DELIMITER ;
