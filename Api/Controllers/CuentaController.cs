using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Dtos.Cuenta;
using Api.Models;
using Api.Services.CuentaService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class CuentaController : ControllerBase
    {
        private readonly ICuentaService _cuentaService;

        public CuentaController(ICuentaService cuentaService)
        {
            _cuentaService = cuentaService;
        }

        // Quita la authorization
        // [AllowAnonymous]
        // api/Cuenta/GetAll
        [HttpGet("GetAll")]
        public async Task<ActionResult<ServiceResponse<List<GetCuentaDto>>>> Get()
        {
            // Esto se hace para obtener solo los Cuentas de un user.
            // int userId = int.Parse(User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)!.Value);
            // Se movio este proceso al servicio mediante inyeccion 
            return Ok(await _cuentaService.GetAllCuentas());
        }

        [HttpGet("{id}")]   // Difference from POST, in get methods we send data via URL, in POST we send via body
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> GetSingle(int id)
        {
            return Ok(await _cuentaService.GetCuentaById(id));
        }

        [HttpPost]
        public async Task<ActionResult<ServiceResponse<List<GetCuentaDto>>>> AddCuenta(AddCuentaDto newCuenta)
        {
            return Ok(await _cuentaService.AddCuenta(newCuenta));
        }

        [HttpPut]
        public async Task<ActionResult<ServiceResponse<List<GetCuentaDto>>>> UpdateCuenta(UpdateCuentaDto updatedCuenta)
        {
            var response = await _cuentaService.UpdateCuenta(updatedCuenta);
            if (response.Data is null)
            {
                return NotFound(response);
            }
            return Ok(response);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> DeleteCuenta(int id)
        {
            var response = await _cuentaService.DeleteCuenta(id);
            if (response.Data is null)
            {
                return NotFound(response);
            }
            return Ok(response);
        }
        [HttpPost("Actividad")]
        public async Task<ActionResult<ServiceResponse<GetActividadDto>>> AddCharacterSkill(AddCuentaActividadDto newCuentaActividad)
        {
            return Ok(await _cuentaService.AddCuentaActividad(newCuentaActividad));
        }
    }
}