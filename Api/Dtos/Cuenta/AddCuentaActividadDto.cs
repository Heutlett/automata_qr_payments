using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Dtos.Cuenta
{
    public class AddCuentaActividadDto
    {
        public int CuentaId { get; set; }
        public int ActividadId { get; set; }
    }
}