using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Ubicacion
    {
        [Key]
        [Required]
        public int Provincia { get; set; } 
        public string NombreProvincia { get; set; } = string.Empty;
        [Key]
        [Required]
        public int Canton { get; set; } 
        public string NombreCanton { get; set; } = string.Empty;
        [Key]
        [Required]
        public int Distrito { get; set; } 
        public string NombreDistrito { get; set; } = string.Empty;
        [Key]
        [Required]
        public int Barrio { get; set; } 
        public string NombreBarrio { get; set; } = string.Empty;
    }
}