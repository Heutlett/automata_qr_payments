using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Data.Dtos.Cuenta.Ubicacion
{
    public class GetUbicacionCantonDto
    {
        public int Canton { get; set; } 
        public string NombreCanton { get; set; } = string.Empty;
    }
}