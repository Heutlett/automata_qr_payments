using System.Text.Json.Serialization;

namespace Api.Models
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TipoIdentificacion
    {
        Fisica = 1,
        Juridica = 2,
        DIMEX = 3,
        NITE = 4,
    }
}