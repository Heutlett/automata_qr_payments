using System;

namespace Api.Models
{
    public class VwCuentasUsuarios
    {
        public int UsuarioId { get; set; }
        public String UID { get; set; } = null!;
        public int CuentaId { get; set; }
        public string Username { get; set; } = string.Empty;
        public bool EsCompartida { get; set; }
        public int CedulaTipo { get; set; }
        public string CedulaNumero { get; set; } = string.Empty;
        public string IdExtranjero { get; set; } = string.Empty;
        public string Nombre { get; set; } = string.Empty;
        public string NombreComercial { get; set; } = string.Empty;
        public string TelCodigoPais { get; set; } = string.Empty;
        public string TelNumero { get; set; } = string.Empty;
        public string FaxCodigoPais { get; set; } = string.Empty;
        public string FaxNumero { get; set; } = string.Empty;
        public string Correo { get; set; } = string.Empty;
        public string UbicacionCodigo { get; set; } = string.Empty;
        public string UbicacionSenas { get; set; } = string.Empty;
        public string UbicacionSenasExtranjero { get; set; } = string.Empty;
        public bool IsActive { get; set; }
        public int Tipo { get; set; }
    }
}
