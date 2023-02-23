using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Api.Models
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TipoCuenta
    {
        Receptor = 1,
        Emisor = 2
    }
}