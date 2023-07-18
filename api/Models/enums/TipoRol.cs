using System.Text.Json.Serialization;

namespace Api.Models
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TipoRol
    {
        Usuario = 1,
        Administrador = 2
    }
}