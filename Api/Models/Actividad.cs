using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Actividad
    {
        public int Id { get; set; } 
        public string Codigo { get; set; } = string.Empty;
        public string Nombre { get; set; } = string.Empty;
        public List<Cuenta>? Cuentas { get; set; }
    }
}