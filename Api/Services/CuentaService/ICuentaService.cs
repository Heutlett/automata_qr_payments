using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Dtos.Cuenta;
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
    }
}