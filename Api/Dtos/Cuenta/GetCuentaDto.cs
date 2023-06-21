using Api.Dtos.Usuario;
using Api.Models;

namespace Api.Dtos.Cuenta
{
    public class GetCuentaDto
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
        public List<GetActividadDto>? Actividades { get; set; }
        public List<string>? UsuariosCompartidos { get; set; }
        public bool EsCompartida { get; internal set; }
    }
}