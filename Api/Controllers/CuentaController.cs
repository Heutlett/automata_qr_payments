using Api.Dtos.Cuenta;
using Api.Dtos.Cuenta.Ubicacion;
using Api.Models;
using Api.Services.CuentaService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    /// <summary>
    /// Controlador para administrar cuentas.
    /// </summary>
    /// <remarks>
    /// Este controlador proporciona las operaciones CRUD (Crear, Leer, Actualizar y Eliminar) para las cuentas.
    /// </remarks>
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

        /// <summary>
        /// Obtiene todas las cuentas almacenadas en la base de datos.
        /// </summary>
        /// <returns>Una lista de objetos GetCuentaDto encapsulados en un ServiceResponse.</returns>
        [HttpGet("GetAll")]
        public async Task<ActionResult<ServiceResponse<List<GetCuentaDto>>>> Get()
        {
            return Ok(await _cuentaService.GetAllCuentas());
        }

        /// <summary>
        /// Obtiene una cuenta específica según el ID proporcionado.
        /// </summary>
        /// <param name="id">El ID de la cuenta a buscar.</param>
        /// <returns>Un objeto GetCuentaDto encapsulado en un ServiceResponse.</returns>
        [HttpGet("{id}")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> GetSingle(int id)
        {
            return Ok(await _cuentaService.GetCuentaById(id));
        }

        /// <summary>
        /// Agrega una nueva cuenta a la base de datos.
        /// </summary>
        /// <param name="newCuenta">Los detalles de la nueva cuenta a agregar.</param>
        /// <returns>Una lista de objetos GetCuentaDto encapsulados en un ServiceResponse.</returns>
        [HttpPost]
        public async Task<ActionResult<ServiceResponse<List<GetCuentaDto>>>> AddCuenta(AddCuentaDto newCuenta)
        {
            return Ok(await _cuentaService.AddCuenta(newCuenta));
        }

        /// <summary>
        /// Actualiza una cuenta existente en la base de datos.
        /// </summary>
        /// <param name="updatedCuenta">Los detalles actualizados de la cuenta a actualizar.</param>
        /// <returns>Una lista de objetos GetCuentaDto encapsulados en un ServiceResponse.</returns>
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

        /// <summary>
        /// Elimina una cuenta específica de la base de datos.
        /// </summary>
        /// <param name="id">El ID de la cuenta a eliminar.</param>
        /// <returns>Un objeto GetCuentaDto encapsulado en un ServiceResponse.</returns>
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

        /// <summary>
        /// Devuelve una actividad por su codigo.
        /// </summary>
        /// <param name="int">Entero con el codigo de la actividad.</param>
        /// <returns>Un ActionResult con un objeto ServiceResponse de tipo GetActividadDto.</returns>
        [HttpGet("getActividadByCodigo/{codigo}")]
        public async Task<ActionResult<ServiceResponse<GetActividadDto>>> GetActividadByCodigo(int codigo)
        {
            return Ok(await _cuentaService.GetActividadByCodigo(codigo));
        }

        /// <summary>
        /// Agrega una actividad a la cuenta especificada.
        /// </summary>
        /// <param name="newCuentaActividad">Objeto AddCuentaActividadDto con la información de la actividad a agregar.</param>
        /// <returns>Un ActionResult con un objeto ServiceResponse de tipo GetActividadDto.</returns>
        [HttpPost("AddCuentaActividades")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> AddCuentaActividades(AddCuentaActividadesDto newCuentaActividades)
        {
            return Ok(await _cuentaService.AddCuentaActividades(newCuentaActividades));
        }

        /// <summary>
        /// Obtiene la ubicación de una cuenta en base al código de ubicación proporcionado.
        /// </summary>
        /// <param name="codigoUbicacion">Código de ubicación de la cuenta.</param>
        /// <returns>Respuesta de servicio que incluye la ubicación de la cuenta.</returns>
        [AllowAnonymous]
        [HttpGet("Ubicacion/{codigoUbicacion}")]
        public async Task<ActionResult<ServiceResponse<GetUbicacionDto>>> GetUbicacion(string codigoUbicacion)
        {
            return Ok(await _cuentaService.GetUbicacion(codigoUbicacion));
        }

        /// <summary>
        /// Obtiene una lista de provincias con sus respectivos códigos de ubicación.
        /// </summary>
        /// <returns>Una respuesta de servicio que contiene la lista de provincias con sus códigos de ubicación.</returns>
        [AllowAnonymous]
        [HttpGet("UbicacionProvincias")]
        public async Task<ActionResult<ServiceResponse<List<GetUbicacionProvinciaDto>>>> GetUbicacionProvincias()
        {
            return Ok(await _cuentaService.GetUbicacionProvincias());
        }

        /// <summary>
        /// Obtiene una lista de cantones de una provincia específica.
        /// </summary>
        /// <param name="provincia">El código de la provincia.</param>
        /// <returns>Una respuesta HTTP con una lista de objetos GetUbicacionCantonDto.</returns>
        [AllowAnonymous]
        [HttpGet("UbicacionCantones")]
        public async Task<ActionResult<ServiceResponse<List<GetUbicacionCantonDto>>>> GetUbicacionCantones(int provincia)
        {
            return Ok(await _cuentaService.GetUbicacionCanton(provincia));
        }

        /// <summary>
        /// Obtiene una lista de objetos GetUbicacionDistritoDto que corresponden a los distritos en el cantón y provincia especificados.
        /// </summary>
        /// <param name="provincia">El id de la provincia de la que se desean obtener los distritos.</param>
        /// <param name="canton">El id del cantón del que se desean obtener los distritos.</param>
        /// <returns>Un ActionResult que contiene un objeto ServiceResponse que a su vez contiene una lista de objetos GetUbicacionDistritoDto.</returns>
        [AllowAnonymous]
        [HttpGet("UbicacionDistritos")]
        public async Task<ActionResult<ServiceResponse<List<GetUbicacionDistritoDto>>>> GetUbicacionDistritos(int provincia, int canton)
        {
            return Ok(await _cuentaService.GetUbicacionDistrito(provincia, canton));
        }

        /// <summary>
        /// Obtiene la lista de barrios correspondientes a un distrito en una provincia y cantón especificados.
        /// </summary>
        /// <param name="provincia">El código de la provincia a la que pertenece el distrito.</param>
        /// <param name="canton">El código del cantón al que pertenece el distrito.</param>
        /// <param name="distrito">El código del distrito del que se quieren obtener los barrios.</param>
        /// <returns>Un objeto ServiceResponse que contiene la lista de barrios correspondientes al distrito especificado.</returns>
        [AllowAnonymous]
        [HttpGet("UbicacionBarrios")]
        public async Task<ActionResult<ServiceResponse<List<GetUbicacionBarrioDto>>>> GetUbicacionBarrios(int provincia, int canton, int distrito)
        {
            return Ok(await _cuentaService.GetUbicacionBarrio(provincia, canton, distrito));
        }

        // SE DEBE QUITAR ES TEMPORAL, INSEGURO ----------------------------------------
        [AllowAnonymous]
        [HttpGet("cuentaTemporal/{nombreUsuario}/{id}")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> GetCuentaTemporal(string nombreUsuario, int id)
        {
            return Ok(await _cuentaService.GetCuentaTemporal(nombreUsuario, id));
        }

        [HttpGet("{id}/billing/qr")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> GetBillingCuentaQR(int id)
        {
            return Ok(await _cuentaService.GenerateBillingCuentaQr(id));
        }

        [HttpPost("billing/cuentabyqr")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> GetCuentaByQR(QrBody qrBody)
        {
            return Ok(await _cuentaService.GetCuentaByQR(qrBody.Codigo));
        }

        [HttpGet("{id}/share/qr")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> GetShareCuentaQR(int id)
        {
            return Ok(await _cuentaService.GenerateShareCuentaQr(id));
        }

        [HttpPost("share")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> ShareCuenta(QrBody qrBody)
        {
            return Ok(await _cuentaService.ShareCuenta(qrBody.Codigo));
        }

        [HttpPost("{id}/unshare")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> UnshareCuenta(int id)
        {
            return Ok(await _cuentaService.UnshareCuenta(id));
        }

        [HttpPost("{id}/unshare/{username}")]
        public async Task<ActionResult<ServiceResponse<GetCuentaDto>>> UnshareCuenta(int id, string username)
        {
            return Ok(await _cuentaService.UnshareCuenta(id, username));
        }
    }
}