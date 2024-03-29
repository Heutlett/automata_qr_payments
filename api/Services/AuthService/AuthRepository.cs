using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Api.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace Api.Data
{
    public class AuthRepository : IAuthRepository
    {

        private readonly DataContext _context;
        private readonly IConfiguration _configuration;

        public AuthRepository(DataContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }
        public async Task<ServiceResponse<string>> Login(string username, string password)
        {
            var response = new ServiceResponse<string>();
            var usuario = await _context.Usuarios
                .FirstOrDefaultAsync(u => u.Username.ToLower().Equals(username.ToLower()));

            if (usuario is null)
            {
                response.Success = false;
                response.Message = "No se ha encontrado el usuario.";
            }
            else if (!VerifyPasswordHash(password, usuario.PasswordHash, usuario.PasswordSalt))
            {
                response.Success = false;
                response.Message = "Contraseña incorrecta.";
            }
            else
            {
                response.Data = CreateToken(usuario);
                response.Message = "Se ha iniciado sesión correctamente!";
            }

            return response;
        }

        public async Task<ServiceResponse<int>> Register(Usuario usuario, string password)
        {
            var response = new ServiceResponse<int>();
            if (await UserExists(usuario.Username))
            {
                response.Success = false;
                response.Message = "El usuario ya existe.";
                return response;
            }

            CreatePasswordHash(password, out byte[] passwordHash, out byte[] passwordSalt);

            usuario.PasswordHash = passwordHash;
            usuario.PasswordSalt = passwordSalt;

            _context.Usuarios.Add(usuario);
            await _context.SaveChangesAsync();
            response.Data = usuario.Id;
            response.Message = "El usuario se ha registrado exitosamente.";
            return response;
        }

        private async Task<bool> UserExists(string username)
        {
            return await _context.Usuarios.AnyAsync(u => u.Username.ToLower() == username.ToLower());
        }

        private void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            using (var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }
        }

        private bool VerifyPasswordHash(string password, byte[] passwordHash, byte[] passwordSalt)
        {
            using (var hmac = new System.Security.Cryptography.HMACSHA512(passwordSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return computedHash.SequenceEqual(passwordHash);
            }
        }

        private string CreateToken(Usuario usuario)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, usuario.UID),
                new Claim(ClaimTypes.Name, usuario.Username)
                // Hay que agregar los roles eventualmente
            };

            var appSettingsToken = _configuration.GetSection("AppSettings:Token").Value;

            if (appSettingsToken is null)
                throw new Exception("AppSettings Token is null!");

            SymmetricSecurityKey key = new SymmetricSecurityKey(System.Text.Encoding.UTF8
                .GetBytes(appSettingsToken));

            SigningCredentials creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.Now.AddDays(1),
                SigningCredentials = creds
            };

            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);

            return tokenHandler.WriteToken(token);
        }
    }
}