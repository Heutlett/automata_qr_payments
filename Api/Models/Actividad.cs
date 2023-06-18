using System.ComponentModel.DataAnnotations;

namespace Api.Models;

public partial class Actividad
{
    [Key]
    [Required]
    public int Codigo { get; set; }
    
    [Required]
    public string Nombre { get; set; } = null!;

    public virtual ICollection<Cuenta> Cuentas { get; } = new List<Cuenta>();
}
