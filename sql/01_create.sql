
CREATE DATABASE IF NOT EXISTS RENTAL_CARS
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE RENTAL_CARS;

CREATE TABLE CATEGORIAS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120)
);

CREATE TABLE SUCURSALES (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(120) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(30)
);

CREATE TABLE CLIENTES (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    telefono VARCHAR(50),
    ciudad VARCHAR(50) NOT NULL,
    fecha_registro DATE NOT NULL,
    licencia_conducir VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE EMPLEADOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    id_sucursal INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES SUCURSALES(id)
);

CREATE TABLE VEHICULOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL,
    precio_dia DECIMAL(10,2) NOT NULL,
    estado TINYINT(1) NOT NULL DEFAULT 1,
    id_categoria INT NOT NULL,
    id_sucursal INT NOT NULL,
    patente VARCHAR(15) UNIQUE NOT NULL,
    km_actual INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIAS(id),
    FOREIGN KEY (id_sucursal) REFERENCES SUCURSALES(id)
);

CREATE TABLE ALQUILERES (
    id_alquiler INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    id_empleado INT NOT NULL,
    id_sucursal_retiro INT NOT NULL,
    id_sucursal_devolucion INT NOT NULL,
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULOS(id),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADOS(id),
    FOREIGN KEY (id_sucursal_retiro) REFERENCES SUCURSALES(id),
    FOREIGN KEY (id_sucursal_devolucion) REFERENCES SUCURSALES(id)
);

CREATE TABLE RESERVAS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULOS(id)
);

CREATE TABLE PAGOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_alquiler) REFERENCES ALQUILERES(id_alquiler)
);

CREATE TABLE SEGUROS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT NOT NULL,
    compania VARCHAR(80) NOT NULL,
    numero_poliza VARCHAR(50) NOT NULL,
    cobertura VARCHAR(100) NOT NULL,
    costo DECIMAL(9,2) NOT NULL,
    FOREIGN KEY (id_alquiler) REFERENCES ALQUILERES(id_alquiler)
);

CREATE TABLE MULTAS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT NOT NULL,
    fecha DATE NOT NULL,
    motivo VARCHAR(120) NOT NULL,
    monto DECIMAL(9,2) NOT NULL,
    pagada TINYINT(1) NOT NULL DEFAULT 0,
    FOREIGN KEY (id_alquiler) REFERENCES ALQUILERES(id_alquiler)
);

CREATE TABLE MANTENIMIENTOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    fecha DATE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    costo DECIMAL(9,2) NOT NULL,
    observaciones VARCHAR(200),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULOS(id)
);

CREATE TABLE CHECK_ALQUILER (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    fecha DATETIME NOT NULL,
    km INT NOT NULL,
    nivel_combustible INT NOT NULL,
    FOREIGN KEY (id_alquiler) REFERENCES ALQUILERES(id_alquiler),
    CHECK (tipo IN ('salida', 'entrada'))
);
