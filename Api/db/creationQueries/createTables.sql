DROP DATABASE IF EXISTS qr_payments_db;
CREATE DATABASE qr_payments_db;

use qr_payments_db;

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  id INT NOT NULL AUTO_INCREMENT,
  nombre_usuario VARCHAR(20) NOT NULL UNIQUE,
  contrasena CHAR(60) NOT NULL,
  correo VARCHAR(255) NOT NULL,
  rol TINYINT(2) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS cuentas;
CREATE TABLE cuentas (
  id INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  cedula_tipo INT(2) NOT NULL,              -- Acorde a resolucion
  cedula_numero BIGINT(12) NOT NULL,        -- Acorde a resolucion
  nombre VARCHAR(100) NOT NULL,             -- Acorde a resolucion
  tel_codigo_pais INT(3) NOT NULL,          -- Acorde a resolucion
  tel_numero INT(20) NOT NULL,              -- Acorde a resolucion
  correo VARCHAR(160) NOT NULL,             -- Acorde a resolucion
  ubicacion_codigo INT(7) NOT NULL,         -- Acorde a resolucion
  ubicacion_senas VARCHAR(250) NOT NULL,    -- Acorde a resolucion
  PRIMARY KEY (id),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id)
) ENGINE=InnoDB;

