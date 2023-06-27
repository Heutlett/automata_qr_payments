using System.ComponentModel.DataAnnotations;

namespace Api.Models
{
    public partial class Cuenta
    {
        [Key]
        public int Id { get; set; }

        public int UsuarioId { get; set; }

        public TipoIdentificacion CedulaTipo { get; set; }

        [MaxLength(12)]
        public string CedulaNumero { get; set; } = string.Empty;

        [MaxLength(20)]
        public string IdExtranjero { get; set; } = string.Empty;

        [Required]
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

        [Required]
        [MaxLength(160)]
        [EmailAddress]
        public string Correo { get; set; } = String.Empty;

        [MaxLength(7)]
        public string UbicacionCodigo { get; set; } = String.Empty;

        [MaxLength(160)]
        public string UbicacionSenas { get; set; } = String.Empty;
        [MaxLength(300)]
        public string UbicacionSenasExtranjero { get; set; } = String.Empty;

        public bool IsActive { get; set; } = true;

        public TipoCuenta Tipo { get; set; } = TipoCuenta.Receptor;

        // Navigation property to the Usuario entity
        public virtual Usuario Usuario { get; set; } = null!;

        // Many-to-many relationship with the CodigoActividad entity
        public virtual ICollection<CodigoActividadCuenta> CodigosActividad { get; set; } = new List<CodigoActividadCuenta>();

        // Many-to-many relationship with the Usuario entity
        public virtual ICollection<Usuario> UsuariosCompartidos { get; } = new List<Usuario>();
    }
}
