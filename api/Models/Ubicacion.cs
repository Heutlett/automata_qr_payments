using System.ComponentModel.DataAnnotations;

namespace Api.Models;

public partial class Ubicacion
{
    [Key]
    [Required]
    public int Provincia { get; set; }

    [Key]
    [Required]

    public int Canton { get; set; }
    [Key]
    [Required]

    public int Distrito { get; set; }
    [Key]
    [Required]
    public int Barrio { get; set; }

    public string NombreProvincia { get; set; } = string.Empty;

    public string NombreCanton { get; set; } = string.Empty;

    public string NombreDistrito { get; set; } = string.Empty;

    public string NombreBarrio { get; set; } = string.Empty;
}
