using System.Text.Json.Serialization;

namespace Api.Models
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TipoCuenta
    {
        Receptor = 1,
        Emisor = 2
    }
}