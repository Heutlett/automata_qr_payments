using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Api.Data;
using Api.Dtos.Cuenta;
using Api.Models;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace Api.Services.CuentaService
{
    public class CuentaService : ICuentaService
    {
        private readonly IMapper _mapper;
        private readonly DataContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public CuentaService(IMapper mapper, DataContext context, IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
            _mapper = mapper;
            _context = context;
        }

        private int GetUserId() => int.Parse(_httpContextAccessor.HttpContext!.User
            .FindFirstValue(ClaimTypes.NameIdentifier)!);

        public async Task<ServiceResponse<List<GetCuentaDto>>> AddCuenta(AddCuentaDto newCuenta)
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();
            var cuenta = _mapper.Map<Cuenta>(newCuenta);
            cuenta.Usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.Id == GetUserId());

            _context.Cuentas.Add(cuenta); // (No es Async) Aun no se llama la db, solo se agrega un Cuenta al dataContext
            await _context.SaveChangesAsync();  // Aqui es donde ya se envia a la db (Async)

            serviceResponse.Data =
                await _context.Cuentas
                    .Where(c => c.Usuario!.Id == GetUserId())
                    .Select(c => _mapper.Map<GetCuentaDto>(c))
                    .ToListAsync();
            return serviceResponse;
        }

        public async Task<ServiceResponse<List<GetCuentaDto>>> DeleteCuenta(int id)
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();

            try
            {
                var cuenta = await _context.Cuentas
                    .Include(c => c.Usuario)
                    .FirstOrDefaultAsync(c => c.Id == id && c.Usuario!.Id == GetUserId() && c.IsActive);

                if (cuenta is null || cuenta.Usuario!.Id != GetUserId())
                    throw new Exception($"No se ha encontrado la cuenta con el Id '{id}'");

                cuenta.IsActive = false;
                await _context.SaveChangesAsync();

                serviceResponse.Data =
                    await _context.Cuentas
                        .Where(c => c.Usuario!.Id == GetUserId() && c.IsActive)
                        .Select(c => _mapper.Map<GetCuentaDto>(c)).ToListAsync();
            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<List<GetCuentaDto>>> GetAllCuentas()
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();
            var dbCuentas = await _context.Cuentas
                .Where(c => c.Usuario!.Id == GetUserId() && c.IsActive).ToListAsync();

            serviceResponse.Data = dbCuentas.Select(c => _mapper.Map<GetCuentaDto>(c)).ToList();
            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> GetCuentaById(int id)
        {

            var serviceResponse = new ServiceResponse<GetCuentaDto>();
            var dbCuenta = await _context.Cuentas
                .FirstOrDefaultAsync(c => c.Id == id && c.Usuario!.Id == GetUserId() && c.IsActive);
            serviceResponse.Data = _mapper.Map<GetCuentaDto>(dbCuenta);
            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> UpdateCuenta(UpdateCuentaDto updatedCuenta)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();

            try
            {
                var cuenta =
                    await _context.Cuentas
                    .Include(c => c.Usuario)
                    .FirstOrDefaultAsync(c => c.Id == updatedCuenta.Id && c.IsActive);

                if (cuenta is null || cuenta.Usuario!.Id != GetUserId())
                    throw new Exception($"No se ha encontrado la cuenta con el Id '{updatedCuenta.Id}'");

                cuenta.CedulaTipo = updatedCuenta.CedulaTipo;
                cuenta.CedulaNumero = updatedCuenta.CedulaNumero;
                cuenta.IdExtranjero = updatedCuenta.IdExtranjero;
                cuenta.Nombre = updatedCuenta.Nombre;
                cuenta.NombreComercial = updatedCuenta.NombreComercial;
                cuenta.TelCodigoPais = updatedCuenta.TelCodigoPais;
                cuenta.TelNumero = updatedCuenta.TelNumero;
                cuenta.FaxCodigoPais = updatedCuenta.FaxCodigoPais;
                cuenta.FaxNumero = updatedCuenta.FaxNumero;
                cuenta.Correo = updatedCuenta.Correo;
                cuenta.UbicacionCodigo = updatedCuenta.UbicacionCodigo;
                cuenta.UbicacionSenas = updatedCuenta.UbicacionSenas;
                cuenta.UbicacionSenasExtranjero = updatedCuenta.UbicacionSenasExtranjero;
                cuenta.Tipo = updatedCuenta.Tipo;

                await _context.SaveChangesAsync();
                serviceResponse.Data = _mapper.Map<GetCuentaDto>(cuenta);
            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }
    }
}