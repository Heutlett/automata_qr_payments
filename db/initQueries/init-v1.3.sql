-- Update: Se agrega la tabla codigosactividadcuenta y se quita la tabla actividades

DROP DATABASE IF EXISTS qr_payments;
CREATE DATABASE qr_payments;

USE qr_payments;

-- Log a message
SELECT 'CREATION - Executing...';

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  Id INT NOT NULL AUTO_INCREMENT,
  UID VARCHAR(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  NombreCompleto VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  Username VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
  PasswordHash LONGBLOB NOT NULL,
  PasswordSalt LONGBLOB NOT NULL,
  Email VARCHAR(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  Rol TINYINT(1) NOT NULL,
  PRIMARY KEY (Id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Log a message
SELECT 'CREATION - Table created: usuarios';

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

-- Log a message
SELECT 'CREATION - Table created: cuentas';

DROP TABLE IF EXISTS cuentascompartidas;
CREATE TABLE cuentascompartidas (
  UsuarioId INT NOT NULL,
  CuentaCompartidaId INT NOT NULL,
  PRIMARY KEY (UsuarioId, CuentaCompartidaId),
  KEY IX_CuentasCompartidas_CuentaCompartidaId (CuentaCompartidaId), -- index key
  CONSTRAINT FK_CuentasCompartidas_Usuarios_UsuarioId FOREIGN KEY (UsuarioId) REFERENCES usuarios(Id) ON DELETE CASCADE,
  CONSTRAINT FK_CuentasCompartidas_Cuentas_CuentaCompartidaId FOREIGN KEY (CuentaCompartidaId) REFERENCES cuentas(Id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Log a message
SELECT 'CREATION - Table created: cuentascompartidas';

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

-- Log a message
SELECT 'CREATION - Table created: ubicaciones';

DROP TABLE IF EXISTS codigosactividadcuenta;
CREATE TABLE codigosactividadcuenta (
  Codigo INT NOT NULL,
  CuentaId INT NOT NULL,
  PRIMARY KEY (Codigo, CuentaId),
  KEY IX_CuentaId (CuentaId),
  CONSTRAINT FK_CodigosActividadCuenta_Cuentas_CuentasId FOREIGN KEY (CuentaId) REFERENCES cuentas(Id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Log a message
SELECT 'CREATION - Table created: codigosactividadcuenta';
