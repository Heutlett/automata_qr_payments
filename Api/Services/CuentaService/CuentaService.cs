using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Api.Data;
using Api.Dtos.Cuenta;
using Api.Dtos.Cuenta.Ubicacion;
using Api.Scaffold;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace Api.Services.CuentaService
{
    public class CuentaService : ICuentaService
    {
        private readonly IMapper _mapper;
        private readonly DataContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IConfiguration _configuration;

        private readonly double _qrExpirationTime = 1;

        public CuentaService(IMapper mapper, DataContext context, IHttpContextAccessor httpContextAccessor, IConfiguration configuration)
        {
            _configuration = configuration;
            _httpContextAccessor = httpContextAccessor;
            _mapper = mapper;
            _context = context;
        }

        private string GetUserUid() => _httpContextAccessor.HttpContext!.User
            .FindFirstValue(ClaimTypes.NameIdentifier)!;

        public async Task<ServiceResponse<List<GetCuentaDto>>> AddCuenta(AddCuentaDto newCuenta)
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();
            var cuenta =
                new Cuenta
                {
                    CedulaNumero = newCuenta.CedulaNumero,
                    CedulaTipo = newCuenta.CedulaTipo,
                    Correo = newCuenta.Correo,
                    FaxCodigoPais = newCuenta.FaxCodigoPais,
                    FaxNumero = newCuenta.FaxCodigoPais,
                    IdExtranjero = newCuenta.IdExtranjero,
                    Nombre = newCuenta.Nombre,
                    NombreComercial = newCuenta.NombreComercial,
                    TelCodigoPais = newCuenta.TelCodigoPais,
                    TelNumero = newCuenta.TelNumero,
                    Tipo = newCuenta.Tipo,
                    UbicacionCodigo = newCuenta.UbicacionCodigo,
                    UbicacionSenas = newCuenta.UbicacionSenas,
                    UbicacionSenasExtranjero = newCuenta.UbicacionSenasExtranjero
                };

            var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.UID == GetUserUid());
            if (usuario == null)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = "Error agregando la cuenta.";
                return serviceResponse;
            }
            cuenta.Usuario = usuario;

            _context.Cuentas.Add(cuenta); // (No es Async) Aun no se llama la db, solo se agrega un Cuenta al dataContext
            await _context.SaveChangesAsync();  // Aqui es donde ya se envia a la db (Async)

            var actividades = newCuenta.actividades!;

            var addCuentaActividades = new AddCuentaActividadesDto { CuentaId = cuenta.Id, ActividadesId = actividades };

            await AddCuentaActividades(addCuentaActividades);

            serviceResponse.Data =
                await _context.Cuentas
                    .Where(c => c.Usuario!.UID == GetUserUid())
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
                    .FirstOrDefaultAsync(c => c.Id == id && c.Usuario!.UID == GetUserUid() && c.IsActive);

                if (cuenta is null || cuenta.Usuario!.UID != GetUserUid())
                    throw new Exception($"No se ha encontrado la cuenta con el Id '{id}'");

                cuenta.IsActive = false;
                await _context.SaveChangesAsync();

                serviceResponse.Data =
                    await _context.Cuentas
                        .Where(c => c.Usuario!.UID == GetUserUid() && c.IsActive)
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
                .Include(c => c.Actividades)
                .Where(c => c.Usuario!.UID == GetUserUid() && c.IsActive).ToListAsync();

            serviceResponse.Data = dbCuentas.Select(c => _mapper.Map<GetCuentaDto>(c)).ToList();
            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> GetCuentaById(int id)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();
            var dbCuenta = await _context.Cuentas
                .Include(c => c.Actividades)
                .FirstOrDefaultAsync(c => c.Id == id && c.Usuario!.UID == GetUserUid() && c.IsActive);
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

                if (cuenta is null || cuenta.Usuario!.UID != GetUserUid())
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
            catch (DbUpdateException ex)
            {
                serviceResponse.Success = false;
                // serviceResponse.Message = ex.Message;
                serviceResponse.Message = "Error al guardar los cambios en la base de datos: " + ex.InnerException?.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<GetActividadDto>> GetActividadByCodigo(int codigo)
        {
            var response = new ServiceResponse<GetActividadDto>();

            try
            {
                var actividad = await _context.Actividades
                    .FirstOrDefaultAsync(s => s.Codigo == codigo);

                if (actividad is null)
                {
                    throw new Exception($"No se ha encontrado la actividad con el codigo {codigo}.");
                }

                actividad.Nombre = actividad.Nombre.ToUpper();

                response.Data = _mapper.Map<GetActividadDto>(actividad);

            }
            catch (Exception ex)
            {
                response.Success = false;
                response.Message = ex.Message;
            }

            return response;
        }
        public async Task<ServiceResponse<GetCuentaDto>> AddCuentaActividades(AddCuentaActividadesDto newCuentaActividades)
        {
            var response = new ServiceResponse<GetCuentaDto>();
            try
            {
                var cuenta = await _context.Cuentas
                    .Include(c => c.Actividades)
                    .FirstOrDefaultAsync(c => c.Id == newCuentaActividades.CuentaId &&
                    c.Usuario!.UID == GetUserUid());

                if (cuenta is null)
                {
                    throw new Exception($"No se ha encontrado la cuenta.");
                }
                for (int i = 0; i < newCuentaActividades.ActividadesId.Count; i++)
                {
                    var actividad = await _context.Actividades
                    .FirstOrDefaultAsync(s => s.Codigo == newCuentaActividades.ActividadesId[i]);

                    if (actividad is null)
                    {
                        throw new Exception($"No se ha encontrado la actividad.");
                    }

                    var isRepeated = cuenta.Actividades!.Contains(actividad);

                    if (isRepeated)
                    {
                        throw new Exception($"La actividad economica {actividad.Nombre} ya se encuentra registrada en esta cuenta.");
                    }
                    actividad.Nombre = actividad.Nombre.ToUpper();
                    cuenta.Actividades!.Add(actividad);
                    await _context.SaveChangesAsync();
                    response.Data = _mapper.Map<GetCuentaDto>(cuenta);
                }
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.Message = ex.Message;
            }

            return response;
        }

        public async Task<ServiceResponse<GetUbicacionDto>> GetUbicacion(string codigoUbicacion)
        {
            var response = new ServiceResponse<GetUbicacionDto>();

            try
            {
                int codigoProvincia = int.Parse(codigoUbicacion.Substring(0, 1));
                int codigoCanton = int.Parse(codigoUbicacion.Substring(1, 2));
                int codigoDistrito = int.Parse(codigoUbicacion.Substring(3, 2));
                int codigoBarrio = int.Parse(codigoUbicacion.Substring(5, 2));

                var ubicacion = await _context.Ubicaciones
                    .FirstOrDefaultAsync(u => u.Provincia == codigoProvincia &&
                                u.Canton == codigoCanton &&
                                u.Distrito == codigoDistrito &&
                                u.Barrio == codigoBarrio);

                if (ubicacion is null)
                    throw new Exception($"No se ha encontrado la ubicacion con el codigo '{codigoUbicacion}'");

                response.Data = _mapper.Map<GetUbicacionDto>(ubicacion);
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.Message = ex.Message;
            }

            return response;
        }

        public async Task<ServiceResponse<List<GetUbicacionProvinciaDto>>> GetUbicacionProvincias()
        {
            var response = new ServiceResponse<List<GetUbicacionProvinciaDto>>();

            try
            {
                var provincias = await _context.Ubicaciones
                    .Select(u => new GetUbicacionProvinciaDto { Provincia = u.Provincia, NombreProvincia = u.NombreProvincia })
                    .Distinct()
                    .ToListAsync();

                if (provincias is null)
                    throw new Exception($"No se han encontrado provincias.");

                response.Data = provincias;
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.Message = ex.Message;
            }

            return response;
        }

        public async Task<ServiceResponse<List<GetUbicacionCantonDto>>> GetUbicacionCanton(int provincia)
        {
            var response = new ServiceResponse<List<GetUbicacionCantonDto>>();

            try
            {
                var cantones = await _context.Ubicaciones
                    .Where(u => u.Provincia == provincia)
                    .Select(u => new GetUbicacionCantonDto { Canton = u.Canton, NombreCanton = u.NombreCanton })
                    .Distinct()
                    .ToListAsync();

                if (cantones is null)
                    throw new Exception($"No se han encontrado cantones.");

                response.Data = cantones;
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.Message = ex.Message;
            }

            return response;
        }

        public async Task<ServiceResponse<List<GetUbicacionDistritoDto>>> GetUbicacionDistrito(int provincia, int canton)
        {
            var response = new ServiceResponse<List<GetUbicacionDistritoDto>>();

            try
            {
                var distritos = await _context.Ubicaciones
                    .Where(u => u.Provincia == provincia && u.Canton == canton)
                    .Select(u => new GetUbicacionDistritoDto { Distrito = u.Distrito, NombreDistrito = u.NombreDistrito })
                    .Distinct()
                    .ToListAsync();

                if (distritos is null)
                    throw new Exception($"No se han encontrado distritos.");

                response.Data = distritos;
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.Message = ex.Message;
            }

            return response;
        }

        public async Task<ServiceResponse<List<GetUbicacionBarrioDto>>> GetUbicacionBarrio(int provincia, int canton, int distrito)
        {
            var response = new ServiceResponse<List<GetUbicacionBarrioDto>>();

            try
            {
                var barrios = await _context.Ubicaciones
                    .Where(u => u.Provincia == provincia && u.Canton == canton && u.Distrito == distrito)
                    .Select(u => new GetUbicacionBarrioDto { Barrio = u.Barrio, NombreBarrio = u.NombreBarrio })
                    .Distinct()
                    .ToListAsync();

                if (barrios is null)
                    throw new Exception($"No se han encontrado barrios.");

                response.Data = barrios;
            }
            catch (Exception ex)
            {
                response.Success = false;
                response.Message = ex.Message;
            }

            return response;
        }

        public async Task<ServiceResponse<GetCuentaDto>> GetCuentaTemporal(string nombreUsuario, int id)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();
            var dbCuenta = await _context.Cuentas
                .Include(c => c.Actividades)
                .FirstOrDefaultAsync(c => c.Id == id && c.Usuario!.Username == nombreUsuario && c.IsActive);
            serviceResponse.Data = _mapper.Map<GetCuentaDto>(dbCuenta);
            return serviceResponse;
        }

        public async Task<ServiceResponse<string>> GenerateCuentaQr(int idCuenta)
        {
            var serviceResponse = new ServiceResponse<string>();

            try
            {
                var cuenta = await _context.Cuentas
                .FirstOrDefaultAsync(c => c.Id == idCuenta && c.Usuario!.UID == GetUserUid() && c.IsActive);

                if (cuenta is null)
                    throw new Exception($"No se han encontrado la cuenta.");

                var uid = GetUserUid();

                DateTime timestamp = DateTime.UtcNow;

                var secretKey = _configuration.GetSection("AppSettings:Token").Value!;

                string texto = $"{uid},{timestamp.ToString("s")},{idCuenta}";

                string mensajeEncriptado = EncriptarMensaje(texto, secretKey);

                serviceResponse.Data = mensajeEncriptado;
            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> GetCuentaByQR(string codigoEncriptado)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();

            try
            {
                var secretKey = _configuration.GetSection("AppSettings:Token").Value!;

                string mensajeDesencriptado = DesencriptarMensaje(codigoEncriptado, secretKey);

                // Extraer los datos originales de la cadena de texto
                string[] partes = mensajeDesencriptado.Split(',');
                var uid = partes[0];
                var timestamp = DateTime.Parse(partes[1]);
                var idCuenta = int.Parse(partes[2]);

                DateTime startTime = DateTime.UtcNow;

                TimeSpan duration = startTime.Subtract(timestamp);

                // Validar el tiempo que ha pasado
                if (duration.TotalMinutes > _qrExpirationTime)
                {
                    throw new Exception($"El tiempo del codigo ha expirado.");
                }

                // Validar la existencia de la cuenta
                var cuenta = await _context.Cuentas
                    .Include(c => c.Actividades)
                    .FirstOrDefaultAsync(c => c.Id == idCuenta && c.Usuario!.UID == uid && c.IsActive);

                if (cuenta is null)
                    throw new Exception($"El codigo no pertenece a una cuenta.");

                // Modificar en la tabla de compartir cuenta
                serviceResponse.Data = _mapper.Map<GetCuentaDto>(cuenta);

            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }


        // Método para encriptar un mensaje
        public static string EncriptarMensaje(string mensaje, string clave)
        {
            byte[] mensajeBytes = Encoding.UTF8.GetBytes(mensaje);
            byte[] claveBytes = Encoding.UTF8.GetBytes(clave.PadRight(32, '0').Substring(0, 32)); // Utiliza una clave de 256 bits (32 bytes)


            Aes aes = Aes.Create();
            aes.Key = claveBytes;
            aes.IV = new byte[aes.BlockSize / 8];

            ICryptoTransform encriptador = aes.CreateEncryptor();

            byte[] mensajeEncriptadoBytes = encriptador.TransformFinalBlock(mensajeBytes, 0, mensajeBytes.Length);
            string mensajeEncriptado = Convert.ToBase64String(mensajeEncriptadoBytes);

            return mensajeEncriptado;
        }

        // Método para desencriptar un mensaje
        public static string DesencriptarMensaje(string mensajeEncriptado, string clave)
        {
            byte[] mensajeEncriptadoBytes = Convert.FromBase64String(mensajeEncriptado);
            byte[] claveBytes = Encoding.UTF8.GetBytes(clave.PadRight(32, '0').Substring(0, 32)); // Utiliza una clave de 256 bits (32 bytes)


            Aes aes = Aes.Create();
            aes.Key = claveBytes;
            aes.IV = new byte[aes.BlockSize / 8];

            ICryptoTransform desencriptador = aes.CreateDecryptor();

            byte[] mensajeDesencriptadoBytes = desencriptador.TransformFinalBlock(mensajeEncriptadoBytes, 0, mensajeEncriptadoBytes.Length);
            string mensajeDesencriptado = Encoding.UTF8.GetString(mensajeDesencriptadoBytes);

            return mensajeDesencriptado;
        }

        // public async Task<ServiceResponse<GetCuentaDto>> ShareCuentaByQR(string codigoEncriptado)
        // {
        //     var serviceResponse = new ServiceResponse<GetCuentaDto>();

        //     try
        //     {
        //         var secretKey = _configuration.GetSection("AppSettings:Token").Value!;

        //         string mensajeDesencriptado = DesencriptarMensaje(codigoEncriptado, secretKey);

        //         // Extraer los datos originales de la cadena de texto
        //         string[] partes = mensajeDesencriptado.Split(',');
        //         var uid = partes[0];
        //         var timestamp = DateTime.Parse(partes[1]);
        //         var idCuenta = int.Parse(partes[2]);

        //         DateTime startTime = DateTime.UtcNow;

        //         TimeSpan duration = startTime.Subtract(timestamp);

        //         // Validar el tiempo que ha pasado
        //         if (duration.TotalMinutes > _qrExpirationTime)
        //         {
        //             throw new Exception($"El tiempo del codigo ha expirado.");
        //         }


        //         // Crear relacion
        //         // var cuentaCompartida = new CuentaCompartida();
        //         // cuentaCompartida.Usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.UID == uid);
        //         // cuentaCompartida.Cuenta = await _context.Cuentas
        //         //     .Include(c => c.Actividades)
        //         //     .FirstOrDefaultAsync(c => c.Id == idCuenta && c.Usuario!.UID == uid && c.IsActive);

        //         // if (cuentaCompartida.Usuario is null)
        //         //     throw new Exception($"El codigo no pertenece a ningun usuario.");

        //         // if (cuentaCompartida.Cuenta is null)
        //         //     throw new Exception($"El codigo no pertenece a una cuenta.");

        //         // _context.CuentasCompartidas.Add(cuentaCompartida); // (No es Async) Aun no se llama la db, solo se agrega un Cuenta al dataContext
        //         // await _context.SaveChangesAsync();  // Aqui es donde ya se envia a la db (Async)

        //         // serviceResponse.Data = _mapper.Map<GetCuentaDto>(.Cuenta);
        //     }

        //     catch (Exception ex)
        //     {
        //         serviceResponse.Success = false;
        //         serviceResponse.Message = ex.Message;
        //     }

        //     return serviceResponse;
        // }
    }
}