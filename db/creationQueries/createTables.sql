DROP DATABASE IF EXISTS qr_payments_db;
CREATE DATABASE qr_payments_db;

use qr_payments_db;

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  Id INT NOT NULL AUTO_INCREMENT,
  Username VARCHAR(20) NOT NULL UNIQUE,
  PasswordHash LONGBLOB NOT NULL,
  PasswordSalt LONGBLOB NOT NULL,
  Email VARCHAR(160) NOT NULL,
  Rol TINYINT(2) NOT NULL,
  PRIMARY KEY (Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS cuentas;
CREATE TABLE cuentas (
  Id INT NOT NULL AUTO_INCREMENT,
  IdUsuario INT NOT NULL,
  CedulaTipo VARCHAR(2) NOT NULL,          -- Acorde a resolucion 4.3
  CedulaNumero VARCHAR(12) NOT NULL,       -- Acorde a resolucion 4.3
  IdExtranjero VARCHAR(20) NOT NULL,       -- Acorde a resolucion 4.3
  Nombre VARCHAR(100) NOT NULL,             -- Acorde a resolucion 4.3
  NombreComercial VARCHAR(80) NOT NULL,    -- Acorde a resolucion 4.3
  TelCodigoPais VARCHAR(3) NOT NULL,      -- Acorde a resolucion 4.3
  TelNumero VARCHAR(20) NOT NULL,          -- Acorde a resolucion 4.3
  FaxCodigoPais VARCHAR(3) NOT NULL,      -- Acorde a resolucion 4.3
  FaxNumero VARCHAR(20) NOT NULL,          -- Acorde a resolucion 4.3
  Correo VARCHAR(160) NOT NULL,             -- Acorde a resolucion 4.3
  UbicacionCodigo VARCHAR(7) NOT NULL,     -- Acorde a resolucion 4.3
  UbicacionSenas VARCHAR(250) NOT NULL,    -- Acorde a resolucion 4.3
  SenasExtranjero VARCHAR(300) NOT NULL,   -- Acorde a resolucion 4.3
  Inscrito BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (Id),
  FOREIGN KEY (IdUsuario) REFERENCES usuarios(Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS actividadcuenta;
CREATE TABLE actividadcuenta (
  IdCuenta INT NOT NULL,
  CodigoActividad VARCHAR(6) NOT NULL,     -- Acorde a resolucion 4.3
  PRIMARY KEY (IdCuenta, CodigoActividad),
  FOREIGN KEY (IdCuenta) REFERENCES cuentas(Id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS credenciales_atv;
CREATE TABLE credenciales_atv (
  Id INT NOT NULL AUTO_INCREMENT,
  IdCuenta INT NOT NULL,
  LlaveP12 VARCHAR(255) NOT NULL,
  PinP12 VARCHAR(10) NOT NULL,
  Usuario VARCHAR(250) NOT NULL,
  Contrasena VARCHAR(60) NOT NULL,
  PRIMARY KEY (Id),
  FOREIGN KEY (IdCuenta) REFERENCES cuentas(Id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS historicos;
CREATE TABLE historicos (
  Id INT NOT NULL AUTO_INCREMENT,
  IdEmisor INT NOT NULL,
  IdReceptor INT NOT NULL,
  Fecha DATE NOT NULL,
  DispositivoScan VARCHAR(100) NOT NULL,
  PRIMARY KEY (Id),
  FOREIGN KEY (IdEmisor) REFERENCES cuentas(Id),
  FOREIGN KEY (IdReceptor) REFERENCES cuentas(Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS comprobantes;
CREATE TABLE comprobantes (
    Id INT NOT NULL AUTO_INCREMENT,
    IdHistorico INT NOT NULL,
    Xml VARCHAR(100) NOT NULL,
    Tipo VARCHAR(4) NOT NULL,
    Estado INT(2) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (IdHistorico) REFERENCES historicos(Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS ubicaciones;
CREATE TABLE ubicaciones (
    Provincia INT NOT NULL,
    NombreProvincia VARCHAR(20) CHARACTER SET utf8mb4 NOT NULL,
    Canton INT NOT NULL,
    NombreCanton VARCHAR(20) CHARACTER SET utf8mb4 NOT NULL,
    Distrito INT NOT NULL,
    NombreDistrito VARCHAR(70) CHARACTER SET utf8mb4 NOT NULL,
    Barrio INT NOT NULL,
    NombreBarrio VARCHAR(50) CHARACTER SET utf8mb4 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE ubicaciones
ADD CONSTRAINT compuesta_pk PRIMARY KEY (Provincia, Canton, Distrito, Barrio);

DROP TABLE IF EXISTS actividad;
CREATE TABLE actividad (
    Codigo INT NOT NULL,
    Nombre VARCHAR(120) CHARACTER SET utf8mb4 NOT NULL,
    PRIMARY KEY (Codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



