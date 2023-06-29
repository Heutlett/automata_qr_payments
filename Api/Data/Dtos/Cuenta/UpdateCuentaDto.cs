using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Models;

namespace Api.Data.Dtos.Cuenta
{
    public class UpdateCuentaDto
    {
        public int Id { get; set; }
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
        public TipoCuenta Tipo { get; set; } = TipoCuenta.Receptor;

        public List<GetActividadDto> actividades { get; set; } = new List<GetActividadDto>();
    }
}