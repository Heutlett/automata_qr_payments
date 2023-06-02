using System;
using System.Collections.Generic;

namespace Api.Scaffold;

public partial class Actividad
{
    public int Codigo { get; set; }

    public string Nombre { get; set; } = null!;

    public virtual ICollection<Cuenta> Cuentas { get; } = new List<Cuenta>();
}
