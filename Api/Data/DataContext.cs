using Api.Scaffold;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Api.Data
{

    public class DataContext : DbContext
    {

        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
            Actividades = Set<Actividad>();
            Cuentas = Set<Cuenta>();
            Ubicaciones = Set<Ubicacion>();
            Usuarios = Set<Usuario>();
        }

        public virtual DbSet<Actividad> Actividades { get; set; }
        public virtual DbSet<Cuenta> Cuentas { get; set; }
        public virtual DbSet<Ubicacion> Ubicaciones { get; set; }
        public virtual DbSet<Usuario> Usuarios { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Apply entity configurations
            modelBuilder.ApplyConfiguration(new ActividadConfiguration());
            modelBuilder.ApplyConfiguration(new CuentaConfiguration());
            modelBuilder.ApplyConfiguration(new UbicacionConfiguration());
            modelBuilder.ApplyConfiguration(new UsuarioConfiguration());
        }

        public class ActividadConfiguration : IEntityTypeConfiguration<Actividad>
        {
            public void Configure(EntityTypeBuilder<Actividad> builder)
            {
                builder.HasKey(e => e.Codigo).HasName("PRIMARY");
                builder.ToTable("actividades");
                // Configure many-to-many relationship with Cuenta entity
                builder.HasMany(a => a.Cuentas)
                    .WithMany(c => c.Actividades)
                    .UsingEntity<Dictionary<string, object>>(
                        "actividadcuenta",
                        r => r.HasOne<Cuenta>().WithMany()
                            .HasForeignKey("CuentasId")
                            .HasConstraintName("FK_ActividadCuenta_Cuentas_CuentasId"),
                        l => l.HasOne<Actividad>().WithMany()
                            .HasForeignKey("ActividadesCodigo")
                            .HasConstraintName("FK_ActividadCuenta_Actividades_ActividadesCodigo"),
                        j =>
                        {
                            j.HasKey("ActividadesCodigo", "CuentasId").HasName("PRIMARY");
                            j.ToTable("actividadcuenta");
                            j.HasIndex(new[] { "CuentasId" }, "IX_ActividadCuenta_CuentasId");
                        });
            }
        }

        public class CuentaConfiguration : IEntityTypeConfiguration<Cuenta>
        {
            public void Configure(EntityTypeBuilder<Cuenta> entity)
            {
                entity.HasKey(e => e.Id).HasName("PRIMARY");
                entity.ToTable("cuentas");

                entity.HasIndex(e => e.UsuarioId, "IX_Cuentas_UsuarioId");

                entity.Property(e => e.CedulaNumero).HasMaxLength(12);
                entity.Property(e => e.Correo).HasMaxLength(160);
                entity.Property(e => e.FaxCodigoPais).HasMaxLength(3);
                entity.Property(e => e.FaxNumero).HasMaxLength(20);
                entity.Property(e => e.IdExtranjero).HasMaxLength(20);
                entity.Property(e => e.Nombre).HasMaxLength(100);
                entity.Property(e => e.NombreComercial).HasMaxLength(80);
                entity.Property(e => e.TelCodigoPais).HasMaxLength(3);
                entity.Property(e => e.TelNumero).HasMaxLength(20);
                entity.Property(e => e.UbicacionCodigo).HasMaxLength(7);
                entity.Property(e => e.UbicacionSenas).HasMaxLength(160);
                entity.Property(e => e.UbicacionSenasExtranjero).HasMaxLength(300);

                entity.HasOne(d => d.Usuario).WithMany(p => p.Cuenta)
                    .HasForeignKey(d => d.UsuarioId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Cuentas_Usuarios_UsuarioId");
            }
        }

        public class UbicacionConfiguration : IEntityTypeConfiguration<Ubicacion>
        {
            public void Configure(EntityTypeBuilder<Ubicacion> entity)
            {
                entity.HasKey(e => new { e.Provincia, e.Canton, e.Distrito, e.Barrio }).HasName("PRIMARY");
                entity.ToTable("ubicaciones");
            }
        }

        public class UsuarioConfiguration : IEntityTypeConfiguration<Usuario>
        {
            public void Configure(EntityTypeBuilder<Usuario> entity)
            {
                entity.HasKey(e => e.Id).HasName("PRIMARY");
                entity.ToTable("usuarios");

                entity.HasIndex(e => e.Username, "Username").IsUnique();

                entity.Property(e => e.Email).HasMaxLength(160);
                entity.Property(e => e.UID)
                    .HasMaxLength(36)
                    .HasColumnName("UID");
                entity.Property(e => e.Username).HasMaxLength(20);

                entity.HasMany(d => d.CuentasCompartidas).WithMany(p => p.Usuarios)
                    .UsingEntity<Dictionary<string, object>>(
                        "Cuentascompartida",
                        r => r.HasOne<Cuenta>().WithMany()
                            .HasForeignKey("CuentaCompartidaId")
                            .HasConstraintName("FK_CuentasCompartidas_Cuentas_CuentaCompartidaId"),
                        l => l.HasOne<Usuario>().WithMany()
                            .HasForeignKey("UsuarioId")
                            .HasConstraintName("FK_CuentasCompartidas_Usuarios_UsuarioId"),
                        j =>
                        {
                            j.HasKey("UsuarioId", "CuentaCompartidaId").HasName("PRIMARY");
                            j.ToTable("cuentascompartidas");
                            j.HasIndex(new[] { "CuentaCompartidaId" }, "IX_CuentasCompartidas_CuentaCompartidaId");
                        });
            }
        }
    }
}