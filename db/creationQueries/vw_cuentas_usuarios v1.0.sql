DROP VIEW IF EXISTS vw_cuentas_usuarios;
CREATE VIEW vw_cuentas_usuarios AS
SELECT
    u.Id AS UsuarioId,
    u.UID AS UID,
    c.Id AS CuentaId,
    u.Username AS Username,
    0 AS EsCompartida,
    c.CedulaTipo,
    c.CedulaNumero,
    c.IdExtranjero,
    c.Nombre,
    c.NombreComercial,
    c.TelCodigoPais,
    c.TelNumero,
    c.FaxCodigoPais,
    c.FaxNumero,
    c.Correo,
    c.UbicacionCodigo,
    c.UbicacionSenas,
    c.UbicacionSenasExtranjero,
    c.IsActive,
    c.Tipo
FROM
    cuentas c
    INNER JOIN usuarios u ON c.UsuarioId = u.Id
UNION
SELECT
    cc.UsuarioId AS UsuarioId,
    u.UID AS UID,
    c.Id AS CuentaId,
    u.Username AS Username,
    1 AS EsCompartida,
    c.CedulaTipo,
    c.CedulaNumero,
    c.IdExtranjero,
    c.Nombre,
    c.NombreComercial,
    c.TelCodigoPais,
    c.TelNumero,
    c.FaxCodigoPais,
    c.FaxNumero,
    c.Correo,
    c.UbicacionCodigo,
    c.UbicacionSenas,
    c.UbicacionSenasExtranjero,
    c.IsActive,
    c.Tipo
FROM
    cuentascompartidas cc
    INNER JOIN cuentas c ON cc.CuentaCompartidaId = c.Id
    INNER JOIN usuarios u ON cc.UsuarioId = u.Id
    INNER JOIN usuarios uc ON c.UsuarioId = uc.Id;
