﻿// <auto-generated />
using System;
using Api.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace Api.Migrations
{
    [DbContext(typeof(DataContext))]
    partial class DataContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.3")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("ActividadCuenta", b =>
                {
                    b.Property<int>("ActividadesCodigo")
                        .HasColumnType("int");

                    b.Property<int>("CuentasId")
                        .HasColumnType("int");

                    b.HasKey("ActividadesCodigo", "CuentasId");

                    b.HasIndex("CuentasId");

                    b.ToTable("ActividadCuenta");
                });

            modelBuilder.Entity("Api.Models.Actividad", b =>
                {
                    b.Property<int>("Codigo")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.HasKey("Codigo");

                    b.ToTable("Actividades");
                });

            modelBuilder.Entity("Api.Models.Cuenta", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("CedulaNumero")
                        .IsRequired()
                        .HasMaxLength(12)
                        .HasColumnType("varchar(12)");

                    b.Property<int>("CedulaTipo")
                        .HasColumnType("int");

                    b.Property<string>("Correo")
                        .IsRequired()
                        .HasMaxLength(160)
                        .HasColumnType("varchar(160)");

                    b.Property<string>("FaxCodigoPais")
                        .IsRequired()
                        .HasMaxLength(3)
                        .HasColumnType("varchar(3)");

                    b.Property<string>("FaxNumero")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("varchar(20)");

                    b.Property<string>("IdExtranjero")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("varchar(20)");

                    b.Property<bool>("IsActive")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("NombreComercial")
                        .IsRequired()
                        .HasMaxLength(80)
                        .HasColumnType("varchar(80)");

                    b.Property<string>("TelCodigoPais")
                        .IsRequired()
                        .HasMaxLength(3)
                        .HasColumnType("varchar(3)");

                    b.Property<string>("TelNumero")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("varchar(20)");

                    b.Property<int>("Tipo")
                        .HasColumnType("int");

                    b.Property<string>("UbicacionCodigo")
                        .IsRequired()
                        .HasMaxLength(7)
                        .HasColumnType("varchar(7)");

                    b.Property<string>("UbicacionSenas")
                        .IsRequired()
                        .HasMaxLength(160)
                        .HasColumnType("varchar(160)");

                    b.Property<string>("UbicacionSenasExtranjero")
                        .IsRequired()
                        .HasMaxLength(300)
                        .HasColumnType("varchar(300)");

                    b.Property<int?>("UsuarioId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UsuarioId");

                    b.ToTable("Cuentas");
                });

            modelBuilder.Entity("Api.Models.Ubicacion", b =>
                {
                    b.Property<int>("Provincia")
                        .HasColumnType("int");

                    b.Property<int>("Canton")
                        .HasColumnType("int");

                    b.Property<int>("Distrito")
                        .HasColumnType("int");

                    b.Property<int>("Barrio")
                        .HasColumnType("int");

                    b.Property<string>("NombreBarrio")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<string>("NombreCanton")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<string>("NombreDistrito")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<string>("NombreProvincia")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.HasKey("Provincia", "Canton", "Distrito", "Barrio");

                    b.ToTable("Ubicaciones");
                });

            modelBuilder.Entity("Api.Models.Usuario", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(160)
                        .HasColumnType("varchar(160)");

                    b.Property<byte[]>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("longblob");

                    b.Property<byte[]>("PasswordSalt")
                        .IsRequired()
                        .HasColumnType("longblob");

                    b.Property<int>("Rol")
                        .HasColumnType("int");

                    b.Property<string>("UID")
                        .IsRequired()
                        .HasMaxLength(36)
                        .HasColumnType("varchar(36)");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("varchar(20)");

                    b.HasKey("Id");

                    b.ToTable("Usuarios");
                });

            modelBuilder.Entity("ActividadCuenta", b =>
                {
                    b.HasOne("Api.Models.Actividad", null)
                        .WithMany()
                        .HasForeignKey("ActividadesCodigo")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Api.Models.Cuenta", null)
                        .WithMany()
                        .HasForeignKey("CuentasId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Api.Models.Cuenta", b =>
                {
                    b.HasOne("Api.Models.Usuario", "Usuario")
                        .WithMany()
                        .HasForeignKey("UsuarioId");

                    b.Navigation("Usuario");
                });
#pragma warning restore 612, 618
        }
    }
}
