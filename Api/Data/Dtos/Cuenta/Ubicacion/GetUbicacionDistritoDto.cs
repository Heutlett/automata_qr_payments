using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Data.Dtos.Cuenta.Ubicacion
{
    public class GetUbicacionDistritoDto
    {
        public int Distrito { get; set; } 
        public string NombreDistrito { get; set; } = string.Empty;

    }
}