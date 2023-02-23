using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace Api.Dtos.Usuario
{
    public class UsuarioRegisterDto
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public TipoRol Rol { get; set; } = TipoRol.Usuario;
    }
}