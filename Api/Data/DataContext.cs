using Api.Models;
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
            VwCuentasUsuarios = Set<VwCuentasUsuarios>();
        }

        public virtual DbSet<Actividad> Actividades { get; set; }
        public virtual DbSet<Cuenta> Cuentas { get; set; }
        public virtual DbSet<Ubicacion> Ubicaciones { get; set; }
        public virtual DbSet<Usuario> Usuarios { get; set; }
        public virtual DbSet<VwCuentasUsuarios> VwCuentasUsuarios { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Apply entity configurations
            modelBuilder.ApplyConfiguration(new ActividadConfiguration());
            modelBuilder.ApplyConfiguration(new CuentaConfiguration());
            modelBuilder.ApplyConfiguration(new UbicacionConfiguration());
            modelBuilder.ApplyConfiguration(new UsuarioConfiguration());
            modelBuilder.ApplyConfiguration(new VwCuentasUsuariosConfiguration());
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

                entity.HasMany(d => d.CuentasCompartidas).WithMany(p => p.UsuariosCompartidos)
                    .UsingEntity<Dictionary<string, object>>(
                        "cuentascompartidas",
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

        public class VwCuentasUsuariosConfiguration : IEntityTypeConfiguration<VwCuentasUsuarios>
        {
            public void Configure(EntityTypeBuilder<VwCuentasUsuarios> builder)
            {
                builder.ToView("vw_cuentas_usuarios");
                builder.HasNoKey();
                // Map the view columns to the entity properties
                builder.Property(c => c.UsuarioId).HasColumnName("UsuarioId");
                builder.Property(c => c.UID).HasColumnName("UID");
                builder.Property(c => c.CuentaId).HasColumnName("CuentaId");
                builder.Property(c => c.Username).HasColumnName("Username");
                builder.Property(c => c.EsCompartida).HasColumnName("EsCompartida");
                builder.Property(c => c.CedulaTipo).HasColumnName("CedulaTipo");
                builder.Property(c => c.CedulaNumero).HasColumnName("CedulaNumero");
                builder.Property(c => c.IdExtranjero).HasColumnName("IdExtranjero");
                builder.Property(c => c.Nombre).HasColumnName("Nombre");
                builder.Property(c => c.NombreComercial).HasColumnName("NombreComercial");
                builder.Property(c => c.TelCodigoPais).HasColumnName("TelCodigoPais");
                builder.Property(c => c.TelNumero).HasColumnName("TelNumero");
                builder.Property(c => c.FaxCodigoPais).HasColumnName("FaxCodigoPais");
                builder.Property(c => c.FaxNumero).HasColumnName("FaxNumero");
                builder.Property(c => c.Correo).HasColumnName("Correo");
                builder.Property(c => c.UbicacionCodigo).HasColumnName("UbicacionCodigo");
                builder.Property(c => c.UbicacionSenas).HasColumnName("UbicacionSenas");
                builder.Property(c => c.UbicacionSenasExtranjero).HasColumnName("UbicacionSenasExtranjero");
                builder.Property(c => c.IsActive).HasColumnName("IsActive");
                builder.Property(c => c.Tipo).HasColumnName("Tipo");
            }
        }
    }
}