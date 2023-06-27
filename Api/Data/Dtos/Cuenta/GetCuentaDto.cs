using Api.Data.Dtos.Usuario;
using Api.Models;

namespace Api.Data.Dtos.Cuenta
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
        public List<int> CodigosActividad { get; set; } = new List<int>();
        public List<UsuarioCompartidoDto> UsuariosCompartidos { get; set; } = new List<UsuarioCompartidoDto>();
        public bool EsCompartida { get; internal set; }

        public static implicit operator GetCuentaDto(string v)
        {
            throw new NotImplementedException();
        }
    }
}