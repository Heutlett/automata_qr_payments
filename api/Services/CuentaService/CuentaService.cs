using System.Security.Claims;
using Api.Data;
using Api.Data.Dtos.Cuenta;
using Api.Data.Dtos.Cuenta.Ubicacion;
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

            // Iniciar transaccion
            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                // Crear la instancia de cuenta
                var cuenta = new Cuenta
                {
                    CedulaNumero = newCuenta.CedulaNumero,
                    CedulaTipo = newCuenta.CedulaTipo,
                    Correo = newCuenta.Correo,
                    FaxCodigoPais = newCuenta.FaxCodigoPais,
                    FaxNumero = newCuenta.FaxCodigoPais,
                    IdExtranjero = newCuenta.IdExtranjero,
                    Nombre = newCuenta.Nombre.ToUpper(),
                    NombreComercial = newCuenta.NombreComercial.ToUpper(),
                    TelCodigoPais = newCuenta.TelCodigoPais,
                    TelNumero = newCuenta.TelNumero,
                    Tipo = newCuenta.Tipo,
                    UbicacionCodigo = newCuenta.UbicacionCodigo,
                    UbicacionSenas = newCuenta.UbicacionSenas.ToUpper(),
                    UbicacionSenasExtranjero = newCuenta.UbicacionSenasExtranjero.ToUpper()
                };

                // Obtener el usuario correspondiente
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.UID == GetUserUid());
                if (usuario == null) throw new Exception($"Error agregando la cuenta.");
                cuenta.Usuario = usuario;

                // Agregar los codigos de actividad a la cuenta
                AddCodigosActividadCuenta(cuenta, newCuenta.CodigosActividad!);

                // Agregar la cuenta y guardar los cambios
                _context.Cuentas.Add(cuenta);

                // Guardar los cambios en la base de datos
                await _context.SaveChangesAsync();

                // Completar la transaccion
                await transaction.CommitAsync();

                // Devolver cuentas actualizadas
                var cuentas = await GetCuentas();
                serviceResponse.Data = cuentas;
            }
            catch (Exception ex)
            {
                // Manejar el error de alguna manera adecuada
                await transaction.RollbackAsync();

                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<List<GetCuentaDto>>> DeleteCuenta(int id)
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();

            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var cuenta = await _context.Cuentas
                    .Include(c => c.Usuario)
                    .Include(c => c.UsuariosCompartidos)
                    .FirstOrDefaultAsync(c => c.Id == id && c.Usuario!.UID == GetUserUid() && c.IsActive);

                if (cuenta is null || cuenta.Usuario!.UID != GetUserUid())
                    throw new Exception($"No se ha encontrado la cuenta con el Id '{id}'");

                cuenta.IsActive = false;
                cuenta.UsuariosCompartidos.Clear();

                await _context.SaveChangesAsync();


                await transaction.CommitAsync();

                var cuentas = GetCuentas();
                serviceResponse.Data = await cuentas;
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();

                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }
        private async Task<List<GetCuentaDto>> GetMyCuentas()
        {
            // Asume la existencia del usuario
            var dbMyCuentas = await _context.Cuentas
                .Include(c => c.CodigosActividad)
                .Include(c => c.UsuariosCompartidos)
                .Where(c => c.Usuario!.UID == GetUserUid() && c.IsActive)
                .ToListAsync();

            List<GetCuentaDto> myCuentas = _mapper.Map<List<GetCuentaDto>>(dbMyCuentas);

            foreach (var cuenta in myCuentas)
                cuenta.EsCompartida = false; // La cuenta es propia, por lo tanto no es compartida

            return myCuentas;
        }

        private async Task<List<GetCuentaDto>> GetSharedWithMeCuentas()
        {
            // Asume la existencia del usuario
            var dbSharedCuentas = await _context.Cuentas
                .Include(c => c.CodigosActividad)
                .Include(c => c.Usuario) // Include the Usuario for each shared account
                .Where(c => c.UsuariosCompartidos.Any(u => u!.UID == GetUserUid()) && c.IsActive)
                .ToListAsync();

            List<GetCuentaDto> sharedWithMeCuentas = _mapper.Map<List<GetCuentaDto>>(dbSharedCuentas);

            foreach (var cuenta in sharedWithMeCuentas)
                cuenta.EsCompartida = true; // La cuenta es compartida a mi

            return sharedWithMeCuentas;
        }

        private async Task<List<GetCuentaDto>> GetCuentas()
        {
            // Asume la existencia del usuario
            var myCuentas = await GetMyCuentas();
            var sharedWithMeCuentas = await GetSharedWithMeCuentas();
            var cuentas = myCuentas.Concat(sharedWithMeCuentas).ToList();
            return cuentas;
        }

        private async Task<GetCuentaDto?> GetMyCuenta(int id)
        {
            // Asume la existencia del usuario

            // Obtener la cuenta
            var cuentasDto = await GetMyCuentas();
            var cuenta = cuentasDto.FirstOrDefault(c => c.Id == id);
            return cuenta;
        }

        private async Task<GetCuentaDto?> GetCuenta(int id)
        {
            // Asume la existencia del usuario

            // Obtener la cuenta
            var cuentasDto = await GetCuentas();
            var cuenta = cuentasDto.FirstOrDefault(c => c.Id == id);
            return cuenta;
        }


        public async Task<ServiceResponse<List<GetCuentaDto>>> GetAllCuentas()
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();

            // Obtener el usuario actual
            var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.UID == GetUserUid());
            if (usuario == null) throw new Exception($"Usuario no encontrado.");

            // Obtener cuentas
            var cuentas = await GetCuentas();

            serviceResponse.Data = cuentas;

            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> GetCuentaById(int id)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();

            try
            {
                // Obtener la cuenta
                var cuenta = await GetCuenta(id);
                if (cuenta == null) throw new Exception("No se ha encontrado cuenta coincidente.");

                serviceResponse.Data = _mapper.Map<GetCuentaDto>(cuenta);
            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> UpdateCuenta(UpdateCuentaDto updatedCuenta)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();

            // Iniciar transaccion
            // using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var cuenta =
                    await _context.Cuentas
                    .Include(c => c.Usuario)
                    .Include(ca => ca.CodigosActividad)
                    .FirstOrDefaultAsync(c => c.Id == updatedCuenta.Id && c.IsActive);

                if (cuenta is null || cuenta.Usuario!.UID != GetUserUid())
                    throw new Exception($"No se ha encontrado la cuenta con el Id '{updatedCuenta.Id}'");

                cuenta.CedulaTipo = updatedCuenta.CedulaTipo;
                cuenta.CedulaNumero = updatedCuenta.CedulaNumero;
                cuenta.IdExtranjero = updatedCuenta.IdExtranjero;
                cuenta.Nombre = updatedCuenta.Nombre.ToUpper();
                cuenta.NombreComercial = updatedCuenta.NombreComercial.ToUpper();
                cuenta.TelCodigoPais = updatedCuenta.TelCodigoPais;
                cuenta.TelNumero = updatedCuenta.TelNumero;
                cuenta.FaxCodigoPais = updatedCuenta.FaxCodigoPais;
                cuenta.FaxNumero = updatedCuenta.FaxNumero;
                cuenta.Correo = updatedCuenta.Correo;
                cuenta.UbicacionCodigo = updatedCuenta.UbicacionCodigo;
                cuenta.UbicacionSenas = updatedCuenta.UbicacionSenas.ToUpper();
                cuenta.UbicacionSenasExtranjero = updatedCuenta.UbicacionSenasExtranjero.ToUpper();
                cuenta.Tipo = updatedCuenta.Tipo;

                // Limpiar los códigos de actividad de la cuenta.
                cuenta.CodigosActividad!.Clear();

                // Agregar los codigos de actividad a la cuenta
                AddCodigosActividadCuenta(cuenta, updatedCuenta.CodigosActividad!);

                // Guardar los cambios en la base de datos
                await _context.SaveChangesAsync();

                // Completar la transaccion
                // await transaction.CommitAsync();

                // Devolver cuentas actualizadas
                serviceResponse.Data = await GetCuenta(cuenta.Id);

            }

            catch (DbUpdateException ex)
            {
                // Devolver la transaccion
                // await transaction.RollbackAsync();

                serviceResponse.Success = false;
                serviceResponse.Message = "Error al guardar los cambios en la base de datos: " + ex.InnerException?.Message;
            }

            return serviceResponse;
        }

        private void AddCodigosActividadCuenta(Cuenta cuenta, List<string> codigosActividad)
        {
            // Agregar los códigos de actividad sin duplicados y los convierte a enteros
            List<int> codigos = codigosActividad.Distinct().Select(c => int.Parse(c)).ToList();

            // Iterar sobre los nuevos códigos de actividad y verifica si ya existen en la cuenta
            foreach (int codigo in codigos)
            {
                // Agregar el código de actividad a la cuenta
                cuenta.CodigosActividad!.Add(new CodigoActividadCuenta
                {
                    Codigo = codigo,
                    CuentaId = cuenta.Id
                });
            }
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

        public async Task<ServiceResponse<GetCuentaDto>> GetCuentaTemporal(string username, int id)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();
            var cuenta = await _context.Cuentas
                .Include(c => c.CodigosActividad)
                .FirstOrDefaultAsync(c => c.Id == id && c.Usuario!.Username == username && c.IsActive);
            serviceResponse.Data = _mapper.Map<GetCuentaDto>(cuenta);
            return serviceResponse;
        }


        private string GenerateCuentaQR(string type, int CuentaId)
        {
            var uid = GetUserUid();
            DateTime timestamp = DateTime.UtcNow;
            var secretKey = _configuration.GetSection("AppSettings:Token").Value!;
            string text = $"{type},{uid},{timestamp.ToString("s")},{CuentaId}";
            string code = Utils.AESEncryptionHelper.Encrypt(text, secretKey);

            return code;
        }

        public async Task<ServiceResponse<string>> GenerateBillingCuentaQr(int CuentaId)
        {
            var serviceResponse = new ServiceResponse<string>();
            try
            {
                // Validar la existencia de la cuenta dentro de todas las cuentas, titulares y compartidas conmigo
                var cuenta = await GetCuenta(CuentaId);
                if (cuenta == null) throw new Exception("No se ha encontrado cuenta coincidente.");

                serviceResponse.Data = GenerateCuentaQR("billing", CuentaId);
            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<string>> GenerateShareCuentaQr(int CuentaId)
        {
            var serviceResponse = new ServiceResponse<string>();
            try
            {
                // Validar la existencia de la cuenta dentro de las cuentas titulares
                var cuenta = await GetMyCuenta(CuentaId);
                if (cuenta == null) throw new Exception("No se ha encontrado cuenta coincidente.");

                serviceResponse.Data = GenerateCuentaQR("share", CuentaId);
            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> GetCuentaByQR(string encryptedcode)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();

            try
            {
                var secretKey = _configuration.GetSection("AppSettings:Token").Value!;
                string decryptedMessage = Utils.AESEncryptionHelper.Decrypt(encryptedcode, secretKey);

                // Extraer los datos originales de la cadena de texto
                string[] args = decryptedMessage.Split(',');
                var type = args[0];
                var UID = args[1];
                var timestamp = DateTime.Parse(args[2]);
                var CuentaId = int.Parse(args[3]);

                DateTime startTime = DateTime.UtcNow;
                TimeSpan duration = startTime.Subtract(timestamp);

                // Validar tipo de QR
                if (type != "billing") throw new Exception("Código inválido");

                // Validar el tiempo que ha pasado
                if (duration.TotalMinutes > _qrExpirationTime) throw new Exception($"El tiempo del codigo ha expirado.");

                // Validar la existencia de la cuenta dentro de todas las cuentas, titulares y compartidas conmigo
                var cuenta = await GetCuenta(CuentaId);
                if (cuenta == null) throw new Exception("No se ha encontrado cuenta coincidente.");

                // Quitar los usuarios compartidos, para conservar la privacidad
                cuenta.UsuariosCompartidos.Clear();

                serviceResponse.Data = _mapper.Map<GetCuentaDto>(cuenta);
            }
            catch (Exception ex)
            {
                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<GetCuentaDto>> ShareCuenta(string encryptedcode)
        {
            var serviceResponse = new ServiceResponse<GetCuentaDto>();

            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var secretKey = _configuration.GetSection("AppSettings:Token").Value!;
                string decryptedMessage = Utils.AESEncryptionHelper.Decrypt(encryptedcode, secretKey);

                // Extraer los datos originales de la cadena de texto
                string[] args = decryptedMessage.Split(',');
                var type = args[0];
                var UID = args[1];
                var timestamp = DateTime.Parse(args[2]);
                var CuentaId = int.Parse(args[3]);

                DateTime startTime = DateTime.UtcNow;
                TimeSpan duration = startTime.Subtract(timestamp);

                // Validar tipo de QR
                if (type != "share") throw new Exception("Código inválido");

                // Validar el tiempo que ha pasado
                if (duration.TotalMinutes > _qrExpirationTime) throw new Exception($"El tiempo del codigo ha expirado.");

                // Obtener y validar la existencia del usuario actual
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.UID == GetUserUid());
                if (usuario == null)
                    throw new Exception("No se encontró ningún usuario.");

                // Obtener y validar la existencia de la cuenta
                var cuenta = await _context.Cuentas.FirstOrDefaultAsync(c => c.Id == CuentaId && c.IsActive);
                if (cuenta == null)
                    throw new Exception("No se encontró ninguna cuenta activa coincidente.");

                // Analizar si el usuario actual ya es propietario de la cuenta
                if (UID == usuario.UID)
                    throw new Exception("Usted ya es propietario de esta cuenta.");

                // Verificar si el usuario ya existe en la colección Usuarios de la Cuenta
                if (await _context.Cuentas.AnyAsync(c => c.Id == CuentaId && c.UsuariosCompartidos.Any(u => u.Id == usuario.Id)))
                    throw new Exception("Esta cuenta ya ha sido previamente registrada.");

                // Agregar el Usuario a la colección Usuarios de la Cuenta
                cuenta.UsuariosCompartidos.Add(usuario);

                // Guardar los cambios en la base de datos
                await _context.SaveChangesAsync();

                await transaction.CommitAsync();

                // Devolver cuentas actualizadas
                var cuentaResponse = await GetCuenta(cuenta.Id);
                serviceResponse.Data = cuentaResponse;
            }
            catch (DbUpdateException ex)
            {
                await transaction.RollbackAsync();

                serviceResponse.Success = false;
                serviceResponse.Message = "Error al guardar los cambios en la base de datos: " + ex.InnerException?.Message;
            }

            return serviceResponse;
        }


        public async Task<ServiceResponse<List<GetCuentaDto>>> UnshareCuenta(int id)
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();

            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                // Obtener y validar la existencia del usuario actual
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.UID == GetUserUid());
                if (usuario == null)
                    throw new Exception("No se encontró ningún usuario.");

                // Obtener la cuenta y verificar si el usuario existe en la colección Usuarios de la Cuenta
                var cuenta = await _context.Cuentas.Include(c => c.UsuariosCompartidos).FirstOrDefaultAsync(c => c.Id == id && c.IsActive && c.UsuariosCompartidos.Any(u => u.Id == usuario.Id));
                if (cuenta == null)
                    throw new Exception($"No se ha encontrado ninguna cuenta coincidente.");

                // Eliminar el Usuario de la colección Usuarios de la Cuenta
                cuenta.UsuariosCompartidos.Remove(usuario);

                // Guardar los cambios en la base de datos
                await _context.SaveChangesAsync();

                await transaction.CommitAsync();

                // Retornar cuentas
                var cuentas = await GetCuentas();
                serviceResponse.Data = cuentas;
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();

                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

        public async Task<ServiceResponse<List<GetCuentaDto>>> UnshareCuenta(int id, string username)
        {
            var serviceResponse = new ServiceResponse<List<GetCuentaDto>>();

            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                // Obtener el usuario a eliminar
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.Username == username);
                if (usuario == null)
                    throw new Exception($"Usuario no encontrado.");

                // Obtener la cuenta y verificar si el usuario existe en la colección Usuarios de la Cuenta
                var cuenta = await _context.Cuentas.Include(c => c.UsuariosCompartidos).FirstOrDefaultAsync(c => c.Id == id && c.IsActive && c.UsuariosCompartidos.Any(u => u.Id == usuario.Id));
                if (cuenta == null)
                    throw new Exception($"No se ha encontrado ninguna cuenta coincidente.");

                // Eliminar el Usuario de la colección Usuarios de la Cuenta
                cuenta.UsuariosCompartidos.Remove(usuario);

                // Guardar los cambios en la base de datos
                await _context.SaveChangesAsync();

                await transaction.CommitAsync();

                // Retornar cuentas
                var cuentas = await GetCuentas();
                serviceResponse.Data = cuentas;
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();

                serviceResponse.Success = false;
                serviceResponse.Message = ex.Message;
            }

            return serviceResponse;
        }

    }
}