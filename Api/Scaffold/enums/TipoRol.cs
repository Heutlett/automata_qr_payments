using System.Text.Json.Serialization;

namespace Api.Scaffold
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TipoRol
    {
        Usuario = 1,
        Administrador = 2
    }
}