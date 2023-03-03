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
            modelBuilder.Entity<Ubicacion>()
             .HasKey(u => new { u.Provincia, u.Canton, u.Distrito, u.Barrio});
        }
        public DbSet<Usuario> Usuarios => Set<Usuario>();
        public DbSet<Cuenta> Cuentas => Set<Cuenta>();
        public DbSet<Actividad> Actividades => Set<Actividad>();
        public DbSet<Ubicacion> Ubicaciones => Set<Ubicacion>();
    }
}