using Api.Models;

namespace Api.Data
{
    public interface IAuthRepository
    {
        Task<ServiceResponse<int>> Register(Usuario usuario, string password);
        Task<ServiceResponse<string>> Login(string username, string password);
        Task<bool> UserExists(string username);
    }
}