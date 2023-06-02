using System;
using System.Collections.Generic;

namespace Api.Scaffold;

public partial class Cuenta
{
    public int Id { get; set; }

    public int UsuarioId { get; set; }

    public int CedulaTipo { get; set; }

    public string CedulaNumero { get; set; } = null!;

    public string IdExtranjero { get; set; } = null!;

    public string Nombre { get; set; } = null!;

    public string NombreComercial { get; set; } = null!;

    public string TelCodigoPais { get; set; } = null!;

    public string TelNumero { get; set; } = null!;

    public string FaxCodigoPais { get; set; } = null!;

    public string FaxNumero { get; set; } = null!;

    public string Correo { get; set; } = null!;

    public string UbicacionCodigo { get; set; } = null!;

    public string UbicacionSenas { get; set; } = null!;

    public string UbicacionSenasExtranjero { get; set; } = null!;

    public bool IsActive { get; set; }

    public int Tipo { get; set; }

    public virtual Usuario Usuario { get; set; } = null!;

    public virtual ICollection<Actividad> Actividades { get; } = new List<Actividad>();
}
