using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Dtos.Cuenta
{
    public class AddCuentaActividadesDto
    {
        public int CuentaId { get; set; }
        public List<int> ActividadesId { get; set; } = new List<int>();
    }
}