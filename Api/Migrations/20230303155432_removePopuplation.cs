using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Api.Migrations
{
    /// <inheritdoc />
    public partial class removePopuplation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Actividades",
                keyColumn: "Codigo",
                keyValue: 503002);

            migrationBuilder.DeleteData(
                table: "Actividades",
                keyColumn: "Codigo",
                keyValue: 721001);

            migrationBuilder.DeleteData(
                table: "Actividades",
                keyColumn: "Codigo",
                keyValue: 722003);

            migrationBuilder.DeleteData(
                table: "Ubicaciones",
                keyColumns: new[] { "Barrio", "Canton", "Distrito", "Provincia" },
                keyValues: new object[] { 1, 1, 1, 1 });

            migrationBuilder.DeleteData(
                table: "Ubicaciones",
                keyColumns: new[] { "Barrio", "Canton", "Distrito", "Provincia" },
                keyValues: new object[] { 2, 1, 1, 1 });

            migrationBuilder.DeleteData(
                table: "Ubicaciones",
                keyColumns: new[] { "Barrio", "Canton", "Distrito", "Provincia" },
                keyValues: new object[] { 3, 1, 1, 1 });

            migrationBuilder.DeleteData(
                table: "Ubicaciones",
                keyColumns: new[] { "Barrio", "Canton", "Distrito", "Provincia" },
                keyValues: new object[] { 1, 8, 1, 6 });

            migrationBuilder.DeleteData(
                table: "Ubicaciones",
                keyColumns: new[] { "Barrio", "Canton", "Distrito", "Provincia" },
                keyValues: new object[] { 11, 8, 1, 6 });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Actividades",
                columns: new[] { "Codigo", "Nombre" },
                values: new object[,]
                {
                    { 503002, "VENTA DE REPUESTOS USADOS PARA AUTOMOVILES" },
                    { 721001, "CONSULTORES INFORMÁTICOS" },
                    { 722003, "DISEÑADOR GRAFICO, DE SOFWARE Y PAGINAS WEB" }
                });

            migrationBuilder.InsertData(
                table: "Ubicaciones",
                columns: new[] { "Barrio", "Canton", "Distrito", "Provincia", "NombreBarrio", "NombreCanton", "NombreDistrito", "NombreProvincia" },
                values: new object[,]
                {
                    { 1, 1, 1, 1, "Amón", "San José", "CARMEN", "San José" },
                    { 2, 1, 1, 1, "Aranjuez", "San José", "CARMEN", "San José" },
                    { 3, 1, 1, 1, "California (parte)", "San José", "CARMEN", "San José" },
                    { 1, 8, 1, 6, "Canada", "Coto Brus", "SAN VITO", "Puntarenas" },
                    { 11, 8, 1, 6, "Danto", "Coto Brus", "SAN VITO", "Puntarenas" }
                });
        }
    }
}
