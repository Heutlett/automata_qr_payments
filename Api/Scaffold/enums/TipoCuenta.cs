using System.Text.Json.Serialization;

namespace Api.Scaffold
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TipoCuenta
    {
        Receptor = 1,
        Emisor = 2
    }
}