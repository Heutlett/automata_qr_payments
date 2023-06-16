using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Usuario
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(36)]
        public String UID { get; set; } = Guid.NewGuid().ToString();

        [Required]
        [MaxLength(20)]
        public string Username { get; set; } = string.Empty;
        public byte[] PasswordHash { get; set; } = new byte[0];
        public byte[] PasswordSalt { get; set; } = new byte[0];

        [Required]
        [MaxLength(160)]
        public string Email { get; set; } = string.Empty;
        public TipoRol Rol { get; set; }

        public List<CuentaCompartida> CuentasCompartidas { get; set; } = new List<CuentaCompartida>();
    }
}