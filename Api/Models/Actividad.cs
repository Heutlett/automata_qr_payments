using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Actividad
    {
        [Key]
        [Required]
        public int Codigo { get; set; }
        [Required]
        public string Nombre { get; set; } = string.Empty;
        public List<Cuenta>? Cuentas { get; set; }
    }
}