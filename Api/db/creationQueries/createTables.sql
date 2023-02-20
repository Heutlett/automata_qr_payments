DROP DATABASE IF EXISTS qr_payments_db;
CREATE DATABASE qr_payments_db;

use qr_payments_db;

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  id INT NOT NULL AUTO_INCREMENT,
  nombre_usuario VARCHAR(20) NOT NULL UNIQUE,
  contrasena CHAR(60) NOT NULL,
  correo VARCHAR(160) NOT NULL,
  rol TINYINT(2) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS cuentas;
CREATE TABLE cuentas (
  id INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  cedula_tipo VARCHAR(2) NOT NULL,          -- Acorde a resolucion 4.3
  cedula_numero VARCHAR(12) NOT NULL,       -- Acorde a resolucion 4.3
  id_extranjero VARCHAR(20) NOT NULL,       -- Acorde a resolucion 4.3
  nombre VARCHAR(100) NOT NULL,             -- Acorde a resolucion 4.3
  nombre_comercial VARCHAR(80) NOT NULL,    -- Acorde a resolucion 4.3
  tel_codigo_pais VARCHAR(3) NOT NULL,      -- Acorde a resolucion 4.3
  tel_numero VARCHAR(20) NOT NULL,          -- Acorde a resolucion 4.3
  fax_codigo_pais VARCHAR(3) NOT NULL,      -- Acorde a resolucion 4.3
  fax_numero VARCHAR(20) NOT NULL,          -- Acorde a resolucion 4.3
  correo VARCHAR(160) NOT NULL,             -- Acorde a resolucion 4.3
  ubicacion_codigo VARCHAR(7) NOT NULL,     -- Acorde a resolucion 4.3
  ubicacion_senas VARCHAR(250) NOT NULL,    -- Acorde a resolucion 4.3
  senas_extranjero VARCHAR(300) NOT NULL,   -- Acorde a resolucion 4.3
  inscrito BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS actividades_comerciales;
CREATE TABLE actividades_comerciales (
  id_cuenta INT NOT NULL,
  codigo_actividad VARCHAR(6) NOT NULL,     -- Acorde a resolucion 4.3
  PRIMARY KEY (id_cuenta, codigo_actividad),
  FOREIGN KEY (id_cuenta) REFERENCES cuentas(id) ON DELETE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS credenciales_atv;
CREATE TABLE credenciales_atv (
  id INT NOT NULL AUTO_INCREMENT,
  id_cuenta INT NOT NULL,
  llave_p12 VARCHAR(255) NOT NULL,
  pin_p12 VARCHAR(10) NOT NULL,
  usuario VARCHAR(250) NOT NULL,
  contrasena VARCHAR(60) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_cuenta) REFERENCES cuentas(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS historico_comprobantes;
CREATE TABLE historico_comprobantes (
  id INT NOT NULL AUTO_INCREMENT,
  id_emisor INT NOT NULL,
  id_receptor INT NOT NULL,
  fecha DATE NOT NULL,
  dispositivo_scan VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_emisor) REFERENCES cuentas(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_receptor) REFERENCES cuentas(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS comprobantes;
CREATE TABLE comprobantes (
    id INT NOT NULL AUTO_INCREMENT,
    id_historico INT NOT NULL,
    xml VARCHAR(100) NOT NULL,
    tipo VARCHAR(4) NOT NULL,
    estado INT(2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_historico) REFERENCES historico_comprobantes(id)
) ENGINE=InnoDB;