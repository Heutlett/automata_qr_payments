using System.ComponentModel.DataAnnotations;

namespace Api.Models;

public partial class CodigoActividadCuenta
{
    [Key]
    [Required]
    public int Codigo { get; set; }

    [Key]
    [Required]
    public int CuentaId { get; set; }

    public virtual Cuenta Cuenta { get; set; } = null!;
}

