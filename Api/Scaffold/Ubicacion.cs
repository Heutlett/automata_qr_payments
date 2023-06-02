using System;
using System.Collections.Generic;

namespace Api.Scaffold;

public partial class Ubicacion
{
    public int Provincia { get; set; }

    public int Canton { get; set; }

    public int Distrito { get; set; }

    public int Barrio { get; set; }

    public string NombreProvincia { get; set; } = null!;

    public string NombreCanton { get; set; } = null!;

    public string NombreDistrito { get; set; } = null!;

    public string NombreBarrio { get; set; } = null!;
}
