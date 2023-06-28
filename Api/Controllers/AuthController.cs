using Api.Data;
using Api.Data.Dtos.Usuario;
using Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    /// <summary>
    /// Controlador para el manejo de la autenticación y registro de usuarios.
    /// </summary>
    /// <remarks>
    /// Este controlador proporciona los metodos para registrarse e iniciar sesión.
    /// </remarks>
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthRepository _authRepo;

        public AuthController(IAuthRepository authRepo)
        {
            _authRepo = authRepo;
        }

        /// <summary>
        /// Registra un nuevo usuario en la base de datos
        /// </summary>
        /// <param name="request">Datos del nuevo usuario a registrar</param>
        /// <returns>ActionResult<ServiceResponse<int>> Objeto que encapsula el resultado de la operación, incluyendo el id del usuario registrado</returns>
        [HttpPost("Register")]
        public async Task<ActionResult<ServiceResponse<int>>> Register(UsuarioRegisterDto request)
        {
            var response = await _authRepo.Register(
                new Usuario { NombreCompleto = request.NombreCompleto.ToUpper(), Username = request.Username, Email = request.Email, Rol = request.Rol }, request.Password
            );
            if (!response.Success)
            {
                return BadRequest(response);
            }
            return Ok(response);
        }

        /// <summary>
        /// Autentica un usuario y devuelve un token de acceso
        /// </summary>
        /// <param name="request">Datos del usuario para la autenticación</param>
        /// <returns>ActionResult<ServiceResponse<string>> Objeto que encapsula el resultado de la operación, incluyendo el id del usuario autenticado y un token de acceso</returns>
        [HttpPost("Login")]
        public async Task<ActionResult<ServiceResponse<string>>> Login(UsuarioLoginDto request)
        {
            var response = await _authRepo.Login(request.Username, request.Password);
            if (!response.Success)
            {
                return BadRequest(response);
            }
            return Ok(response);
        }
    }
}