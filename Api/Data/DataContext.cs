using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Api.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Actividad>().HasData(
                new Actividad { Id = 1, Codigo = "722003", Nombre = "DISEÑADOR GRAFICO, DE SOFWARE Y PAGINAS WEB" },
                new Actividad { Id = 2, Codigo = "721001", Nombre = "CONSULTORES INFORMÁTICOS" },
                new Actividad { Id = 3, Codigo = "503002", Nombre = "VENTA DE REPUESTOS USADOS PARA AUTOMOVILES" }
            );
        }

        public DbSet<Usuario> Usuarios => Set<Usuario>();
        public DbSet<Cuenta> Cuentas => Set<Cuenta>();
        public DbSet<Actividad> Actividades => Set<Actividad>();
    }
}