DROP DATABASE IF EXISTS qr_payments2;
CREATE DATABASE qr_payments2;

USE qr_payments2;

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  Id INT NOT NULL AUTO_INCREMENT,
  UID VARCHAR(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  Username VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
  PasswordHash LONGBLOB NOT NULL,
  PasswordSalt LONGBLOB NOT NULL,
  Email VARCHAR(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  Rol TINYINT(1) NOT NULL,
  PRIMARY KEY (Id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS cuentas;
CREATE TABLE cuentas (
  Id INT NOT NULL AUTO_INCREMENT,
  UsuarioId INT NOT NULL,
  CedulaTipo int NOT NULL,          -- Acorde a resolucion 4.3
  CedulaNumero VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,       -- Acorde a resolucion 4.3
  IdExtranjero VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,       -- Acorde a resolucion 4.3
  Nombre VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,             -- Acorde a resolucion 4.3
  NombreComercial VARCHAR(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,    -- Acorde a resolucion 4.3
  TelCodigoPais VARCHAR(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,      -- Acorde a resolucion 4.3
  TelNumero VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,          -- Acorde a resolucion 4.3
  FaxCodigoPais VARCHAR(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,      -- Acorde a resolucion 4.3
  FaxNumero VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,          -- Acorde a resolucion 4.3
  Correo VARCHAR(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,             -- Acorde a resolucion 4.3
  UbicacionCodigo VARCHAR(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,     -- Acorde a resolucion 4.3
  UbicacionSenas VARCHAR(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,    -- Acorde a resolucion 4.3
  UbicacionSenasExtranjero VARCHAR(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,   -- Acorde a resolucion 4.3
  IsActive TINYINT(1) NOT NULL,
  Tipo INT NOT NULL,
  PRIMARY KEY (Id),
  KEY IX_Cuentas_UsuarioId (UsuarioId), -- index key - indice en la columna UsuarioId
  CONSTRAINT FK_Cuentas_Usuarios_UsuarioId FOREIGN KEY (UsuarioId) REFERENCES usuarios(Id)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS actividades;
CREATE TABLE actividades (
    Codigo INT NOT NULL AUTO_INCREMENT,
    Nombre LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (Codigo)
) ENGINE=InnoDB AUTO_INCREMENT=990002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS actividadcuenta;
CREATE TABLE actividadcuenta (
  ActividadesCodigo INT NOT NULL,
  CuentasId INT NOT NULL,     -- Acorde a resolucion 4.3
  PRIMARY KEY (ActividadesCodigo, CuentasId),
  KEY IX_ActividadCuenta_CuentasId (CuentasId), -- index key - index on the CuentasId column
  CONSTRAINT FK_ActividadCuenta_Actividades_ActividadesCodigo FOREIGN KEY (ActividadesCodigo) REFERENCES actividades(Codigo) ON DELETE CASCADE,
  CONSTRAINT FK_ActividadCuenta_Cuentas_CuentasId FOREIGN KEY (CuentasId) REFERENCES cuentas(Id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS ubicaciones;
CREATE TABLE ubicaciones (
	Provincia INT NOT NULL,
    Canton INT NOT NULL,
    Distrito INT NOT NULL,
    Barrio INT NOT NULL,
    NombreProvincia LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    NombreCanton LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	NombreDistrito LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    NombreBarrio LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (Provincia, Canton, Distrito, Barrio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- DROP TABLE IF EXISTS--  credenciales_atv;
-- CREATE TABLE credenciales_atv (
--   Id INT NOT NULL AUTO_INCREMENT,
--   IdCuenta INT NOT NULL,
--   LlaveP12 VARCHAR(255) NOT NULL,
--   PinP12 VARCHAR(10) NOT NULL,
--   Usuario VARCHAR(250) NOT NULL,
--   Contrasena VARCHAR(60) NOT NULL,
--   PRIMARY KEY (Id),
--   FOREIGN KEY (IdCuenta) REFERENCES cuentas(Id) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- DROP TABLE IF EXISTS historicos;
-- CREATE TABLE historicos (
--   Id INT NOT NULL AUTO_INCREMENT,
--   IdEmisor INT NOT NULL,
--   IdReceptor INT NOT NULL,
--   Fecha DATE NOT NULL,
--   DispositivoScan VARCHAR(100) NOT NULL,
--   PRIMARY KEY (Id),
--   FOREIGN KEY (IdEmisor) REFERENCES cuentas(Id),
--   FOREIGN KEY (IdReceptor) REFERENCES cuentas(Id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- DROP  TABLE IF EXISTS--  comprobantes;
-- CREATE TABLE comprobantes (
--     Id INT NOT NULL AUTO_INCREMENT,
--     IdHistorico INT NOT NULL,
--     Xml VARCHAR(100) NOT NULL,
--     Tipo VARCHAR(4) NOT NULL,
--     Estado INT(2) NOT NULL,
--     PRIMARY KEY (Id),
--     FOREIGN KEY (IdHistorico) REFERENCES historicos(Id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- ALTER TABLE ubicaciones
-- ADD  CONSTRAINT compuesta_pk PRIMARY KEY (Provincia, Canton, Distrito, Barrio);



