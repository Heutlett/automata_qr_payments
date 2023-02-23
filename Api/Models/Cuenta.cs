using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Cuenta
    {
        public int Id { get; set; }
        public Usuario? Usuario { get; set; }
        public TipoIdentificacion CedulaTipo { get; set; }
        public string CedulaNumero { get; set; } = string.Empty;
        public string IdExtranjero { get; set; } = string.Empty;
        public string Nombre { get; set; } = string.Empty;
        public string NombreComercial { get; set; } = string.Empty;
        public string TelCodigoPais { get; set; } = string.Empty;
        public string TelNumero { get; set; } = string.Empty;
        public string FaxCodigoPais { get; set; } = string.Empty;
        public string FaxNumero { get; set; } = string.Empty;
        public string Correo { get; set; } = String.Empty;
        public string UbicacionCodigo { get; set; } = String.Empty;
        public string UbicacionSenas { get; set; } = String.Empty;
        public string UbicacionSenasExtranjero { get; set; } = String.Empty;
        public bool IsActive { get; set; } = true;
        public TipoCuenta Tipo { get; set; } = TipoCuenta.Receptor;
    }
}