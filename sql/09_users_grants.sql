
USE RENTAL_CARS;

-- Crear los usuarios
CREATE USER IF NOT EXISTS 'vendedor_user'@'localhost'
IDENTIFIED BY 'Vendedor2026!';

CREATE USER IF NOT EXISTS 'admin_user'@'localhost'
IDENTIFIED BY 'Admin2026!';

-- Permisos de lectura para el vendedor
GRANT SELECT ON RENTAL_CARS.VEHICULOS
TO 'vendedor_user'@'localhost';

GRANT SELECT ON RENTAL_CARS.CATEGORIAS
TO 'vendedor_user'@'localhost';

GRANT SELECT ON RENTAL_CARS.SUCURSALES
TO 'vendedor_user'@'localhost';

-- Permisos de gestion de alquileres y pagos
GRANT SELECT, INSERT, UPDATE, DELETE
ON RENTAL_CARS.ALQUILERES
TO 'vendedor_user'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON RENTAL_CARS.PAGOS
TO 'vendedor_user'@'localhost';

-- Permisos completos para el administrador
GRANT ALL PRIVILEGES ON RENTAL_CARS.*
TO 'admin_user'@'localhost';

-- Revocar el permiso de eliminar alquileres
REVOKE DELETE ON RENTAL_CARS.ALQUILERES
FROM 'vendedor_user'@'localhost';
