using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Cuenta
    {
        [Key]
        public int Id { get; set; }

        public Usuario? Usuario { get; set; }

        public TipoIdentificacion CedulaTipo { get; set; }

        [MaxLength(12)]
        public string CedulaNumero { get; set; } = string.Empty;

        [MaxLength(20)]
        public string IdExtranjero { get; set; } = string.Empty;

        [MaxLength(100)]
        public string Nombre { get; set; } = string.Empty;

        [MaxLength(80)]
        public string NombreComercial { get; set; } = string.Empty;

        [MaxLength(3)]
        public string TelCodigoPais { get; set; } = string.Empty;

        [MaxLength(20)]
        public string TelNumero { get; set; } = string.Empty;

        [MaxLength(3)]
        public string FaxCodigoPais { get; set; } = string.Empty;

        [MaxLength(20)]
        public string FaxNumero { get; set; } = string.Empty;

        [MaxLength(160)]
        public string Correo { get; set; } = String.Empty;

        [MaxLength(7)]
        public string UbicacionCodigo { get; set; } = String.Empty;

        [MaxLength(160)]
        public string UbicacionSenas { get; set; } = String.Empty;
        [MaxLength(300)]
        public string UbicacionSenasExtranjero { get; set; } = String.Empty;
        public bool IsActive { get; set; } = true;
        public TipoCuenta Tipo { get; set; } = TipoCuenta.Receptor;
        public List<Actividad> Actividades { get; set; } = new List<Actividad>();
        public List<Usuario> UsuariosCompartidos { get; set; } = new List<Usuario>();

        public static implicit operator Cuenta(int v)
        {
            throw new NotImplementedException();
        }
    }
}