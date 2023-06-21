using Api.Dtos.Cuenta;
using Api.Dtos.Cuenta.Ubicacion;
using Api.Models;
using AutoMapper;

namespace Api
{
    public class AutoMapperProfiles : Profile
    {
        public AutoMapperProfiles()
        {
            CreateMap<Cuenta, GetCuentaDto>();
            CreateMap<AddCuentaDto, Cuenta>();
            CreateMap<Actividad, GetActividadDto>();
            CreateMap<Ubicacion, GetUbicacionDto>();
            CreateMap<Ubicacion, GetUbicacionProvinciaDto>();
            CreateMap<Ubicacion, GetUbicacionCantonDto>();
            CreateMap<Ubicacion, GetUbicacionDistritoDto>();
            CreateMap<Ubicacion, GetUbicacionBarrioDto>();

            CreateMap<VwCuentasUsuarios, GetCuentaDto>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.CuentaId))
                .ForMember(dest => dest.CedulaTipo, opt => opt.MapFrom(src => (TipoIdentificacion)src.CedulaTipo))
                .ForMember(dest => dest.Tipo, opt => opt.MapFrom(src => (TipoCuenta)src.Tipo))
                .ForMember(dest => dest.Actividades, opt => opt.Ignore()) // Se asignará en el servicio
                .ForMember(dest => dest.UsuariosCompartidos, opt => opt.Ignore()); // Se asignará en el servicio

        }
    }
}