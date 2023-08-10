using Api.Data.Dtos.Cuenta;
using Api.Data.Dtos.Cuenta.Ubicacion;
using Api.Data.Dtos.Usuario;
using Api.Models;
using AutoMapper;

namespace Api
{
    public class AutoMapperProfiles : Profile
    {
        public AutoMapperProfiles()
        {

            CreateMap<Cuenta, GetCuentaDto>()
                .ForMember(dest => dest.CodigosActividad, opt => opt.MapFrom(src => src.CodigosActividad.Select(ca => ca.Codigo.ToString()).ToList()))
                .ForMember(dest => dest.UsuariosCompartidos, opt => opt.MapFrom(src => src.UsuariosCompartidos.Select(u => new UsuarioCompartidoDto
                {
                    NombreCompleto = u.NombreCompleto,
                    Username = u.Username
                }).ToList()));

            CreateMap<AddCuentaDto, Cuenta>();
            CreateMap<Ubicacion, GetUbicacionDto>();
            CreateMap<Ubicacion, GetUbicacionProvinciaDto>();
            CreateMap<Ubicacion, GetUbicacionCantonDto>();
            CreateMap<Ubicacion, GetUbicacionDistritoDto>();
            CreateMap<Ubicacion, GetUbicacionBarrioDto>();
        }
    }
}