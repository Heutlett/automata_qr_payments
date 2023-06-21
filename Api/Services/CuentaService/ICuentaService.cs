using Api.Dtos.Cuenta;
using Api.Dtos.Cuenta.Ubicacion;
using Api.Models;

namespace Api.Services.CuentaService
{
    public interface ICuentaService
    {
        Task<ServiceResponse<List<GetCuentaDto>>> GetAllCuentas();
        Task<ServiceResponse<GetCuentaDto>> GetCuentaById(int id);
        Task<ServiceResponse<List<GetCuentaDto>>> AddCuenta(AddCuentaDto newCuenta);
        Task<ServiceResponse<GetCuentaDto>> UpdateCuenta(UpdateCuentaDto updatedCuenta);
        Task<ServiceResponse<List<GetCuentaDto>>> DeleteCuenta(int id);
        Task<ServiceResponse<GetActividadDto>> GetActividadByCodigo(int codigo);
        Task<ServiceResponse<GetCuentaDto>> AddCuentaActividades(AddCuentaActividadesDto newCuentaActivdades);
        Task<ServiceResponse<GetUbicacionDto>> GetUbicacion(string codigoUbicacion);
        Task<ServiceResponse<List<GetUbicacionProvinciaDto>>> GetUbicacionProvincias();
        Task<ServiceResponse<List<GetUbicacionCantonDto>>> GetUbicacionCanton(int provincia);
        Task<ServiceResponse<List<GetUbicacionDistritoDto>>> GetUbicacionDistrito(int provincia, int canton);
        Task<ServiceResponse<List<GetUbicacionBarrioDto>>> GetUbicacionBarrio(int provincia, int canton, int distrito);
        Task<ServiceResponse<GetCuentaDto>> GetCuentaTemporal(string username, int id);
        Task<ServiceResponse<string>> GenerateCuentaQr(int CuentaId);
        Task<ServiceResponse<GetCuentaDto>> ShareCuenta(string encryptedcode);
        Task<ServiceResponse<GetCuentaDto>> UnshareCuenta(int id);
        Task<ServiceResponse<GetCuentaDto>> UnshareCuenta(int id, string username);

    }
}