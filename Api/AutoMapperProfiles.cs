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

            CreateMap<Cuenta, GetCuentaDto>()
                .ForMember(dest => dest.UsuariosCompartidos, opt => opt.MapFrom(src => src.UsuariosCompartidos.Select(u => u.Username).ToList()));

        }
    }
}