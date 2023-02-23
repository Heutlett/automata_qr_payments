using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Dtos.Cuenta;
using Api.Models;
using AutoMapper;

namespace dotnet_rpg
{
    public class AutoMapperProfiles : Profile
    {
        public AutoMapperProfiles()
        {
            CreateMap<Cuenta, GetCuentaDto>();
            CreateMap<AddCuentaDto, Cuenta>();
        }
    }
}