using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Models;

namespace Api.Data
{
    public class Population
    {
        public static Ubicacion[] Ubicaciones { get; set; } = 
        { 
            new Ubicacion { Id = 1, Provincia = 1, NombreProvincia = "San José", Canton = 1, NombreCanton = "San José", Distrito = 1, NombreDistrito = "CARMEN", Barrio = 1, NombreBarrio = "Amón" },
            new Ubicacion { Id = 2, Provincia = 1, NombreProvincia = "San José", Canton = 1, NombreCanton = "San José", Distrito = 1, NombreDistrito = "CARMEN", Barrio = 2, NombreBarrio = "Aranjuez" },
            new Ubicacion { Id = 3, Provincia = 1, NombreProvincia = "San José", Canton = 1, NombreCanton = "San José", Distrito = 1, NombreDistrito = "CARMEN", Barrio = 3, NombreBarrio = "California (parte)" },
            new Ubicacion { Id = 4, Provincia = 6, NombreProvincia = "Puntarenas", Canton = 8, NombreCanton = "Coto Brus", Distrito = 1, NombreDistrito = "SAN VITO", Barrio = 1, NombreBarrio = "Canada" },
            new Ubicacion { Id = 5, Provincia = 6, NombreProvincia = "Puntarenas", Canton = 8, NombreCanton = "Coto Brus", Distrito = 1, NombreDistrito = "SAN VITO", Barrio = 11, NombreBarrio = "Danto" }
        };

    }
}