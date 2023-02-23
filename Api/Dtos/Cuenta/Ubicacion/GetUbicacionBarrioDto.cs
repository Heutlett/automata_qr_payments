using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Dtos.Cuenta.Ubicacion
{
    public class GetUbicacionBarrioDto
    {
        public int Barrio { get; set; } 
        public string NombreBarrio { get; set; } = string.Empty;
    }
}