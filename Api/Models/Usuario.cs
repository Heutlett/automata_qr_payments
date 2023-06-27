using System.ComponentModel.DataAnnotations;

namespace Api.Models
{
    public partial class Usuario
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(36)]
        public String UID { get; set; } = Guid.NewGuid().ToString();

        [Required]
        [MaxLength(100)]
        public string NombreCompleto { get; set; } = string.Empty;

        [Required]
        [MaxLength(20)]
        public string Username { get; set; } = string.Empty;
        public byte[] PasswordHash { get; set; } = new byte[0];
        public byte[] PasswordSalt { get; set; } = new byte[0];

        [Required]
        [EmailAddress]
        [MaxLength(160)]
        public string Email { get; set; } = string.Empty;

        public TipoRol Rol { get; set; }

        // One-to-many relationship with the Cuenta entity
        public virtual ICollection<Cuenta> Cuenta { get; } = new List<Cuenta>();

        // Many-to-many relationship with the Cuenta entity (Shared Accounts)
        public virtual ICollection<Cuenta> CuentasCompartidas { get; } = new List<Cuenta>();
    }
}
