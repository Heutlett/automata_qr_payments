using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Dtos.Cuenta
{
    public class GetActividadDto
    {
        public int Codigo { get; set; }
        public string Nombre { get; set; } = string.Empty;
    }
}