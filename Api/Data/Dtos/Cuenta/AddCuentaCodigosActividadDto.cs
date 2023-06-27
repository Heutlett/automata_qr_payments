using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Data.Dtos.Cuenta
{
    public class AddCuentaCodigosActividadDto
    {
        public int CuentaId { get; set; }
        public List<int> CodigosActividad { get; set; } = new List<int>();
    }
}