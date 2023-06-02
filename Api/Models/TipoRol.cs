using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Api.Models
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TipoRol
    {
        Usuario = 1,
        Administrador = 2
    }
}