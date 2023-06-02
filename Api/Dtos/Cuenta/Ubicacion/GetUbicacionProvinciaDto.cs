using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Dtos.Cuenta.Ubicacion
{
    public class GetUbicacionProvinciaDto
    {
        public int Provincia { get; set; }
        public string NombreProvincia { get; set; } = string.Empty;
    }
}