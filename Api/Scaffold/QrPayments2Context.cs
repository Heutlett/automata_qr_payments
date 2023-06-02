using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
// #nullable disable

namespace Api.Scaffold;

public partial class QrPayments2Context : DbContext
{

    public QrPayments2Context(DbContextOptions<QrPayments2Context> options)
        : base(options)
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

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        // => optionsBuilder.UseMySQL("Name=ConnectionStrings:DefaultConnection");
        => optionsBuilder.UseMySQL("Name=ConnectionStrings:DefaultConnection", builder =>
        {
            builder.EnableRetryOnFailure(3); // Habilita los intentos de conexión en caso de errores
        });

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Actividad>(entity =>
        {
            entity.HasKey(e => e.Codigo).HasName("PRIMARY");

            entity.ToTable("actividades");

            entity.HasMany(d => d.Cuentas).WithMany(p => p.Actividades)
                .UsingEntity<Dictionary<string, object>>(
                    "ActividadCuenta",
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
        });

        modelBuilder.Entity<Cuenta>(entity =>
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
        });

        modelBuilder.Entity<Ubicacion>(entity =>
        {
            entity.HasKey(e => new { e.Provincia, e.Canton, e.Distrito, e.Barrio }).HasName("PRIMARY");

            entity.ToTable("ubicaciones");
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("usuarios");

            entity.HasIndex(e => e.Username, "Username").IsUnique();

            entity.Property(e => e.Email).HasMaxLength(160);
            entity.Property(e => e.Uid)
                .HasMaxLength(36)
                .HasColumnName("UID");
            entity.Property(e => e.Username).HasMaxLength(20);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
